import sys
import os
import shutil
import subprocess
import filecmp

# Por hacer:
# Recibir parametros por json o via db, en vez de parametros

# correrocambiaresto
# instalar: pip install stringcase
# uso: https://pypi.org/project/stringcase/
import stringcase


curr_path = os.path.dirname(os.path.realpath(__file__))
templates_path = curr_path + r"\files\templates"
xml_tmpl_path = curr_path + r"\files\hibernate"
a_style_path = curr_path + r"\files\styling"

base_path = os.path.dirname(curr_path) + r"\backend\SLLPE"
main_path = base_path + r"\src\main\java\com\prosegur\sllpe"

build_domain_path = base_path + \
    r"\build\generated\src\java\com\prosegur\sllpe\domain"
xml_path = base_path + r"\build\generated\src\resources"
main_domain_path = main_path + r"\domain"
main_rest_path = main_path + r"\web\rest"
main_service_path = main_path + r"\service"
main_repository_path = main_path + r"\repository"

hibernate_reveng_xml = os.path.join(xml_path, "hibernate.reveng.xml")
hibernate_tmpl_reveng_xml = os.path.join(xml_tmpl_path, "hibernate.reveng.xml")

hibernate_cfg_xml = os.path.join(xml_path, "hibernate.cfg.xml")
hibernate_tmpl_cfg_xml = os.path.join(xml_tmpl_path, "hibernate.cfg.xml")

# Cargar nombre de tablas y path
new_sch_name_snake = stringcase.snakecase(sys.argv[1])
new_tbl_name_snake = stringcase.snakecase(sys.argv[2])
old_tbl_name_snake = stringcase.snakecase("table_name_placeholder")

old_tbl_name_pascal = stringcase.pascalcase(old_tbl_name_snake)
new_tbl_name_pascal = stringcase.pascalcase(new_tbl_name_snake)

new_tbl_name_pascal_repository = new_tbl_name_pascal + "Repository.java"
new_tbl_name_pascal_services = new_tbl_name_pascal + "Services.java"
new_tbl_name_pascal_resource = new_tbl_name_pascal + "Resource.java"
new_tbl_name_pascal_home = new_tbl_name_pascal + "Home.java"

old_tbl_name_pascal_repository = old_tbl_name_pascal + "Repository.java"
old_tbl_name_pascal_services = old_tbl_name_pascal + "Services.java"
old_tbl_name_pascal_resource = old_tbl_name_pascal + "Resource.java"

# Guardo las columnas en listas
new_pks_not_sec_concat = sys.argv[3]
new_pks_names_not_sec_lst = [
    pkc.split("|")[0] for pkc in new_pks_not_sec_concat.split(",")
]
new_pks_datatypes_not_sec_lst = [
    pkc.split("|")[1] for pkc in new_pks_not_sec_concat.split(",")
]

new_pks_sec_concat = sys.argv[4]
new_pks_names_sec_lst = (
    [pkc.split("|")[0] for pkc in new_pks_sec_concat.split(",")]
    if new_pks_sec_concat
    else []
)
new_pks_datatypes_sec_lst = (
    [pkc.split("|")[1] for pkc in new_pks_sec_concat.split(",")]
    if new_pks_sec_concat
    else []
)

new_cust_cols_names_concat = "".join(sys.argv[5])
new_cust_cols_names_lst = (
    new_cust_cols_names_concat.split(",") if new_cust_cols_names_concat else []
)
new_pks_names_lst = new_pks_names_not_sec_lst + new_pks_names_sec_lst
new_pks_datatypes_lst = new_pks_datatypes_not_sec_lst + new_pks_datatypes_sec_lst

new_cust_cols_datatypes_lst = [new_pks_datatypes_lst[new_pks_names_lst.index(
    dt)] for dt in new_cust_cols_names_lst]

curr_template_path = os.path.join(templates_path, sys.argv[6])


def remove_comments(files_in, lst_in):
    r"""
    Funcion para buscar líneas y borrarlas. Se detectan con una Palabra clave que debe ser puesta al principio de la línea

    Args:
        files_in (lista): lista de archivos a iterar Ej: ['C:\dir1\file1.txt','C:\dir2\file2.txt']
        lst_in (lista): Lista de Palabras clave para detectar las lineas a borrar. Ej: ['//Removethisline','//Deletethiscomment]
    """

    for file_in in files_in:
        for del_key in lst_in:
            with open(file_in, "r") as f:
                lines = f.readlines()
            with open(file_in, "w") as f:
                for line in lines:
                    if not line.lstrip().startswith(del_key):
                        f.write(line)


