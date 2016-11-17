package tv.hupu.view.stage
{
	
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	import tv.hupu.utils.ConsTrace;
	
	
	public class StageLoading extends Sprite
	{
		
		private var tf:TextField;
		private var anm:Sprite;
		private var dots:Vector.<Sprite>;
		private var count:int = 0;
		private var timer:Timer;
		private var length:Number = 5;
		private var padding:Number = 3;
		
		public function StageLoading()
		{
			if(this.stage){
				init();
			}else{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		public function show():void{
			visible = true;
			TweenLite.to(this, 0.3, {alpha: 1, delay: 0.5});
			timer.reset();
			timer.start();
		}
		
		public function hide():void{
			TweenLite.killTweensOf(this);
			alpha = 0;
			visible = false;
			timer.stop();
		}
		
		protected function init(evt:Event = null):void{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(Event.RESIZE, stageResize);
			
			stageResize();
			
			anm = new Sprite();
			dots = new Vector.<Sprite>();
			for(var i:int = 0; i < 8; i++){
				var dot:Sprite = new Sprite();
				dot.graphics.beginFill(0xffffff);
				dot.graphics.drawRect(-length/2, -length/2, length, length);
				dot.graphics.endFill();
				anm.addChild(dot);
				dots.push(dot);
			}
			resetPos();
			addChild(anm);
			
			tf = new TextField();
			tf.defaultTextFormat = new TextFormat("Microsoft YaHei", 14, 0xffffff);
			tf.autoSize = "left";
			tf.text = "正在加载...";
			tf.mouseEnabled = false;
			tf.x = -tf.width / 2;
			tf.y = 36;
			addChild(tf);
			
			timer = new Timer(250);
			timer.addEventListener(TimerEvent.TIMER, timerHandler);
			hide();
		}
		
		private function resetPos():void{
			for(var i:int = 0, len:int = dots.length; i < len; i++){
				var row:int = int(i/3);
				var col:int = i%3;

				var dot:Sprite = dots[i];
				dot.x = (col - 1) * (padding + length);
				dot.y = (row - 1) * (padding + length);
			}
		}
		
		private function timerHandler(evt:TimerEvent):void{
			if(dots && dots.length >= 8){
				if(count % 2 == 0){
					anm.rotation = -180 * count / 4;
//					ConsTrace.htrace(count + ": " + anm.rotation);
					resetPos();
					TweenLite.to(dots[5], 0.2, {y: padding + length});
				}else{
					TweenLite.to(dots[2], 0.2, {y: 0});
				}
				count++;
				if(count >= 8){
					count = 0;
				}
			}
		}
		
		private function stageResize(e:Event = null):void{
			graphics.clear();
			graphics.beginFill(0x000000, 0.4);
			graphics.drawRect(-stage.stageWidth/2, -stage.stageHeight/2, stage.stageWidth, stage.stageHeight);
			graphics.endFill();
			x = stage.stageWidth/2;
			y = stage.stageHeight/2;
		}
	}
}