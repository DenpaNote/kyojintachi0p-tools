package 
{   
    import flash.events.Event; 
    import flash.filesystem.File;
    import flash.utils.ByteArray;
    import com.probertson.data.DBCopier;
    import flash.display.Sprite; 
    import flash.text.TextField;
    
    [SWF(width="1280", height="720", frameRate=60)]
    public class Document extends Sprite
    {
        public function Document()
        {
            stage.scaleMode = "noScale"
            stage.align = "TL";
            
            try {
                var key: ByteArray = new ByteArray();
                key.writeUTFBytes("Egroj38D9fUNkkgB");
                var orgFile: File = new File("text.dat");
                var result: File = new File("text_decrypt.dat");
                new DBCopier(orgFile, result, null, key).start();
            } catch (e: Error) {
                var errorText: TextField = new TextField();
                errorText.text = e.message;
                errorText.x = 50;
                errorText.y = 80;
                addChild(errorText);
            }
        }
    }
}
