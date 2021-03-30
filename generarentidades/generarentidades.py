import sys
import os
import shutil
import subprocess
import filecmp

# Por hacer:
# si el seq es string --> replace del max por cast max

# correrocambiaresto
# instalar: pip install stringcase
# uso: https://pypi.org/project/stringcase/
import stringcase


currPath = os.path.dirname(os.path.realpath(__file__))
templatesPath = currPath + r"\files\templates"
xmlTmplPath = currPath + r"\files\hibernate"
aStylePath = currPath + r"\files\styling"

basePath = os.path.dirname(currPath) + r"\backend\SLLPE"
mainPath = basePath + r"\src\main\java\com\prosegur\sllpe"

buildDomainPath = basePath + r"\build\generated\src\java\com\prosegur\sllpe\domain"
xmlPath = basePath + r"\build\generated\src\resources"
mainDomainPath = mainPath + r"\domain"
mainRestPath = mainPath + r"\web\rest"
mainServicePath = mainPath + r"\service"
mainRepositoryPath = mainPath + r"\repository"

hibernateRevengXml = os.path.join(xmlPath, "hibernate.reveng.xml")
hibernateTmplRevengXml = os.path.join(xmlTmplPath, "hibernate.reveng.xml")

hibernateCfgXml = os.path.join(xmlPath, "hibernate.cfg.xml")
hibernateTmplCfgXml = os.path.join(xmlTmplPath, "hibernate.cfg.xml")

# Cargar nombre de tablas y path
newSchNameSnake = stringcase.snakecase(sys.argv[1])
newTblNameSnake = stringcase.snakecase(sys.argv[2])
oldTblNameSnake = stringcase.snakecase("table_name_placeholder")

oldTblNamePascal = stringcase.pascalcase(oldTblNameSnake)
newTblNamePascal = stringcase.pascalcase(newTblNameSnake)

newTblNamePascalRepository = newTblNamePascal + "Repository.java"
newTblNamePascalServices = newTblNamePascal + "Services.java"
newTblNamePascalResource = newTblNamePascal + "Resource.java"
newTblNamePascalHome = newTblNamePascal + "Home.java"

oldTblNamePascalRepository = oldTblNamePascal + "Repository.java"
oldTblNamePascalServices = oldTblNamePascal + "Services.java"
oldTblNamePascalResource = oldTblNamePascal + "Resource.java"

# Guardo las columnas en listas
newPksNotSecConcat = sys.argv[3]
newPksNamesNotSecLst = [pkc.split("|")[0] for pkc in newPksNotSecConcat.split(",")]
newPksDatatypesNotSecLst = [pkc.split("|")[1] for pkc in newPksNotSecConcat.split(",")]

newPksSecConcat = sys.argv[4]
newPksNamesSecLst = [pkc.split("|")[0] for pkc in newPksSecConcat.split(",")] if newPksSecConcat else []
newPksDatatypesSecLst = [pkc.split("|")[1] for pkc in newPksSecConcat.split(",")] if newPksSecConcat else []

newCustColsNamesConcat = "".join(sys.argv[5])
newCustColsNamesLst = (
    newCustColsNamesConcat.split(",") if newCustColsNamesConcat else []
)
newPksNamesLst = newPksNamesNotSecLst + newPksNamesSecLst
newPksDatatypesLst = newPksDatatypesNotSecLst + newPksDatatypesSecLst

newCustColsDatatypesLst = [
    newPksDatatypesLst[newPksNamesLst.index(dt)] for dt in newCustColsNamesLst
]

currTemplatePath = os.path.join(templatesPath, sys.argv[6])


def removeComments(filesIn, lstIn):

    for fileIn in filesIn:
        for delKey in lstIn:
            with open(fileIn, "r") as f:
                lines = f.readlines()
            with open(fileIn, "w") as f:
                for line in lines:
                    if not line.lstrip().startswith(delKey):
                        f.write(line)