def searchnreplace(files_in, lst_in):
    r"""
    Funcion para buscar y reemplazar texto en archivos

    Args:
        files_in (lista): lista de archivos a iterar Ej: ['C:\dir1\file1.txt','C:\dir2\file2.txt']
        lst_in (lista de tupples): Lista de pares (viejo, nuevo) a iterar. Ej: [('nombreviejo1','nombrenuevo1'),('nombreviejo2','nombrenuevo2')]
    """
    for file_in in files_in:
        # Read in the file
        with open(file_in, "r") as file:
            filedata = file.read()

        for old, new in lst_in:
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
        with open(file_in, "w") as file:
            file.write(filedata)


# Procesar el hibernate.cfg.xml
if not filecmp.cmp(hibernate_cfg_xml, hibernate_tmpl_cfg_xml):
    # Primero hacer un backup del archivo original
    shutil.copy(hibernate_cfg_xml, hibernate_cfg_xml + ".bak")

    # Pisar el original con nuestro template
    shutil.copy(hibernate_tmpl_cfg_xml, hibernate_cfg_xml)

# Procesar el hibernate.reveng.xml
if not filecmp.cmp(hibernate_reveng_xml, hibernate_tmpl_reveng_xml):
    # Primero hacer un backup del archivo original
    shutil.copy(hibernate_reveng_xml, hibernate_reveng_xml + ".bak")

    # Pisar el original con nuestro template
    shutil.copy(hibernate_tmpl_reveng_xml, hibernate_reveng_xml)

    # Setear el nuevo hibernate.cfg.xml para matchear la tabla
    searchnreplace(
        [hibernate_reveng_xml], [
            ("match-table-placeholder", new_tbl_name_snake)])
    searchnreplace(
        [hibernate_reveng_xml], [
            ("match-schema-placeholder", new_sch_name_snake)])

# Asegurarse de que no este la carpeta generated antes de correr hbm2dao
shutil.rmtree(build_domain_path, ignore_errors=True)

# Disparar comando gradlew de ingeniería inversa
subprocess.run(["gradlew", "hbm2dao", "--stacktrace"],
               cwd=base_path, shell=True)

# Mover los archivos de la entidad generada a main
files_lst = os.listdir(build_domain_path)

for filename in files_lst:
    if filename.startswith(new_tbl_name_pascal):
        shutil.move(
            os.path.join(build_domain_path, filename),
            os.path.join(main_domain_path, filename),
        )

# Eliminar el bug de Stateless en el archivo Home
searchnreplace(
    [os.path.join(main_domain_path, new_tbl_name_pascal_home)],
    [("@Stateless", ""), ("import javax.ejb.Stateless;", "")],
)

# Copiar templates Repository Resource y Services y renmombarlos
old_filename_abs_path_repository = os.path.join(
    curr_template_path, old_tbl_name_pascal_repository
)
old_filename_abs_path_resource = os.path.join(
    curr_template_path, old_tbl_name_pascal_resource
)
old_filename_abs_path_service = os.path.join(
    curr_template_path, old_tbl_name_pascal_services
)

new_filename_abs_path_repository = os.path.join(
    main_repository_path, new_tbl_name_pascal_repository
)
new_filename_abs_path_resource = os.path.join(
    main_rest_path, new_tbl_name_pascal_resource
)
new_filename_abs_path_service = os.path.join(
    main_service_path, new_tbl_name_pascal_services
)

shutil.copy(old_filename_abs_path_repository, new_filename_abs_path_repository)
shutil.copy(old_filename_abs_path_resource, new_filename_abs_path_resource)

# Generar una lista con los paths Old y New de los 3 archivos
dirs_lst = []

dirs_lst.append(new_filename_abs_path_repository)
dirs_lst.append(new_filename_abs_path_resource)

# Si la tabla a procesar tiene  secuencia, crear su servicio
if new_pks_names_sec_lst:
    shutil.copy(old_filename_abs_path_service, new_filename_abs_path_service)
    dirs_lst.append(new_filename_abs_path_service)

############## Procesamiento de columnas - comienzo ##############

search_n_replace_lst = []

########## Repository ##########

