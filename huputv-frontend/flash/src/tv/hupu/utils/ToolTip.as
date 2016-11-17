package tv.hupu.utils
{
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	import flash.utils.Timer;

	/**
	 * 提示类
	 * @author meiandai
	 * 
	 */	
	public class ToolTip
	{
		private static var spt:Sprite;
		private static var txt:TextField;
		private static var stg:Stage;
		private static var dic:Dictionary;
		private static var iobj:InteractiveObject;
		private static var overTimer:Timer;
		private static var outTimer:Timer;
		
		public static function register(io:InteractiveObject, tip:String):void{
			if(!spt){
				txt = new TextField();
				txt.defaultTextFormat = new TextFormat("Microsoft YaHei", 12, 0x000000);
				txt.autoSize = "left";
				txt.multiline = false;
				txt.mouseEnabled = false;
				
				spt = new Sprite();
				spt.addChild(txt);
				
				dic = new Dictionary(true);
				
				overTimer = new Timer(800, 1);
				overTimer.addEventListener(TimerEvent.TIMER, overTimerHandler);
				
				outTimer = new Timer(1300, 1);
				outTimer.addEventListener(TimerEvent.TIMER, outTimerHandler);
			}
			
			dic[io] = tip;
			io.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			io.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
		}
		
		private static function mouseOver(evt:MouseEvent):void{
			iobj = evt.currentTarget as InteractiveObject;
			overTimer.reset();
			overTimer.start();
			
		}
		
		private static function mouseOut(evt:MouseEvent = null):void{
			overTimer.reset();
			outTimer.reset();
			if(stg && stg.contains(spt)){
				stg.removeChild(spt);
			}
		}
		
		private static function overTimerHandler(evt:TimerEvent){
			if(iobj && iobj.stage){
				stg = iobj.stage;
				txt.text = dic[iobj];
				txt.x = -txt.width/2;
				txt.y = -txt.height + 2;
				spt.graphics.clear();
				spt.graphics.beginFill(0xFFFFFF);
				spt.graphics.drawRoundRect(txt.x - 2, txt.y - 2, txt.width + 4, txt.height + 4, 2);
				spt.graphics.endFill();
				spt.x = stg.mouseX;
				spt.x = spt.x + txt.width/2 > iobj.stage.stageWidth ? iobj.stage.stageWidth - txt.width/2 : spt.x;
				spt.x = spt.x < txt.width/2 ? txt.width/2 : spt.x;
				spt.y = stg.mouseY - 4;
				spt.y = spt.y < 0 ? 0 : spt.y;
				stg.addChild(spt);
				outTimer.reset();
				outTimer.start();
			}
		}
		
		private static function outTimerHandler(evt:TimerEvent){
			mouseOut();
		}
		
		public function unregister(io:InteractiveObject) {
			io.removeEventListener(MouseEvent.MOUSE_OVER, mouseOver);
		}

	}
}