import sys
import os
import shutil
import subprocess

#correrocambiaresto
# instalar: pip install stringcase
# uso: https://pypi.org/project/stringcase/
import stringcase

#correrocambiaresto
# Cambiar el directorio base. la r es para que interprete literal la \ sino habria que escaparla poniendo \\
basepath = r"C:\Users\asd\Desktop\laburo\prosegur\proyectos\sll_cloud\backend\SLLPE"

builddomainpath = basepath + r"\build\generated\src\java\com\prosegur\sllpe\domain"
maindomainpath = basepath + r"\src\main\java\com\prosegur\sllpe\domain"
xmlpath = basepath + r"\build\generated\src\resources"
mainrestpath = basepath + r"\src\main\java\com\prosegur\sllpe\web\rest"
mainservicepath = basepath + r"\src\main\java\com\prosegur\sllpe\service"
mainrepositorypath = basepath + r"\src\main\java\com\prosegur\sllpe\repository"


hibernaterevengxml = os.path.join(xmlpath, 'hibernate.reveng.xml')

#correrocambiaresto
# asegurarse de no tener el puerto repetido en el hibernate.cfg.xml
# asegurarse que en hibernate.reveng.xml figure xxxxxxxxxxxxxxxxxxxxx en esta linea
    # <schema-selection match-catalog=".*" match-schema="sll.*" match-table="xxxxxxxxxxxxxxxxxxxxx" />


#correrocambiaresto
# Usar generarComandoPython.xlsx para generar el comando para disparar el script: 
# python generarentidades.py m4sll_doc_litigios dol_secuencia,lit_id_litigio,id_organization m4sll_lit_seguimie lit_id_litigio,id_organization,lis_secuencia


# Para Testing:
# python generarentidades.py m4sll_doc_litigios dol_secuencia,lit_id_litigio,id_organization m4sll_lit_seguimie lit_id_litigio,id_organization,lis_secuencia
# oldTblNameSnake = "m4sll_lit_seguimie"
# newTblNameSnake = "m4sll_doc_litigios"
# oldPksConcat = "lit_id_litigio,id_organization,lis_secuencia"
# newPksConcat = "dol_secuencia,lit_id_litigio,id_organization"

# Cargar parametros en variables
newTblNameSnake = stringcase.snakecase(sys.argv[1])
newPksConcat = sys.argv[2]

oldTblNameSnake = stringcase.snakecase(sys.argv[3])
oldPksConcat = sys.argv[4]

oldTblNamePascal = stringcase.pascalcase(oldTblNameSnake)
newTblNamePascal = stringcase.pascalcase(newTblNameSnake)

newTblNamePascalRepository = newTblNamePascal + "Repository.java"
newTblNamePascalServices = newTblNamePascal + "Services.java"
newTblNamePascalResource = newTblNamePascal + "Resource.java"
newTblNamePascalHome = newTblNamePascal + "Home.java"

oldTblNamePascalRepository = oldTblNamePascal + "Repository.java"
oldTblNamePascalServices = oldTblNamePascal + "Services.java"
oldTblNamePascalResource = oldTblNamePascal + "Resource.java"

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
            filedata = filedata.replace(stringcase.snakecase(old), stringcase.snakecase(new))
            filedata = filedata.replace(stringcase.camelcase(old), stringcase.camelcase(new))
            filedata = filedata.replace(stringcase.pascalcase(old), stringcase.pascalcase(new))

        # Write the file out again
        with open(fileIn, "w") as file:
            file.write(filedata)


# Setear hibernate.cfg.xml para matchear la tabla
searchnreplace([hibernaterevengxml], [('xxxxxxxxxxxxxxxxxxxxx',newTblNameSnake)])

# Asegurarse de que no este la carpeta generated antes de correr hbm2dao
shutil.rmtree(builddomainpath, ignore_errors=True)

# Disparar comando gradlew
subprocess.run(["gradlew", "hbm2dao", "--stacktrace"], cwd=basepath, shell=True)

# Mover los 3 archivos generados a main
filesLst = os.listdir(builddomainpath)

for filename in filesLst:
    if filename.startswith(newTblNamePascal):
        shutil.move(os.path.join(builddomainpath, filename), os.path.join(maindomainpath, filename))


# Eliminar el bug de Stateless en el archivo Home
searchnreplace([os.path.join(maindomainpath, newTblNamePascalHome)],[("@Stateless",""),("import javax.ejb.Stateless;","")] )


# Copiar templates Repository Resource y Services y renmombarlos  
oldFilenameAbsPathRepository = os.path.join(mainrepositorypath, oldTblNamePascalRepository)
oldFilenameAbsPathResource = os.path.join(mainrestpath, oldTblNamePascalResource)
oldFilenameAbsPathService = os.path.join(mainservicepath, oldTblNamePascalServices)

newFilenameAbsPathRepository = os.path.join(mainrepositorypath, newTblNamePascalRepository)
newFilenameAbsPathResource = os.path.join(mainrestpath, newTblNamePascalResource)
newFilenameAbsPathService = os.path.join(mainservicepath, newTblNamePascalServices)

shutil.copy(oldFilenameAbsPathRepository, newFilenameAbsPathRepository)
shutil.copy(oldFilenameAbsPathResource, newFilenameAbsPathResource)

dirsLst = []

# Si el template no tiene el servicio secuencia, no crearla
try:
    shutil.copy(oldFilenameAbsPathService, newFilenameAbsPathService)
    dirsLst.append(newFilenameAbsPathService)

except:
    pass

dirsLst.append(newFilenameAbsPathRepository)
dirsLst.append(newFilenameAbsPathResource)


snkTpl = (oldTblNameSnake, newTblNameSnake)
searchNReplaceLst = [snkTpl]

# Buscar y reemplazar el nombre de la tabla en los archivos Repository Resource y Services
searchnreplace(dirsLst, searchNReplaceLst)

# Reemplazar columnas
newPksLst = newPksConcat.split(',')
oldPksLst = oldPksConcat.split(',')

searchNReplaceLst = list(zip(oldPksLst, newPksLst))

searchnreplace(dirsLst, searchNReplaceLst)

# Deshacer cambios para la prox corrida
searchnreplace([hibernaterevengxml], [('newTblNameSnake','xxxxxxxxxxxxxxxxxxxxx')])