def searchnreplace(filesIn, lstIn):
    r"""
    Funcion para buscar y reemplazar

    Args:
        filesIn (lista): lista de archivos a iterar Ej: ['C:\dir1\file1.txt','C:\dir2\file2.txt']
        lstIn (lista de tupples): Lista de pares (viejo, nuevo) a iterar. Ej: [('nombreviejo1','nombrenuevo1'),('nombreviejo2','nombrenuevo2')]
    """
    for fileIn in filesIn:
        # Read in the file
        with open(fileIn, "r") as file:
            filedata = file.read()

        for old, new in lstIn:
            # Replace the target string
            filedata = filedata.replace(old, new)
            filedata = filedata.replace(
                stringcase.snakecase(old), stringcase.snakecase(new)
            )
            filedata = filedata.replace(
                stringcase.camelcase(old), stringcase.camelcase(new)
            )
            filedata = filedata.replace(
                stringcase.pascalcase(old), stringcase.pascalcase(new)
            )

        # Write the file out again
        with open(fileIn, "w") as file:
            file.write(filedata)


# Procesar el hibernate.cfg.xml
if not filecmp.cmp(hibernateCfgXml, hibernateTmplCfgXml):
    # Primero hacer un backup del archivo original
    shutil.copy(hibernateCfgXml, hibernateCfgXml + ".bak")

    # Pisar el original con nuestro template
    shutil.copy(hibernateTmplCfgXml, hibernateCfgXml)

# Procesar el hibernate.reveng.xml
if not filecmp.cmp(hibernateRevengXml, hibernateTmplRevengXml):
    # Primero hacer un backup del archivo original
    shutil.copy(hibernateRevengXml, hibernateRevengXml + ".bak")

    # Pisar el original con nuestro template
    shutil.copy(hibernateTmplRevengXml, hibernateRevengXml)

    # Setear el nuevo hibernate.cfg.xml para matchear la tabla
    searchnreplace([hibernateRevengXml], [("match-table-placeholder", newTblNameSnake)])
    searchnreplace(
        [hibernateRevengXml], [("match-schema-placeholder", newSchNameSnake)]
    )

# Asegurarse de que no este la carpeta generated antes de correr hbm2dao
shutil.rmtree(buildDomainPath, ignore_errors=True)

# Disparar comando gradlew
subprocess.run(["gradlew", "hbm2dao", "--stacktrace"], cwd=basePath, shell=True)

# Mover los 3 archivos generados a main
filesLst = os.listdir(buildDomainPath)

for filename in filesLst:
    if filename.startswith(newTblNamePascal):
        shutil.move(
            os.path.join(buildDomainPath, filename),
            os.path.join(mainDomainPath, filename),
        )


# Eliminar el bug de Stateless en el archivo Home
searchnreplace(
    [os.path.join(mainDomainPath, newTblNamePascalHome)],
    [("@Stateless", ""), ("import javax.ejb.Stateless;", "")],
)

# Copiar templates Repository Resource y Services y renmombarlos
oldFilenameAbsPathRepository = os.path.join(
    currTemplatePath, oldTblNamePascalRepository
)
oldFilenameAbsPathResource = os.path.join(currTemplatePath, oldTblNamePascalResource)
oldFilenameAbsPathService = os.path.join(currTemplatePath, oldTblNamePascalServices)

newFilenameAbsPathRepository = os.path.join(
    mainRepositoryPath, newTblNamePascalRepository
)
newFilenameAbsPathResource = os.path.join(mainRestPath, newTblNamePascalResource)
newFilenameAbsPathService = os.path.join(mainServicePath, newTblNamePascalServices)

shutil.copy(oldFilenameAbsPathRepository, newFilenameAbsPathRepository)
shutil.copy(oldFilenameAbsPathResource, newFilenameAbsPathResource)

# Generar una lista con los paths Old y New de los 3 archivos
dirsLst = []

dirsLst.append(newFilenameAbsPathRepository)
dirsLst.append(newFilenameAbsPathResource)

# Si la tabla a procesar tiene  secuentcia, crear su servicio
if newPksNamesSecLst:
    shutil.copy(oldFilenameAbsPathService, newFilenameAbsPathService)
    dirsLst.append(newFilenameAbsPathService)

############## Procesamiento de columnas - comienzo ##############

searchNReplaceLst = []

########## Repository ##########

