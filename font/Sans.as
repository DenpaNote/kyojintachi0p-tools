package {
    import flash.text.Font;
    
    [Embed(
        source="FZHTK.TTF",
        fontName="Mgen+ 2cp regular",
        mimeType="application/x-font",
        fontWeight="normal",
        fontStyle="normal",
        advancedAntiAliasing="true",
        embedAsCFF="false"
    )]
    public class Sans extends Font {
        public function Sans() {
            super();
        }
    }
}
