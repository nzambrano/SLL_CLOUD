import sys
import os
import shutil
import subprocess

#correrocambiaresto
# install: pip install stringcase
# usage: https://pypi.org/project/stringcase/
import stringcase

#correrocambiaresto
basepath = "C:\\Users\\asd\\Desktop\\laburo\\prosegur\\proyectos\\sll_cloud\\backend\\SLLPE"
builddomainpath = basepath + "\\build\\generated\\src\\java\\com\\prosegur\\sllpe\\domain"
maindomainpath = basepath + "\\src\\main\\java\\com\\prosegur\\sllpe\\domain"
xmlpath = basepath + "\\build\\generated\\src\\resources"
mainrestpath = basepath + "\\src\\main\\java\\com\\prosegur\\sllpe\\web\\rest"
mainservicepath = basepath + "\\src\\main\\java\\com\\prosegur\\sllpe\\service"
mainrepositorypath = basepath + "\\src\\main\\java\\com\\prosegur\\sllpe\\repository"


hibernaterevengxml = os.path.join(xmlpath, 'hibernate.reveng.xml')

#correrocambiaresto
# asegurarse de no tener el puerto repetido en el hibernate.cfg.xml
# asegurarse que en hibernate.reveng.xml figure esta linea
    # <schema-selection match-catalog=".*" match-schema="sll.*" match-table="xxxxxxxxxxxxxxxxxxxxx" />


#correrocambiaresto
# Usar generarComandoPython.xlsx para generar el comando para disparar el script: 
#                            Nueva Tabla        Pks Nueva Tabla                              Tabla Template     PKs Tabla template
# python generarentidades.py m4sll_doc_litigios dol_secuencia,lit_id_litigio,id_organization m4sll_lit_seguimie lit_id_litigio,id_organization,lis_secuencia



# oldTblNameSnake = stringcase.snakecase("m4sll_lit_seguimie")
# newTblNameSnake = stringcase.snakecase("m4sll_doc_litigios")

newTblNameSnake = stringcase.snakecase(sys.argv[1])
newPksConcat = sys.argv[2]

oldTblNameSnake = stringcase.snakecase(sys.argv[3])
oldPksConcat = sys.argv[4]


oldtblnamepascal = stringcase.pascalcase(oldTblNameSnake)
newtblnamepascal = stringcase.pascalcase(newTblNameSnake)

newtblnamepascalRepository = newtblnamepascal + "Repository.java"
newtblnamepascalServices = newtblnamepascal + "Services.java"
newtblnamepascalResource = newtblnamepascal + "Resource.java"
newtblnamepascalHome = newtblnamepascal + "Home.java"

oldtblnamepascalRepository = oldtblnamepascal + "Repository.java"
oldtblnamepascalServices = oldtblnamepascal + "Services.java"
oldtblnamepascalResource = oldtblnamepascal + "Resource.java"


def searchnreplace(filesIn, lstIn):

    for fileIn in filesIn:
        # Read in the file
        with open(fileIn, "r") as file:
            filedata = file.read()

        for old, new in lstIn:
            # Replace the target string
            filedata = filedata.replace(stringcase.snakecase(old), stringcase.snakecase(new))
            filedata = filedata.replace(stringcase.camelcase(old), stringcase.camelcase(new))
            filedata = filedata.replace(stringcase.pascalcase(old), stringcase.pascalcase(new))

        # Write the file out again
        with open(fileIn, "w") as file:
            file.write(filedata)


# wscript % replacescript % "%xmlpath%\hibernate.cfg.xml" "%oldTblNameSnake%" "%newTblNameSnake%"
searchnreplace([hibernaterevengxml], [('xxxxxxxxxxxxxxxxxxxxx',newTblNameSnake)])

# asegurarse de que no este la carpeta generated antes de correr hbm2dao
shutil.rmtree(builddomainpath, ignore_errors=True)

# disparar comando gradlew
subprocess.run(["gradlew", "hbm2dao", "--stacktrace"], cwd=basepath, shell=True)

# move %builddomainpath%\%newtblnamepascal%* %maindomainpath%
filesLst = os.listdir(builddomainpath)

for filename in filesLst:
    if filename.startswith(newtblnamepascal):
        shutil.move(os.path.join(builddomainpath, filename), os.path.join(maindomainpath, filename))


searchnreplace([os.path.join(maindomainpath, newtblnamepascalHome)],[("@Stateless",""),("import javax.ejb.Stateless;","")] )

# copy /y %maindomainpath%\%oldtblnamepascalRepository% %maindomainpath%\%newtblnamepascalRepository%
# copy /y %maindomainpath%\%oldtblnamepascalServices% %maindomainpath%\%newtblnamepascalServices%
# copy /y %maindomainpath%\%oldtblnamepascalResource% %maindomainpath%\%newtblnamepascalResource%

dirsLst = []

oldFilenameAbsPathRepository = os.path.join(mainrepositorypath, oldtblnamepascalRepository)
oldFilenameAbsPathResource = os.path.join(mainrestpath, oldtblnamepascalResource)
oldFilenameAbsPathService = os.path.join(mainservicepath, oldtblnamepascalServices)

newFilenameAbsPathRepository = os.path.join(mainrepositorypath, newtblnamepascalRepository)
newFilenameAbsPathResource = os.path.join(mainrestpath, newtblnamepascalResource)
newFilenameAbsPathService = os.path.join(mainservicepath, newtblnamepascalServices)

shutil.copy(oldFilenameAbsPathRepository, newFilenameAbsPathRepository)
shutil.copy(oldFilenameAbsPathResource, newFilenameAbsPathResource)

# si no tiene secuencia, no crearla
try:
    shutil.copy(oldFilenameAbsPathService, newFilenameAbsPathService)
    dirsLst.append(newFilenameAbsPathService)

except:
    pass

dirsLst.append(newFilenameAbsPathRepository)
dirsLst.append(newFilenameAbsPathResource)


snkTpl = (oldTblNameSnake, newTblNameSnake)
searchnreplaceLst = [snkTpl]

searchnreplace(dirsLst, searchnreplaceLst)

# reemplazar columnas
newPkslst = newPksConcat.split(',')
oldPkslst = oldPksConcat.split(',')

searchnreplaceLst = zip(oldPkslst, newPkslst)

searchnreplace(dirsLst, searchnreplaceLst)

# deshacer cambios para la prox corrida
searchnreplace([hibernaterevengxml], [('newTblNameSnake',xxxxxxxxxxxxxxxxxxxxx)])
