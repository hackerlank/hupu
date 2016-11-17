package tv.hupu.view.toolbar
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import tv.hupu.events.ControlBarEvent;
	import tv.hupu.utils.SOStorage;
	
	/**
	 * 音量条
	 * @author meiandai
	 * 
	 */	
	public class VolumeBar extends Sprite
	{
		protected var _percent:Number = 0;	//音量百分比，[0,100]
		protected var _bg_bar:Sprite;		//背景滑槽，鼠标交互区域
		protected var _active_bar:Sprite;	//滑块左侧进度条
		protected var _dragger:Sprite;		//滑块
		
		protected const bwidth:int = 100;
		protected const bheight:int = 4;
		protected const bradius:int = 2;
		protected const dragger_radius1:int = 5;
		protected const dragger_radius2:int = 2;
		protected const active_color:uint = 0xc01e2f;
		protected const bg_color:uint = 0x383737;
		protected const dragger_color:uint = 0xa9a9b2;
		
		public function VolumeBar()
		{
			init();
		}
		
		/**
		 * 音量 [0, 100]
		 * @return 
		 * 
		 */		
		public function get percent():Number
		{
			return _percent;
		}

		public function set percent(value:Number):void
		{
			value = value > 100 ? 100 : value;
			value = value < 0 ? 0 : value;
			_percent = value;
			SOStorage.setValue(SOStorage.KEY_VOLUME, value);
			
			initActiveBar();
			initDragger();
		}

		protected function init():void{
			initBG();
			initActiveBar();
			initDragger();
//			percent = SOStorage.getValue(SOStorage.KEY_VOLUME) ? Number(SOStorage.getValue(SOStorage.KEY_VOLUME)) : 65;
		}
		
		protected function initBG():void{
			if(!_bg_bar){
				_bg_bar = new Sprite();
				_bg_bar.buttonMode = true;
				_bg_bar.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
				addChild(_bg_bar);
			}
			var gph:Graphics = _bg_bar.graphics;
			gph.clear();
			gph.beginFill(bg_color, 0);
			gph.drawRoundRect(0, bheight/2, bwidth, bheight * 2, bradius);
			gph.beginFill(bg_color);
			gph.drawRoundRect(0, -bheight/2, bwidth, bheight, bradius);
			gph.endFill();
		}
		
		
		protected function initDragger():void{
			if(!_dragger){
				_dragger = new Sprite();
				_dragger.mouseEnabled = false;
				addChild(_dragger);
			}
			
			_dragger.x = _percent * bwidth / 100;
			var gph:Graphics = _dragger.graphics;
			gph.clear();
			if(_percent == 0){
				gph.beginFill(dragger_color);
				gph.drawCircle(0, 0, dragger_radius1);
				gph.drawCircle(0, 0, dragger_radius2);
				gph.endFill();
			}else{
				gph.beginFill(dragger_color);
				gph.drawCircle(0, 0, dragger_radius1);
				gph.beginFill(active_color);
				gph.drawCircle(0, 0, dragger_radius2);
				gph.endFill();
			}
		}
		
		protected function initActiveBar():void{
			if(!_active_bar){
				_active_bar = new Sprite();
				_active_bar.mouseEnabled = false;
				addChild(_active_bar);
			}
			var gph:Graphics = _active_bar.graphics;
			gph.clear();
			gph.beginFill(active_color);
			gph.drawRoundRect(0, -bheight/2, _percent * bwidth / 100, bheight, bradius);
			gph.endFill();
		}
		
		protected function mouseDown(evt:MouseEvent):void{
			mouseMove();
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		
		protected function mouseMove(evt:MouseEvent = null):void{
			if(mouseX < 0){
				percent = 0;
			}else if(mouseX > bwidth){
				percent = 100;
			}else{
				percent = 100 * mouseX / bwidth;
			}
			dispatchEvent(new ControlBarEvent(ControlBarEvent.PROG_VOLUME));
			if(evt){
				evt.updateAfterEvent();
			}
		}
		
		protected function mouseUp(evt:MouseEvent):void{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
	}
}