if newPksNamesSecLst:
    searchStr = "COALESCE(max(sec_placeholder),0)+1"
    startStr = ""
    sepStr = ""
    endStr = ""

    replStr = searchStr
    
    if newPksDatatypesSecLst[0] == "String":
        replStr = replStr.replace("sec_placeholder", "cast(sec_placeholder as integer)")

    replStr = replStr.replace(
        "sec_placeholder", stringcase.snakecase(newPksNamesSecLst[0])
    )

    newStr = startStr + replStr + endStr
    searchNReplaceLst.append((searchStr, newStr))

    searchStr = "where_and_colsnotsec_placeholder"
    startStr = "where "
    sepStr = " and "
    endStr = ""

    replStr = sepStr.join(
        [
            stringcase.snakecase(pk) + " = :" + stringcase.snakecase(pk)
            for pk in newPksNamesNotSecLst
        ]
    )

    newStr = startStr + replStr + endStr
    searchNReplaceLst.append((searchStr, newStr))

    searchStr = "public ColsecDatatype obtenerUltimaSecuencia"
    startStr = ""
    sepStr = ""
    endStr = ""

    replStr = searchStr.replace("ColsecDatatype",newPksDatatypesSecLst[0])

    newStr = startStr + replStr + endStr

    searchNReplaceLst.append((searchStr, newStr))

    searchStr = "ByColsNotSecPlaceholder"
    startStr = "By"
    sepStr = ""
    endStr = ""

    replStr = searchStr.replace(
        "ByColsNotSecPlaceholder",
        "".join([stringcase.pascalcase(pk) for pk in newPksNamesNotSecLst]),
    )

    newStr = startStr + replStr + endStr

    searchNReplaceLst.append((searchStr, newStr))

    searchStr = "(param_colsnotsec_placeholder"
    startStr = "("
    sepStr = ", "
    endStr = ""

    replStr = sepStr.join(
        [
            '@Param("'
            + stringcase.snakecase(newPksNamesNotSecLst[idx])
            + '")'
            + " "
            + newPksDatatypesNotSecLst[idx]
            + " "
            + stringcase.snakecase(newPksNamesNotSecLst[idx])
            for idx in range(len(newPksNamesNotSecLst))
        ]
    )

    newStr = startStr + replStr + endStr
    searchNReplaceLst.append((searchStr, newStr))

if newCustColsNamesLst:

    # Descomentar las líneas CustomGet1 ya que van a ser usadas

    searchStr = "//CustomLinesCustomGet1"
    startStr = ""
    sepStr = ""
    endStr = ""

    replStr = ""

    newStr = startStr + replStr + endStr

    searchNReplaceLst.append((searchStr, newStr))

    searchStr = "where_and_colscustom_placeholder"
    startStr = "where "
    sepStr = " and "
    endStr = ""

    replStr = sepStr.join(
        [
            stringcase.snakecase(pk) + " = :" + stringcase.snakecase(pk)
            for pk in newCustColsNamesLst
        ]
    )

    newStr = startStr + replStr + endStr
    searchNReplaceLst.append((searchStr, newStr))

    # Este aplica a Repository y Resources también
    searchStr = "ByColsCustomPlaceholder"
    startStr = "By"
    sepStr = ""
    endStr = ""

    replStr = searchStr.replace(
        "ByColsCustomPlaceholder",
        "".join([stringcase.pascalcase(cc) for cc in newCustColsNamesLst]),
    )

    newStr = startStr + replStr + endStr

    searchNReplaceLst.append((searchStr, newStr))

    searchStr = "(param_colscustom_placeholder"
    startStr = "("
    sepStr = ", "
    endStr = ""

    replStr = sepStr.join(
        [
            '@Param("'
            + stringcase.snakecase(newCustColsNamesLst[idx])
            + '")'
            + " "
            + newCustColsDatatypesLst[idx]
            + " "
            + stringcase.snakecase(newCustColsNamesLst[idx])
            for idx in range(len(newCustColsNamesLst))
        ]
    )

    newStr = startStr + replStr + endStr
    searchNReplaceLst.append((searchStr, newStr))

########## Services ##########
if newPksNamesSecLst:
    searchStr = "(tableNamePlaceholder.getId().getColsNotSecPlaceholder())"
    startStr = "("
    sepStr = ", "
    endStr = ")"

    replStr = sepStr.join(
        [
            "tableNamePlaceholder.getId().get" + stringcase.pascalcase(pk) + "()"
            for pk in newPksNamesNotSecLst
        ]
    )
    newStr = startStr + replStr + endStr
    searchNReplaceLst.append((searchStr, newStr))

    searchStr = "public ColsecDatatype UltimaSecuencia"
    startStr = ""
    sepStr = ""
    endStr = ""

    replStr = searchStr.replace("ColsecDatatype",newPksDatatypesSecLst[0])

    newStr = startStr + replStr + endStr

    searchNReplaceLst.append((searchStr, newStr))

