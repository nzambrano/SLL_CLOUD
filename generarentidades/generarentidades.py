import sys
import os
import shutil
import subprocess

# install: pip install stringcase
# usage: https://pypi.org/project/stringcase/
import stringcase


basepath = "C:\\Users\\asd\\Desktop\\laburo\\prosegur\\proyectos\\sll_cloud\\backend\\SLLPE"
builddomainpath = basepath + "\\build\\generated\\src\\java\\com\\prosegur\\sllpe\\domain"
maindomainpath = basepath + "\\src\\main\\java\\com\\prosegur\\sllpe\\domain"
xmlpath = basepath + "\\build\\generated\\src\\resources"
mainrestpath = basepath + "\\src\\main\\java\\com\\prosegur\\sllpe\\web\\rest"
mainservicepath = basepath + "\\src\\main\\java\\com\\prosegur\\sllpe\\service"
mainrepositorypath = basepath + "\\src\\main\\java\\com\\prosegur\\sllpe\\repository"


hibernaterevengxml = os.path.join(xmlpath, 'hibernate.reveng.xml')

# snake case = m4sll_lit_seguimie
# oldtblnamesnake = stringcase.snakecase("M4sllLitigios")
# newtblnamesnake = stringcase.snakecase("m4sll_tp_entidades")
oldtblnamesnake = sys.argv[1]
newtblnamesnake = sys.argv[2]

oldtblnamepascal = stringcase.pascalcase(oldtblnamesnake)
newtblnamepascal = stringcase.pascalcase(newtblnamesnake)

oldtblnamecamel = stringcase.camelcase(oldtblnamesnake)
newtblnamecamel = stringcase.camelcase(newtblnamesnake)

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
            filedata = filedata.replace(old, new)

        # Write the file out again
        with open(fileIn, "w") as file:
            file.write(filedata)


# wscript % replacescript % "%xmlpath%\hibernate.cfg.xml" "%oldtblnamesnake%" "%newtblnamesnake%"
searchnreplace([hibernaterevengxml], [('xxxxxxxxxxxxxxxxxxxxx',newtblnamesnake)])

# asegurarse de que no este la carpeta generated antes de correr hbm2dao
shutil.rmtree(builddomainpath, ignore_errors=True)

# subprocess.check_call(['your_command', 'arg 1', 'arg 2'], cwd=working_dir)
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


snkTpl = (oldtblnamesnake, newtblnamesnake)
pasTpl = (oldtblnamepascal, newtblnamepascal)
cmlTpl = (oldtblnamecamel, newtblnamecamel)

searchnreplace(dirsLst, [snkTpl, pasTpl, cmlTpl])



# deshacer cambios para la prox corrida
searchnreplace([hibernaterevengxml], [('newtblnamesnake',xxxxxxxxxxxxxxxxxxxxx)])
