import sqlite3
import os
import json

import hashlib

os.makedirs("./system_dump", exist_ok=True)

conn = sqlite3.connect("system.dat")

table_name = "resourcetbl"
cursor = conn.cursor()
cursor.execute(f"SELECT * FROM {table_name}")
rows = cursor.fetchall()

dump_json = []

for row in rows:
    id_ = row[0]
    filename = row[1]
    type = row[2]
    extension = row[3]
    data = row[4]
    description = None
    metadata = None
    modificationdate = row[7]
    lastupdate = row[8]
    
    if filename.endswith(".png"):
        data = data[data.find(b"\x89PNG"):]
    elif filename.endswith(".swf"):
        data = data[data.find(b"CWS"):]
    else:
        print(f"Unknown file type: {filename}")
    
    data_md5 = hashlib.md5(data).hexdigest()
    
    dump_json.append({
        "id": id_,
        "filename": filename,
        "type": type,
        "extension": extension,
        "description": description,
        "metadata": metadata,
        "modificationdate": modificationdate,
        "lastupdate": lastupdate,
        "data_md5": data_md5
    })
    
    
    id_path = "/".join(id_.split("/")[0:-1])
    
    os.makedirs(f"./system_dump/{id_path}", exist_ok=True)
    
    with open(f"./system_dump/{id_}", "wb") as f:
        f.write(data)

with open("./system_dump/dump.json", "w") as f:
    json.dump(dump_json, f, indent=4, sort_keys=True, ensure_ascii=False)