########## Resources ##########
if newPksNamesSecLst:
    searchStr = "ColsecDatatype id_sec_placeholder = tableNamePlaceholderServices.UltimaSecuencia(table_name_placeholder);"
    startStr = ""
    sepStr = ""
    endStr = ""

    replStr = searchStr.replace("ColsecDatatype", newPksDatatypesSecLst[0])
    replStr = replStr.replace(
        "sec_placeholder", stringcase.snakecase(newPksNamesSecLst[0])
    )

    newStr = startStr + replStr + endStr

    searchNReplaceLst.append((searchStr, newStr))

    searchStr = "id.setSecPlaceholder(id_sec_placeholder);"
    startStr = ""
    sepStr = ""
    endStr = ""

    replStr = searchStr.replace(
        "SecPlaceholder", stringcase.pascalcase(newPksNamesSecLst[0])
    )
    replStr = replStr.replace(
        "sec_placeholder", stringcase.snakecase(newPksNamesSecLst[0])
    )

    newStr = startStr + replStr + endStr
    searchNReplaceLst.append((searchStr, newStr))

searchStr = "id.setColsNotSecPlaceholder(table_name_placeholder.getId().getColsNotSecPlaceholder());"
startStr = ""
sepStr = " "
endStr = ""

replStr = sepStr.join(
    [
        "id.set"
        + stringcase.pascalcase(pk)
        + "(table_name_placeholder.getId().get"
        + stringcase.pascalcase(pk)
        + "());"
        for pk in newPksNamesNotSecLst
    ]
)

newStr = startStr + replStr + endStr
searchNReplaceLst.append((searchStr, newStr))

searchStr = r"{colsnotsec_placeholder}"
startStr = ""
sepStr = "/"
endStr = ""

replStr = sepStr.join(
    ["{" + stringcase.snakecase(pk) + "}" for pk in newPksNamesNotSecLst]
)

newStr = startStr + replStr + endStr
searchNReplaceLst.append((searchStr, newStr))

if newPksNamesSecLst:
    searchStr = r"{sec_placeholder}"
    startStr = ""
    sepStr = ""
    endStr = ""

    replStr = searchStr.replace(
        "sec_placeholder", stringcase.snakecase(newPksNamesSecLst[0])
    )

    newStr = startStr + replStr + endStr
    searchNReplaceLst.append((searchStr, newStr))

searchStr = r': {}", debugcolsnotsec_placeholder'
startStr = r': {}", '
sepStr = ' + "|" + '
endStr = ""

replStr = sepStr.join([stringcase.snakecase(pk) for pk in newPksNamesNotSecLst])

newStr = startStr + replStr + endStr
searchNReplaceLst.append((searchStr, newStr))

if newPksNamesSecLst:
    searchStr = "debugsec_placeholder"
    startStr = ""
    sepStr = ""
    endStr = ""

    replStr = searchStr.replace(
        "debugsec_placeholder", stringcase.snakecase(newPksNamesSecLst[0])
    )

    newStr = startStr + replStr + endStr
    searchNReplaceLst.append((searchStr, newStr))

searchStr = "(colsnotsec_placeholder);"
startStr = "("
sepStr = ", "
endStr = ");"

replStr = sepStr.join([stringcase.snakecase(pk) for pk in newPksNamesNotSecLst])

newStr = startStr + replStr + endStr
searchNReplaceLst.append((searchStr, newStr))

if newCustColsNamesLst:
    searchStr = r"{colscustom_placeholder}"
    startStr = ""
    sepStr = "/"
    endStr = ""

    replStr = sepStr.join(
        ["{" + stringcase.snakecase(cc) + "}" for cc in newCustColsNamesLst]
    )

    newStr = startStr + replStr + endStr
    searchNReplaceLst.append((searchStr, newStr))

    searchStr = '(@PathVariable("colscustom_placeholder") ColscustomDatatype colscustom_placeholder'
    startStr = "("
    sepStr = ", "
    endStr = ""

    replStr = sepStr.join(
        [
            '@PathVariable("'
            + stringcase.snakecase(newCustColsNamesLst[idx])
            + '") '
            + newCustColsDatatypesLst[idx]
            + " "
            + stringcase.snakecase(newCustColsNamesLst[idx])
            for idx in range(len(newCustColsNamesLst))
        ]
    )

    newStr = startStr + replStr + endStr
    searchNReplaceLst.append((searchStr, newStr))

    searchStr = r': {}", debugcolscustom_placeholder'
    startStr = r': {}", '
    sepStr = ' + "|" + '
    endStr = ""

    replStr = sepStr.join([stringcase.snakecase(cc) for cc in newCustColsNamesLst])

    newStr = startStr + replStr + endStr
    searchNReplaceLst.append((searchStr, newStr))

    searchStr = "(colscustom_placeholder);"
    startStr = "("
    sepStr = ", "
    endStr = ");"

    replStr = sepStr.join([stringcase.snakecase(cc) for cc in newCustColsNamesLst])

    newStr = startStr + replStr + endStr
    searchNReplaceLst.append((searchStr, newStr))

