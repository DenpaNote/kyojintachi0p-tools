package {
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.text.Font;
    
    public class AppFonts extends Sprite {
        private var AozoraMincho: Class;
        private var mgenPlus: Class;
        
        public function AppFonts() {
            AozoraMincho = Serif;
            mgenPlus = Sans;
            super();
            Font.registerFont(AozoraMincho);
            Font.registerFont(mgenPlus);
            if (this.stage) {
                init();
            }
        }
        
        private function init(p1: Event = null): void {
        }
    }
}
