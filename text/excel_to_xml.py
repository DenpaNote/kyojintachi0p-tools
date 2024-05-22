import os
import openpyxl
import xml.etree.ElementTree as ET


def get_filename_without_extension(path):
    return path.split("/")[-1].split(".")[0]


def parse_xlsx(xlsx_path, xml_path):
    name = get_filename_without_extension(xlsx_path)
    wb = openpyxl.load_workbook(xlsx_path)
    print(f"Processing {name}")
    tree = ET.parse(xml_path)
    ws = wb.active
    result = {}
    for index, row in enumerate(ws.iter_rows()):
        if index == 0:
            continue
        if row[0].value is None:
            continue
        index_ = int(row[0].value)
        raw = row[1].value
        trans = row[2].value.strip()
        if not trans:
            print(f"{name} {index_}: No translation, use raw text")
            trans = raw
        else:
            print(f"{name} {index_}: {raw} -> {trans}")
        if raw.startswith("　") and not trans.startswith("　"):
            trans = "　" + trans
        result[index_] = trans
    for index, child in enumerate(tree.getroot().iter()):
        if child.tail and child.tail.strip():
            if index in result:
                child.tail = result[index]
            else:
                print(f"{name} {index}: No index in xlsx")
    tree.write("./" + get_filename_without_extension(xml_path) + "_translated.xml", encoding="utf-8", xml_declaration=True)

for file in os.listdir("."):
    if file.endswith(".xlsx"):
        parse_xlsx(file, file.replace(".xlsx", ".xml"))

