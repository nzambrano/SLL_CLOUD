newtblnamesnake = "m4sll_doc_litigios"
newPksConcat ="dol_secuencia, lit_id_litigio, id_organization"

oldtblnamesnake = "m4sll_lit_seguimie"
oldPksConcat = "lit_id_litigio,id_organization,lis_secuencia"



# for line in asd.splitlines():
#     # print(line)
#     if line.startswith("    public M4sllLitSeguimieId") and not line.endswith("() {"):
#         pks = line[line.find("(")+1:line.find(")")]
#         print(pks)