if new_pks_names_sec_lst:
    search_str = "COALESCE(max(sec_placeholder),0)+1"
    start_str = ""
    sep_str = ""
    end_str = ""

    repl_str = (
        repl_str.replace("sec_placeholder", "cast(sec_placeholder as integer)")
        if new_pks_datatypes_sec_lst[0] == "String"
        else search_str
    )

    repl_str = repl_str.replace(
        "sec_placeholder", stringcase.snakecase(new_pks_names_sec_lst[0])
    )

    new_str = start_str + repl_str + end_str
    search_n_replace_lst.append((search_str, new_str))

    search_str = "where_and_colsnotsec_placeholder"
    start_str = "where "
    sep_str = " and "
    end_str = ""

    repl_str = sep_str.join(
        [
            stringcase.snakecase(pk) + " = :" + stringcase.snakecase(pk)
            for pk in new_pks_names_not_sec_lst
        ]
    )

    new_str = start_str + repl_str + end_str
    search_n_replace_lst.append((search_str, new_str))

    search_str = "public ColsecDatatype obtenerUltimaSecuencia"
    start_str = ""
    sep_str = ""
    end_str = ""

    repl_str = search_str.replace(
        "ColsecDatatype",
        new_pks_datatypes_sec_lst[0])

    new_str = start_str + repl_str + end_str

    search_n_replace_lst.append((search_str, new_str))

    search_str = "ByColsNotSecPlaceholder"
    start_str = "By"
    sep_str = ""
    end_str = ""

    repl_str = search_str.replace("ByColsNotSecPlaceholder", "".join(
        [stringcase.pascalcase(pk) for pk in new_pks_names_not_sec_lst]))

    new_str = start_str + repl_str + end_str

    search_n_replace_lst.append((search_str, new_str))

    search_str = "(param_colsnotsec_placeholder"
    start_str = "("
    sep_str = ", "
    end_str = ""

    repl_str = sep_str.join(
        [
            '@Param("'
            + stringcase.snakecase(new_pks_names_not_sec_lst[idx])
            + '")'
            + " "
            + new_pks_datatypes_not_sec_lst[idx]
            + " "
            + stringcase.snakecase(new_pks_names_not_sec_lst[idx])
            for idx in range(len(new_pks_names_not_sec_lst))
        ]
    )

    new_str = start_str + repl_str + end_str
    search_n_replace_lst.append((search_str, new_str))

if new_cust_cols_names_lst:

    # Descomentar las líneas CustomGet1 ya que van a ser usadas

    search_str = "//CustomLinesCustomGet1 "
    start_str = ""
    sep_str = ""
    end_str = ""

    repl_str = ""

    new_str = start_str + repl_str + end_str

    search_n_replace_lst.append((search_str, new_str))

    search_str = "where_and_colscustom_placeholder"
    start_str = "where "
    sep_str = " and "
    end_str = ""

    repl_str = sep_str.join(
        [
            stringcase.snakecase(pk) + " = :" + stringcase.snakecase(pk)
            for pk in new_cust_cols_names_lst
        ]
    )

    new_str = start_str + repl_str + end_str
    search_n_replace_lst.append((search_str, new_str))

    # Este aplica a Repository y Resources también
    search_str = "ByColsCustomPlaceholder"
    start_str = "By"
    sep_str = ""
    end_str = ""

    repl_str = search_str.replace(
        "ByColsCustomPlaceholder",
        "".join([stringcase.pascalcase(cc) for cc in new_cust_cols_names_lst]),
    )

    new_str = start_str + repl_str + end_str

    search_n_replace_lst.append((search_str, new_str))

    search_str = "(param_colscustom_placeholder"
    start_str = "("
    sep_str = ", "
    end_str = ""

    repl_str = sep_str.join(
        [
            '@Param("'
            + stringcase.snakecase(new_cust_cols_names_lst[idx])
            + '")'
            + " "
            + new_cust_cols_datatypes_lst[idx]
            + " "
            + stringcase.snakecase(new_cust_cols_names_lst[idx])
            for idx in range(len(new_cust_cols_names_lst))
        ]
    )

    new_str = start_str + repl_str + end_str
    search_n_replace_lst.append((search_str, new_str))

########## Services ##########
if new_pks_names_sec_lst:
    search_str = "(tableNamePlaceholder.getId().getColsNotSecPlaceholder())"
    start_str = "("
    sep_str = ", "
    end_str = ")"

    repl_str = sep_str.join(
        [
            "tableNamePlaceholder.getId().get" + stringcase.pascalcase(pk) + "()"
            for pk in new_pks_names_not_sec_lst
        ]
    )
    new_str = start_str + repl_str + end_str
    search_n_replace_lst.append((search_str, new_str))

    search_str = "public ColsecDatatype UltimaSecuencia"
    start_str = ""
    sep_str = ""
    end_str = ""

    repl_str = search_str.replace(
        "ColsecDatatype",
        new_pks_datatypes_sec_lst[0])

    new_str = start_str + repl_str + end_str

    search_n_replace_lst.append((search_str, new_str))

