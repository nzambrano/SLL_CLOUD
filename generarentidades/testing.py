import os
import glob
import re

main_path = r"C:\Users\asd\Desktop\laburo\prosegur\proyectos\sll_cloud\backend\SLLPE\src\main\java\com\prosegur\sllpe"

rm_files_lst = glob.glob(os.path.join(main_path, f"**\\*.java"), recursive=True)

del_key = ".*// Generated.*by Hibernate Tools.*"


for file_in in rm_files_lst:
    with open(file_in, "r") as f:
        lines = f.readlines()
    with open(file_in, "w") as f:
        for line in lines:
            if not re.search(del_key, line):
                f.write(line)

print('finished')