package tv.hupu.view.stage
{
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	
	public class Toast extends Sprite
	{
		private var ctn:Sprite;
		private var tf:TextField;
		private var tfmt:TextFormat;
		private var count:int = 0;
		private var timer:Timer;
		private var length:Number = 5;
		private var padding:Number = 3;
		
		public function Toast()
		{
			if(this.stage){
				init();
			}else{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		public function show(txt:String, dur:Number = 3):void{
			if(tf && txt){
				tf.setTextFormat(tfmt);
				tf.htmlText = txt;

				var w:Number = tf.width + 60;
				var h:Number = 30;
				ctn.graphics.clear();
				ctn.graphics.beginFill(0x000000, 0.5);
				ctn.graphics.drawRoundRect(-w/2, -h/2, w, h, h, h);
				ctn.graphics.endFill();
				tf.x = -tf.width /2;
				tf.y = -tf.height/2;
				
				TweenLite.killTweensOf(ctn);
				ctn.visible = true;
				ctn.alpha = 1;

				if(timer){
					timer.stop();
					timer.removeEventListener(TimerEvent.TIMER, timerHandler);
					timer = null;
				}
				timer = new Timer(dur * 1000);
				timer.addEventListener(TimerEvent.TIMER, timerHandler);
				timer.start();
			}
		}
		
		public function hide():void{
			if(timer){
				timer.reset();
			}
			TweenLite.to(ctn, .3, {alpha: 0, onComplete:function(){ctn.visible = false;}});
		}
		
		protected function init(evt:Event = null):void{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(Event.RESIZE, stageResize);
			
			
			ctn = new Sprite();
			ctn.alpha = 0;
			addChild(ctn);
			
			tfmt = new TextFormat("微软雅黑,Microsoft YaHei,黑体,Arial", 14, 0xffffff);
			
			tf = new TextField();
			tf.defaultTextFormat = tfmt;
			tf.multiline = false;
			tf.addEventListener(TextEvent.LINK, textLink);
			tf.autoSize = "left";
			ctn.addChild(tf);
			
			timer = new Timer(250);
			timer.addEventListener(TimerEvent.TIMER, timerHandler);
			
			
			stageResize();
		}
		
		private function textLink(evt:TextEvent):void{
			dispatchEvent(new Event(evt.text));
		}
		
		private function timerHandler(evt:TimerEvent):void{
			hide();
		}
		
		private function stageResize(e:Event = null):void{
			ctn.x = stage.stageWidth/2;
			ctn.y = stage.stageHeight - 80;
		}
	}
}