########## Resources ##########
if new_pks_names_sec_lst:
    search_str = "ColsecDatatype id_sec_placeholder = tableNamePlaceholderServices.UltimaSecuencia(table_name_placeholder);"
    start_str = ""
    sep_str = ""
    end_str = ""

    repl_str = search_str.replace(
        "ColsecDatatype",
        new_pks_datatypes_sec_lst[0])
    repl_str = repl_str.replace(
        "sec_placeholder", stringcase.snakecase(new_pks_names_sec_lst[0])
    )

    new_str = start_str + repl_str + end_str

    search_n_replace_lst.append((search_str, new_str))

    search_str = "id.setSecPlaceholder(id_sec_placeholder);"
    start_str = ""
    sep_str = ""
    end_str = ""

    repl_str = search_str.replace(
        "SecPlaceholder", stringcase.pascalcase(new_pks_names_sec_lst[0])
    )
    repl_str = repl_str.replace(
        "sec_placeholder", stringcase.snakecase(new_pks_names_sec_lst[0])
    )

    new_str = start_str + repl_str + end_str
    search_n_replace_lst.append((search_str, new_str))

search_str = "id.setColsNotSecPlaceholder(table_name_placeholder.getId().getColsNotSecPlaceholder());"
start_str = ""
sep_str = " "
end_str = ""

repl_str = sep_str.join(
    [
        "id.set"
        + stringcase.pascalcase(pk)
        + "(table_name_placeholder.getId().get"
        + stringcase.pascalcase(pk)
        + "());"
        for pk in new_pks_names_not_sec_lst
    ]
)

new_str = start_str + repl_str + end_str
search_n_replace_lst.append((search_str, new_str))

search_str = r"{colsnotsec_placeholder}"
start_str = ""
sep_str = "/"
end_str = ""

repl_str = sep_str.join(
    ["{" + stringcase.snakecase(pk) + "}" for pk in new_pks_names_not_sec_lst]
)

new_str = start_str + repl_str + end_str
search_n_replace_lst.append((search_str, new_str))

if new_pks_names_sec_lst:
    search_str = r"{sec_placeholder}"
    start_str = ""
    sep_str = ""
    end_str = ""

    repl_str = search_str.replace(
        "sec_placeholder", stringcase.snakecase(new_pks_names_sec_lst[0])
    )

    new_str = start_str + repl_str + end_str
    search_n_replace_lst.append((search_str, new_str))

search_str = r': {}", debugcolsnotsec_placeholder'
start_str = r': {}", '
sep_str = ' + "|" + '
end_str = ""

repl_str = sep_str.join([stringcase.snakecase(pk)
                        for pk in new_pks_names_not_sec_lst])

new_str = start_str + repl_str + end_str
search_n_replace_lst.append((search_str, new_str))

if new_pks_names_sec_lst:
    search_str = "debugsec_placeholder"
    start_str = ""
    sep_str = ""
    end_str = ""

    repl_str = search_str.replace(
        "debugsec_placeholder", stringcase.snakecase(new_pks_names_sec_lst[0])
    )

    new_str = start_str + repl_str + end_str
    search_n_replace_lst.append((search_str, new_str))

search_str = "(colsnotsec_placeholder);"
start_str = "("
sep_str = ", "
end_str = ");"

repl_str = sep_str.join([stringcase.snakecase(pk)
                        for pk in new_pks_names_not_sec_lst])

new_str = start_str + repl_str + end_str
search_n_replace_lst.append((search_str, new_str))

if new_cust_cols_names_lst:
    search_str = r"{colscustom_placeholder}"
    start_str = ""
    sep_str = "/"
    end_str = ""

    repl_str = sep_str.join(
        ["{" + stringcase.snakecase(cc) + "}" for cc in new_cust_cols_names_lst]
    )

    new_str = start_str + repl_str + end_str
    search_n_replace_lst.append((search_str, new_str))

    search_str = '(@PathVariable("colscustom_placeholder") ColscustomDatatype colscustom_placeholder'
    start_str = "("
    sep_str = ", "
    end_str = ""

    repl_str = sep_str.join(
        [
            '@PathVariable("'
            + stringcase.snakecase(new_cust_cols_names_lst[idx])
            + '") '
            + new_cust_cols_datatypes_lst[idx]
            + " "
            + stringcase.snakecase(new_cust_cols_names_lst[idx])
            for idx in range(len(new_cust_cols_names_lst))
        ]
    )

    new_str = start_str + repl_str + end_str
    search_n_replace_lst.append((search_str, new_str))

    search_str = r': {}", debugcolscustom_placeholder'
    start_str = r': {}", '
    sep_str = ' + "|" + '
    end_str = ""

    repl_str = sep_str.join(
        [stringcase.snakecase(cc) for cc in new_cust_cols_names_lst]
    )

    new_str = start_str + repl_str + end_str
    search_n_replace_lst.append((search_str, new_str))

    search_str = "(colscustom_placeholder);"
    start_str = "("
    sep_str = ", "
    end_str = ");"

    repl_str = sep_str.join(
        [stringcase.snakecase(cc) for cc in new_cust_cols_names_lst]
    )

    new_str = start_str + repl_str + end_str
    search_n_replace_lst.append((search_str, new_str))

