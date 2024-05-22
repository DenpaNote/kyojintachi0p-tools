package 
{   
    import flash.events.Event; 
    import flash.filesystem.File;
    import flash.utils.ByteArray;
    import com.probertson.data.DBCopier;
    import flash.display.Sprite; 
    import flash.text.TextField;
    import flash.data.SQLStatement;
    
    import flash.data.SQLConnection;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;
    
    [SWF(width="1280", height="720", frameRate=60)]
    public class Document extends Sprite
    {
        private function readFileContents(file:File): ByteArray
        {
            var fileStream:FileStream = new FileStream();
            fileStream.open(file, FileMode.READ);
            var bytes:ByteArray = new ByteArray();
            fileStream.readBytes(bytes);
            fileStream.close();
            return bytes;
        }
        
        public function Document()
        {
            stage.scaleMode = "noScale"
            stage.align = "TL";
            
            
            var key: ByteArray = new ByteArray();
            key.writeUTFBytes("Egroj38D9fUNkkgB");
            
            var result: File = new File("text_new.dat");
            
            if (result.exists) {
                result.deleteFile();
            }
            
            var connection: SQLConnection = new SQLConnection();
            connection.open(result, "create", true, 1024, key);
            
            var sqlStatement: SQLStatement = new SQLStatement();
            sqlStatement.sqlConnection = connection;
            sqlStatement.text = "CREATE TABLE IF NOT EXISTS " + "scenariotbl" + "(" + "id TEXT NOT NULL PRIMARY KEY, " + "filename TEXT, " + "type TEXT, " + "extension TEXT, " + "data BLOB NOT NULL, " + "description TEXT, " + "metadata TEXT, " + "modificationdate TEXT, " + "lastupdate TEXT" + ")";
            sqlStatement.execute();
            
            // Now shit code
            // It works, i don't want to change
            var sqlStatement1:SQLStatement = new SQLStatement();
            var file1: File = new File("SEI_01.xml");
            var bytes1: ByteArray = readFileContents(file1);
            sqlStatement1.sqlConnection = connection;
            sqlStatement1.text = "INSERT INTO scenariotbl (id, filename, type, extension, data, description, metadata, modificationdate, lastupdate) VALUES (:id, :filename, :type, :extension, :data, :description, :metadata, :modificationdate, :lastupdate)";
            
            sqlStatement1.parameters[":id"] = "SEI_01";
            sqlStatement1.parameters[":filename"] = null;
            sqlStatement1.parameters[":type"] = "text";
            sqlStatement1.parameters[":extension"] = "xml";
            sqlStatement1.parameters[":data"] = bytes1;
            sqlStatement1.parameters[":description"] = null;
            sqlStatement1.parameters[":metadata"] = "{\"scenarioName\":\"SEI_01\"}";
            sqlStatement1.parameters[":modificationdate"] = null;
            sqlStatement1.parameters[":lastupdate"] = "2016-03-24 21:31:11";
            sqlStatement1.execute();
            
            var sqlStatement2:SQLStatement = new SQLStatement();
            var file2: File = new File("SEI_02.xml");
            var bytes2: ByteArray = readFileContents(file2);
            sqlStatement2.sqlConnection = connection;
            sqlStatement2.text = "INSERT INTO scenariotbl (id, filename, type, extension, data, description, metadata, modificationdate, lastupdate) VALUES (:id, :filename, :type, :extension, :data, :description, :metadata, :modificationdate, :lastupdate)";
            
            sqlStatement2.parameters[":id"] = "SEI_02";
            sqlStatement2.parameters[":filename"] = null;
            sqlStatement2.parameters[":type"] = "text";
            sqlStatement2.parameters[":extension"] = "xml";
            sqlStatement2.parameters[":data"] = bytes2;
            sqlStatement2.parameters[":description"] = null;
            sqlStatement2.parameters[":metadata"] = "{\"scenarioName\":\"SEI_02\"}";
            sqlStatement2.parameters[":modificationdate"] = null;
            sqlStatement2.parameters[":lastupdate"] = "2016-03-24 21:31:11";
            sqlStatement2.execute();
            
            var sqlStatement3:SQLStatement = new SQLStatement();
            var file3: File = new File("SEI_03.xml");
            var bytes3: ByteArray = readFileContents(file3);
            sqlStatement3.sqlConnection = connection;
            sqlStatement3.text = "INSERT INTO scenariotbl (id, filename, type, extension, data, description, metadata, modificationdate, lastupdate) VALUES (:id, :filename, :type, :extension, :data, :description, :metadata, :modificationdate, :lastupdate)";
            
            sqlStatement3.parameters[":id"] = "SEI_03";
            sqlStatement3.parameters[":filename"] = null;
            sqlStatement3.parameters[":type"] = "text";
            sqlStatement3.parameters[":extension"] = "xml";
            sqlStatement3.parameters[":data"] = bytes3;
            sqlStatement3.parameters[":description"] = null;
            sqlStatement3.parameters[":metadata"] = "{\"scenarioName\":\"SEI_03\"}";
            sqlStatement3.parameters[":modificationdate"] = null;
            sqlStatement3.parameters[":lastupdate"] = "2016-03-24 21:31:11";
            sqlStatement3.execute();
            
            var sqlStatement4:SQLStatement = new SQLStatement();
            var file4: File = new File("SEI_04.xml");
            var bytes4: ByteArray = readFileContents(file4);
            sqlStatement4.sqlConnection = connection;
            sqlStatement4.text = "INSERT INTO scenariotbl (id, filename, type, extension, data, description, metadata, modificationdate, lastupdate) VALUES (:id, :filename, :type, :extension, :data, :description, :metadata, :modificationdate, :lastupdate)";
            
            sqlStatement4.parameters[":id"] = "SEI_04";
            sqlStatement4.parameters[":filename"] = null;
            sqlStatement4.parameters[":type"] = "text";
            sqlStatement4.parameters[":extension"] = "xml";
            sqlStatement4.parameters[":data"] = bytes4;
            sqlStatement4.parameters[":description"] = null;
            sqlStatement4.parameters[":metadata"] = "{\"scenarioName\":\"SEI_04\"}";
            sqlStatement4.parameters[":modificationdate"] = null;
            sqlStatement4.parameters[":lastupdate"] = "2016-03-24 21:31:11";
            sqlStatement4.execute();
            
            var sqlStatement5:SQLStatement = new SQLStatement();
            var file5: File = new File("SEI_05.xml");
            var bytes5: ByteArray = readFileContents(file5);
            sqlStatement5.sqlConnection = connection;
            sqlStatement5.text = "INSERT INTO scenariotbl (id, filename, type, extension, data, description, metadata, modificationdate, lastupdate) VALUES (:id, :filename, :type, :extension, :data, :description, :metadata, :modificationdate, :lastupdate)";
            
            sqlStatement5.parameters[":id"] = "SEI_05";
            sqlStatement5.parameters[":filename"] = null;
            sqlStatement5.parameters[":type"] = "text";
            sqlStatement5.parameters[":extension"] = "xml";
            sqlStatement5.parameters[":data"] = bytes5;
            sqlStatement5.parameters[":description"] = null;
            sqlStatement5.parameters[":metadata"] = "{\"scenarioName\":\"SEI_05\"}";
            sqlStatement5.parameters[":modificationdate"] = null;
            sqlStatement5.parameters[":lastupdate"] = "2016-03-24 21:31:11";
            sqlStatement5.execute();
            
            var sqlStatement6:SQLStatement = new SQLStatement();
            var file6: File = new File("SEI_06.xml");
            var bytes6: ByteArray = readFileContents(file6);
            sqlStatement6.sqlConnection = connection;
            sqlStatement6.text = "INSERT INTO scenariotbl (id, filename, type, extension, data, description, metadata, modificationdate, lastupdate) VALUES (:id, :filename, :type, :extension, :data, :description, :metadata, :modificationdate, :lastupdate)";
            
            sqlStatement6.parameters[":id"] = "SEI_06";
            sqlStatement6.parameters[":filename"] = null;
            sqlStatement6.parameters[":type"] = "text";
            sqlStatement6.parameters[":extension"] = "xml";
            sqlStatement6.parameters[":data"] = bytes6;
            sqlStatement6.parameters[":description"] = null;
            sqlStatement6.parameters[":metadata"] = "{\"scenarioName\":\"SEI_06\"}";
            sqlStatement6.parameters[":modificationdate"] = null;
            sqlStatement6.parameters[":lastupdate"] = "2016-03-24 21:31:11";
            sqlStatement6.execute();
            
            var sqlStatement7:SQLStatement = new SQLStatement();
            var file7: File = new File("SEI_07.xml");
            var bytes7: ByteArray = readFileContents(file7);
            sqlStatement7.sqlConnection = connection;
            sqlStatement7.text = "INSERT INTO scenariotbl (id, filename, type, extension, data, description, metadata, modificationdate, lastupdate) VALUES (:id, :filename, :type, :extension, :data, :description, :metadata, :modificationdate, :lastupdate)";
            
            sqlStatement7.parameters[":id"] = "SEI_07";
            sqlStatement7.parameters[":filename"] = null;
            sqlStatement7.parameters[":type"] = "text";
            sqlStatement7.parameters[":extension"] = "xml";
            sqlStatement7.parameters[":data"] = bytes7;
            sqlStatement7.parameters[":description"] = null;
            sqlStatement7.parameters[":metadata"] = "{\"scenarioName\":\"SEI_07\"}";
            sqlStatement7.parameters[":modificationdate"] = null;
            sqlStatement7.parameters[":lastupdate"] = "2016-03-24 21:31:11";
            sqlStatement7.execute();
            
            var sqlStatement8:SQLStatement = new SQLStatement();
            var file8: File = new File("DF_01.xml");
            var bytes8: ByteArray = readFileContents(file8);
            sqlStatement8.sqlConnection = connection;
            sqlStatement8.text = "INSERT INTO scenariotbl (id, filename, type, extension, data, description, metadata, modificationdate, lastupdate) VALUES (:id, :filename, :type, :extension, :data, :description, :metadata, :modificationdate, :lastupdate)";
            
            sqlStatement8.parameters[":id"] = "DF_01";
            sqlStatement8.parameters[":filename"] = null;
            sqlStatement8.parameters[":type"] = "text";
            sqlStatement8.parameters[":extension"] = "xml";
            sqlStatement8.parameters[":data"] = bytes8;
            sqlStatement8.parameters[":description"] = null;
            sqlStatement8.parameters[":metadata"] = "{\"scenarioName\":\"DF_01\"}";
            sqlStatement8.parameters[":modificationdate"] = null;
            sqlStatement8.parameters[":lastupdate"] = "2016-03-24 21:31:11";
            sqlStatement8.execute();
            
            var sqlStatement9:SQLStatement = new SQLStatement();
            var file9: File = new File("DF_02.xml");
            var bytes9: ByteArray = readFileContents(file9);
            sqlStatement9.sqlConnection = connection;
            sqlStatement9.text = "INSERT INTO scenariotbl (id, filename, type, extension, data, description, metadata, modificationdate, lastupdate) VALUES (:id, :filename, :type, :extension, :data, :description, :metadata, :modificationdate, :lastupdate)";
            
            sqlStatement9.parameters[":id"] = "DF_02";
            sqlStatement9.parameters[":filename"] = null;
            sqlStatement9.parameters[":type"] = "text";
            sqlStatement9.parameters[":extension"] = "xml";
            sqlStatement9.parameters[":data"] = bytes9;
            sqlStatement9.parameters[":description"] = null;
            sqlStatement9.parameters[":metadata"] = "{\"scenarioName\":\"DF_02\"}";
            sqlStatement9.parameters[":modificationdate"] = null;
            sqlStatement9.parameters[":lastupdate"] = "2016-03-24 21:31:11";
            sqlStatement9.execute();
            
            var sqlStatement10:SQLStatement = new SQLStatement();
            var file10: File = new File("DF_03.xml");
            var bytes10: ByteArray = readFileContents(file10);
            sqlStatement10.sqlConnection = connection;
            sqlStatement10.text = "INSERT INTO scenariotbl (id, filename, type, extension, data, description, metadata, modificationdate, lastupdate) VALUES (:id, :filename, :type, :extension, :data, :description, :metadata, :modificationdate, :lastupdate)";
            
            sqlStatement10.parameters[":id"] = "DF_03";
            sqlStatement10.parameters[":filename"] = null;
            sqlStatement10.parameters[":type"] = "text";
            sqlStatement10.parameters[":extension"] = "xml";
            sqlStatement10.parameters[":data"] = bytes10;
            sqlStatement10.parameters[":description"] = null;
            sqlStatement10.parameters[":metadata"] = "{\"scenarioName\":\"DF_03\"}";
            sqlStatement10.parameters[":modificationdate"] = null;
            sqlStatement10.parameters[":lastupdate"] = "2016-03-24 21:31:11";
            sqlStatement10.execute();
            
            var sqlStatement11:SQLStatement = new SQLStatement();
            var file11: File = new File("DF_04.xml");
            var bytes11: ByteArray = readFileContents(file11);
            sqlStatement11.sqlConnection = connection;
            sqlStatement11.text = "INSERT INTO scenariotbl (id, filename, type, extension, data, description, metadata, modificationdate, lastupdate) VALUES (:id, :filename, :type, :extension, :data, :description, :metadata, :modificationdate, :lastupdate)";
            
            sqlStatement11.parameters[":id"] = "DF_04";
            sqlStatement11.parameters[":filename"] = null;
            sqlStatement11.parameters[":type"] = "text";
            sqlStatement11.parameters[":extension"] = "xml";
            sqlStatement11.parameters[":data"] = bytes11;
            sqlStatement11.parameters[":description"] = null;
            sqlStatement11.parameters[":metadata"] = "{\"scenarioName\":\"DF_04\"}";
            sqlStatement11.parameters[":modificationdate"] = null;
            sqlStatement11.parameters[":lastupdate"] = "2016-03-24 21:31:11";
            sqlStatement11.execute();
            
            var sqlStatement12:SQLStatement = new SQLStatement();
            var file12: File = new File("DF_05.xml");
            var bytes12: ByteArray = readFileContents(file12);
            sqlStatement12.sqlConnection = connection;
            sqlStatement12.text = "INSERT INTO scenariotbl (id, filename, type, extension, data, description, metadata, modificationdate, lastupdate) VALUES (:id, :filename, :type, :extension, :data, :description, :metadata, :modificationdate, :lastupdate)";
            
            sqlStatement12.parameters[":id"] = "DF_05";
            sqlStatement12.parameters[":filename"] = null;
            sqlStatement12.parameters[":type"] = "text";
            sqlStatement12.parameters[":extension"] = "xml";
            sqlStatement12.parameters[":data"] = bytes12;
            sqlStatement12.parameters[":description"] = null;
            sqlStatement12.parameters[":metadata"] = "{\"scenarioName\":\"DF_05\"}";
            sqlStatement12.parameters[":modificationdate"] = null;
            sqlStatement12.parameters[":lastupdate"] = "2016-03-24 21:31:11";
            sqlStatement12.execute();
            
            // done
            var doneText: TextField = new TextField();
            doneText.text = "done";
            doneText.x = 50;
            doneText.y = 80;
            addChild(doneText);
        }
    }
}