searchStr = (
    '(@PathVariable("colsnotsec_placeholder") ColsnotsecDatatype colsnotsec_placeholder'
)
startStr = "("
sepStr = ", "
endStr = ""

replStr = sepStr.join(
    [
        '@PathVariable("'
        + stringcase.snakecase(newPksNamesNotSecLst[idx])
        + '") '
        + newPksDatatypesNotSecLst[idx]
        + " "
        + stringcase.snakecase(newPksNamesNotSecLst[idx])
        for idx in range(len(newPksNamesNotSecLst))
    ]
)

newStr = startStr + replStr + endStr
searchNReplaceLst.append((searchStr, newStr))

if newPksNamesSecLst:
    searchStr = '@PathVariable("sec_placeholder") ColsecDatatype sec_placeholder'
    startStr = ""
    sepStr = ""
    endStr = ""

    replStr = searchStr.replace("ColsecDatatype", newPksDatatypesSecLst[0])
    replStr = replStr.replace(
        "sec_placeholder", stringcase.snakecase(newPksNamesSecLst[0])
    )

    newStr = startStr + replStr + endStr
    searchNReplaceLst.append((searchStr, newStr))

searchStr = "id.setColsNotSecPlaceholder(cols_not_sec_placeholder);"
startStr = ""
sepStr = " "
endStr = ""

replStr = sepStr.join(
    [
        "id.set" + stringcase.pascalcase(pk) + "(" + stringcase.snakecase(pk) + ");"
        for pk in newPksNamesNotSecLst
    ]
)

newStr = startStr + replStr + endStr
searchNReplaceLst.append((searchStr, newStr))

if newPksNamesSecLst:
    searchStr = "id.setSecPlaceholder(sec_placeholder);"
    startStr = ""
    sepStr = ""
    endStr = ""

    replStr = searchStr.replace(
        "sec_placeholder", stringcase.snakecase(newPksNamesSecLst[0])
    )
    replStr = replStr.replace(
        "SecPlaceholder", stringcase.pascalcase(newPksNamesSecLst[0])
    )

    newStr = startStr + replStr + endStr
    searchNReplaceLst.append((searchStr, newStr))

# Buscar y reemplazar los pares (viejo, nuevo) de las columnas en los archivos Repository Resource y Services
searchnreplace(dirsLst, searchNReplaceLst)

# Eliminar líneas que no han sido reemplazadas
removeComments(dirsLst, ["//CustomLines"])

############## Procesamiento de columnas - Fin ##############

# Buscar y reemplazar el nombre de la tabla en los archivos Repository Resource y Services
# Este paso se debe hacer después de columnas!
searchnreplace(dirsLst, [(oldTblNameSnake, newTblNameSnake)])

# Aplicar indentacion y formato a los archivos generados
# http://astyle.sourceforge.net/astyle.html
# --style=java   Java style uses attached braces.
# --recursive    For each directory in the command line, process all subdirectories recursively.
# --suffix=none  Do not retain a backup of the original file. The original file is purged after it is formatted.

for genFile in dirsLst:
    subprocess.run(
        [
            os.path.join(aStylePath, "AStyle.exe"),
            "--style=java",
            "--recursive",
            "--suffix=none",
            f"{newTblNamePascal}*.java",
        ],
        cwd=mainPath,
        shell=True,
    )

# Deshacer cambios hechos por nuestro script

if os.path.exists(hibernateRevengXml + ".bak"):
    shutil.copy(hibernateRevengXml + ".bak", hibernateRevengXml)
    os.remove(hibernateRevengXml + ".bak")

if os.path.exists(hibernateCfgXml + ".bak"):
    shutil.copy(hibernateCfgXml + ".bak", hibernateCfgXml)
    os.remove(hibernateCfgXml + ".bak")