search_str = (
    '(@PathVariable("colsnotsec_placeholder") ColsnotsecDatatype colsnotsec_placeholder'
)
start_str = "("
sep_str = ", "
end_str = ""

repl_str = sep_str.join(
    [
        '@PathVariable("'
        + stringcase.snakecase(new_pks_names_not_sec_lst[idx])
        + '") '
        + new_pks_datatypes_not_sec_lst[idx]
        + " "
        + stringcase.snakecase(new_pks_names_not_sec_lst[idx])
        for idx in range(len(new_pks_names_not_sec_lst))
    ]
)

new_str = start_str + repl_str + end_str
search_n_replace_lst.append((search_str, new_str))

if new_pks_names_sec_lst:
    search_str = '@PathVariable("sec_placeholder") ColsecDatatype sec_placeholder'
    start_str = ""
    sep_str = ""
    end_str = ""

    repl_str = search_str.replace(
        "ColsecDatatype",
        new_pks_datatypes_sec_lst[0])
    repl_str = repl_str.replace(
        "sec_placeholder", stringcase.snakecase(new_pks_names_sec_lst[0])
    )

    new_str = start_str + repl_str + end_str
    search_n_replace_lst.append((search_str, new_str))

search_str = "id.setColsNotSecPlaceholder(cols_not_sec_placeholder);"
start_str = ""
sep_str = " "
end_str = ""

repl_str = sep_str.join(["id.set" +
                         stringcase.pascalcase(pk) +
                         "(" +
                         stringcase.snakecase(pk) +
                         ");" for pk in new_pks_names_not_sec_lst])

new_str = start_str + repl_str + end_str
search_n_replace_lst.append((search_str, new_str))

if new_pks_names_sec_lst:
    search_str = "id.setSecPlaceholder(sec_placeholder);"
    start_str = ""
    sep_str = ""
    end_str = ""

    repl_str = search_str.replace(
        "sec_placeholder", stringcase.snakecase(new_pks_names_sec_lst[0])
    )
    repl_str = repl_str.replace(
        "SecPlaceholder", stringcase.pascalcase(new_pks_names_sec_lst[0])
    )

    new_str = start_str + repl_str + end_str
    search_n_replace_lst.append((search_str, new_str))

# Buscar y reemplazar los pares (viejo, nuevo) de las columnas en los
# archivos Repository Resource y Services
searchnreplace(dirs_lst, search_n_replace_lst)

# Eliminar líneas que no han sido reemplazadas
remove_comments(dirs_lst, ["//CustomLines"])

############## Procesamiento de columnas - Fin ##############

# Buscar y reemplazar el nombre de la tabla en los archivos Repository Resource y Services
# Este paso se debe hacer después de columnas!
searchnreplace(dirs_lst, [(old_tbl_name_snake, new_tbl_name_snake)])

# Aplicar indentacion y formato a los archivos generados
# http://astyle.sourceforge.net/astyle.html
# --style=java   Java style uses attached braces.
# --recursive    For each directory in the command line, process all subdirectories recursively.
# --suffix=none  Do not retain a backup of the original file. The original file is purged after it is formatted.

for gen_file in dirs_lst:
    subprocess.run(
        [
            os.path.join(a_style_path, "AStyle.exe"),
            "--style=java",
            "--recursive",
            "--suffix=none",
            f"{new_tbl_name_pascal}*.java",
        ],
        cwd=main_path,
        shell=True,
    )

# Volver al estado original archivos cambiados por nuestro script

if os.path.exists(hibernate_reveng_xml + ".bak"):
    shutil.move(hibernate_reveng_xml + ".bak", hibernate_reveng_xml)

if os.path.exists(hibernate_cfg_xml + ".bak"):
    shutil.move(hibernate_cfg_xml + ".bak", hibernate_cfg_xml)