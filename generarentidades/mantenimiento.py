# pip install pyperclip
# pip install stringcase
# pip install camel-snake-pep8 --upgrade

import os
import glob
import re
import subprocess
import shutil
import pyperclip
import stringcase

curr_path = os.path.dirname(os.path.realpath(__file__))
a_style_path = curr_path + r"\files\styling"
base_path = os.path.dirname(curr_path) + r"\backend\SLLPE"
main_path = base_path + r"\src\main\java\com\prosegur\sllpe"
main_domain_path = main_path + r"\domain"
main_rest_path = main_path + r"\web\rest"
main_service_path = main_path + r"\service"
main_repository_path = main_path + r"\repository"

# Eliminar las líneas del tipo "Generated [TimeStamp] by Hibernate Tools..." así GIT no las detecta como cambio

files_path_lst = glob.glob(os.path.join(main_path, f"**\\*.java"), recursive=True)

del_key = ".*// Generated.*by Hibernate Tools.*"

for file_in in files_path_lst:
    with open(file_in, "r") as f:
        lines = f.readlines()
    with open(file_in, "w") as f:
        for line in lines:
            if not re.search(del_key, line):
                f.write(line)

# Formatear todos los archivos Java del Repository, Resources y Domain, para que al generarlas automáticamente, GIT solo detecte cambios de texto y no indentacion

wk_paths = [main_domain_path, main_rest_path, main_service_path, main_repository_path]
for wk_path in wk_paths:
    subprocess.run(
        [
            os.path.join(a_style_path, "AStyle.exe"),
            "--style=java",
            "--recursive",
            "--suffix=none",
            "*.java",
        ],
        cwd=wk_path,
        shell=True,
    )

# Formatear con standard PEP8 nuestro script Python

subprocess.run(
    [
        "camel-snake-pep8",
        "--yes-to-all",
        ".",
        "generarentidades.py",
    ],
    cwd=curr_path,
    shell=True,
)

subprocess.run(
    [
        "autopep8",
        "--in-place",
        "--aggressive",
        "--aggressive",
        "generarentidades.py",
    ],
    cwd=curr_path,
    shell=True,
)

# Eliminar archivos temporales generados por "camel-snake-pep8"

shutil.rmtree(os.path.join(curr_path, ".ropeproject"), ignore_errors=True)


# En caso de haber quedado backups generados por Astyle, borrar
files = glob.glob(os.path.join(main_path, "**\\*.orig"), recursive=True)
for fl in files:
    try:
        print(f"deleting: {fl}")
        os.remove(fl)
    except OSError as e:
        print("Error: %s : %s" % (fl, e.strerror))


# Copiar al portapapeles una lista de los archivos procesados

f1 = []

for wk_path in wk_paths:
    for (dirpath, dirnames, filenames) in os.walk(wk_path):
        f1.extend(filenames)
        break

# eliminar de la list
f1 = [
    f.replace("Repository.java", "")
    .replace("Resource.java", "")
    .replace("Services.java", "")
    .replace("Id.java", "")
    .replace("Home.java", "")
    for f in f1
]


f1 = set([stringcase.snakecase(f.replace(".java", "")) for f in f1])


str = "\n".join(sorted(f1))
print(str)
pyperclip.copy(str)
