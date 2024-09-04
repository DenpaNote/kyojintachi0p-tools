package {
    import flash.events.Event; 
    import flash.filesystem.File;
    import flash.utils.ByteArray;
    import flash.display.Sprite; 
    import flash.text.TextField;
    import flash.data.SQLStatement;
    
    import flash.data.SQLConnection;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;
    
    [SWF(width="1280", height="720", frameRate="60")]
    public class PackSystem extends Sprite {
        private function readFileContents(file:File): ByteArray
        {
            var fileStream: FileStream = new FileStream();
            fileStream.open(file, FileMode.READ);
            var bytes: ByteArray = new ByteArray();
            fileStream.readBytes(bytes);
            fileStream.close();
            return bytes;
        }
        
        public function PackSystem() {
            stage.scaleMode = "noScale";
            stage.align = "TL";
            
            var result: File = new File("/Applications/去人たちZERO -prologue-.app/Contents/Resources/data/system.dat");
            
            if (result.exists) {
                result.deleteFile();
            }
            
            var connection: SQLConnection = new SQLConnection();
            connection.open(result, "create", true, 1024, null);
            
            var statement: SQLStatement = new SQLStatement();
            statement.sqlConnection = connection;
            statement.text = "CREATE TABLE IF NOT EXISTS " + "resourcetbl" + "(" + "id TEXT NOT NULL PRIMARY KEY, " + "filename TEXT, " + "type TEXT, " + "extension TEXT, " + "data BLOB NOT NULL, " + "description TEXT, " + "metadata TEXT, " + "modificationdate TEXT, " + "lastupdate TEXT" + ")";
            statement.execute();
            
            var dumpJson: File = new File("/Users/yazawazi/Developer/焊/system_dump/dump.json");
            var bytes: ByteArray = readFileContents(dumpJson);
            var json: String = bytes.readUTFBytes(bytes.length);
            var jsonObjects: Array = JSON.parse(json) as Array;
            
            for (var i: int = 0; i < jsonObjects.length; i++) {
                var jsonObject: Object = jsonObjects[i];
                var id: String = jsonObject["id"];
                var filename: String = jsonObject["filename"];
                var type: String = jsonObject["type"];
                var extension: String = jsonObject["extension"];
                var data: ByteArray = readFileContents(new File("/Users/yazawazi/Developer/焊/system_dump/" + id));
                var modificationdate: String = jsonObject["modificationdate"];
                var lastupdate: String = jsonObject["lastupdate"];
                
                var insertStatement: SQLStatement = new SQLStatement();
                insertStatement.sqlConnection = connection;
                insertStatement.text = "INSERT INTO " + "resourcetbl" + " (id, filename, type, extension, data, description, metadata, modificationdate, lastupdate) VALUES (:id, :filename, :type, :extension, :data, :description, :metadata, :modificationdate, :lastupdate)";
                insertStatement.parameters[":id"] = id;
                insertStatement.parameters[":filename"] = filename;
                insertStatement.parameters[":type"] = type;
                insertStatement.parameters[":extension"] = extension;
                insertStatement.parameters[":data"] = data;
                insertStatement.parameters[":description"] = null;
                insertStatement.parameters[":metadata"] = null;
                insertStatement.parameters[":modificationdate"] = modificationdate;
                insertStatement.parameters[":lastupdate"] = lastupdate;
                insertStatement.execute();
                
                var text: TextField = new TextField();
                text.text = "Packing " + id + " " + filename + " " + type + " " + extension + " " + modificationdate + " " + lastupdate;
                text.x = 10;
                text.y = 10 + i * 20;
                addChild(text);
            }
            
            connection.close();
        }
    }
}
