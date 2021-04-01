import os
import glob
import re
import subprocess

curr_path = os.path.dirname(os.path.realpath(__file__))
a_style_path = curr_path + r"\files\styling"
base_path = os.path.dirname(curr_path) + r"\backend\SLLPE"
main_path = base_path + r"\src\main\java\com\prosegur\sllpe"
main_domain_path = main_path + r"\domain"
main_rest_path = main_path + r"\web\rest"
main_service_path = main_path + r"\service"
main_repository_path = main_path + r"\repository"


files_path_lst = glob.glob(os.path.join(main_path, f"**\\*.java"), recursive=True)

del_key = ".*// Generated.*by Hibernate Tools.*"


for file_in in files_path_lst:
    with open(file_in, "r") as f:
        lines = f.readlines()
    with open(file_in, "w") as f:
        for line in lines:
            if not re.search(del_key, line):
                f.write(line)

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
