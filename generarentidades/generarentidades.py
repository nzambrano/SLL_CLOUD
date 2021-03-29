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

# correrocambiaresto
# Cambiar el directorio base. la r es para que interprete literal la \ sino habria que escaparla poniendo \\
basePath = r"C:\Users\asd\Desktop\laburo\prosegur\proyectos\sll_cloud\backend\SLLPE"

buildDomainPath = basePath + r"\build\generated\src\java\com\prosegur\sllpe\domain"
mainDomainPath = basePath + r"\src\main\java\com\prosegur\sllpe\domain"
xmlPath = basePath + r"\build\generated\src\resources"
mainRestPath = basePath + r"\src\main\java\com\prosegur\sllpe\web\rest"
mainServicePath = basePath + r"\src\main\java\com\prosegur\sllpe\service"
mainRepositoryPath = basePath + r"\src\main\java\com\prosegur\sllpe\repository"

currPath = os.path.dirname(os.path.realpath(__file__))
templatesPath = currPath + r"\files\templates"
xmlTmplPath = currPath + r"\files\hibernate"
hibernateRevengXml = os.path.join(xmlPath, "hibernate.reveng.xml")
hibernateTmplRevengXml = os.path.join(xmlTmplPath, "hibernate.reveng.xml")

hibernateCfgXml = os.path.join(xmlPath, "hibernate.cfg.xml")
hibernateTmplCfgXml = os.path.join(xmlTmplPath, "hibernate.cfg.xml")

# correrocambiaresto
# asegurarse de no tener el puerto repetido en el hibernate.cfg.xml
# asegurarse que en hibernate.reveng.xml figure xxxxxxxxxxxxxxxxxxxxx en esta linea
# <schema-selection match-catalog=".*" match-schema="sll.*" match-table="xxxxxxxxxxxxxxxxxxxxx" />


# correrocambiaresto
# Usar generarComandoPython.xlsx para generar el comando para disparar el script:
# python generarentidades.py m4sll_doc_litigios dol_secuencia,lit_id_litigio,id_organization m4sll_lit_seguimie lit_id_litigio,id_organization,lis_secuencia


# Para Testing:
# python generarentidades.py m4sll_doc_litigios dol_secuencia,lit_id_litigio,id_organization m4sll_lit_seguimie lit_id_litigio,id_organization,lis_secuencia
# oldTblNameSnake = "m4sll_lit_seguimie"
# newTblNameSnake = "m4sll_doc_litigios"
# "lit_id_litigio,id_organization,lis_secuencia"
# "dol_secuencia,lit_id_litigio,id_organization"

# Cargar nombre de tablas y path
newTblNameSnake = stringcase.snakecase(sys.argv[1])
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
currTemplatePath = os.path.join(templatesPath, sys.argv[4])
newPksNamesConcat = sys.argv[2]
newPksNamesLst = newPksNamesConcat.split(",")
newPksDatatypesConcat = sys.argv[3]
newPksDatatypesLst = newPksDatatypesConcat.split(",")

# Creo listas para separar la secuencia de las no secuencias y lo mismo para sus datatypes correspindientes
newPksNamesSecLst = []
newPksNamesNotSecLst = []
newPksDatatypesSecLst = []
newPksDatatypesNotSecLst = []

for idx in range(len(newPksNamesLst)):
    if "secuencia" in newPksNamesLst[idx]:
        newPksNamesSecLst.append(newPksNamesLst[idx])
        newPksDatatypesSecLst.append(newPksDatatypesLst[idx])
    else:
        newPksNamesNotSecLst.append(newPksNamesLst[idx])
        newPksDatatypesNotSecLst.append(newPksDatatypesLst[idx])


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
    shutil.copy(hibernateCfgXml, hibernateCfgXml + '.bak')

    # Pisar el original con nuestro template
    shutil.copy(hibernateTmplCfgXml, hibernateCfgXml)

# Procesar el hibernate.reveng.xml
if not filecmp.cmp(hibernateRevengXml, hibernateTmplRevengXml):
    # Primero hacer un backup del archivo original
    shutil.copy(hibernateRevengXml, hibernateRevengXml + '.bak')

    # Pisar el original con nuestro template
    shutil.copy(hibernateTmplRevengXml, hibernateRevengXml)

    # Setear el nuevo hibernate.cfg.xml para matchear la tabla
    searchnreplace([hibernateRevengXml], [("xxxxxxxxxxxxxxxxxxxxx", newTblNameSnake)])

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

    replStr = (
        searchStr.replace("sec_placeholder", "cast(sec_placeholder as integer)")
        if newPksDatatypesSecLst[0] == "String"
        else searchStr
    )
    replStr = searchStr.replace(
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


searchStr = "ByInput(colsnotsec_placeholder);"
startStr = "ByInput("
sepStr = ", "
endStr = ");"

replStr = sepStr.join([stringcase.snakecase(pk) for pk in newPksNamesNotSecLst])

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

############## Procesamiento de columnas - Fin ##############


# Buscar y reemplazar el nombre de la tabla en los archivos Repository Resource y Services
# Este paso se debe hacer después de columnas!
searchnreplace(dirsLst, [(oldTblNameSnake, newTblNameSnake)])


# Deshacer cambios hechos por nuestro script

if os.path.exists(hibernateRevengXml + '.bak'):
    shutil.copy(hibernateRevengXml + '.bak', hibernateRevengXml)
    os.remove(hibernateRevengXml + '.bak')

if os.path.exists(hibernateCfgXml + '.bak'):
    shutil.copy(hibernateCfgXml + '.bak', hibernateCfgXml)
    os.remove(hibernateCfgXml + '.bak')