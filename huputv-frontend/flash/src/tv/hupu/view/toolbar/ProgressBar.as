package tv.hupu.view.toolbar
{
	import com.greensock.TweenLite;
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import tv.hupu.events.ControlBarEvent;
	import tv.hupu.utils.SOStorage;
	
	/**
	 * 进度条
	 * @author meiandai
	 * 
	 */	
	public class ProgressBar extends Sprite
	{
		protected var _percent:Number = 0;	//音量百分比，[0,100]
		protected var _bg_bar:Sprite;		//背景滑槽，鼠标交互区域
		protected var _active_bar:Sprite;	//滑块左侧进度条
		protected var _dragger:Sprite;		//滑块
		protected var _bwidth:Number = 100;
		protected const bheight:int = 4;
		protected const bradius:int = 2;
		protected const dragger_radius:int = 4;
		protected const active_color:uint = 0xfdb644;
		protected const bg_color:uint = 0x8a480c;
		protected const dragger_color:uint = 0xfbfff7;
		
		public function ProgressBar()
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
			
			initActiveBar();
			initDragger();
		}
		
		public function set bwidth(value:Number):void
		{
			value = value < 100 ? 100 : value;
			_bwidth = value;
			init();
		}

		protected function init():void{
			initBG();
			initActiveBar();
			initDragger();
			percent = SOStorage.getValue(SOStorage.KEY_VOLUME) ? Number(SOStorage.getValue(SOStorage.KEY_VOLUME)) : 65;
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
			gph.drawRoundRect(0, bheight/2, _bwidth, bheight * 2, bradius);
			gph.beginFill(bg_color);
			gph.drawRoundRect(0, -bheight/2, _bwidth, bheight, bradius);
			gph.endFill();
		}
		
		
		protected function initDragger():void{
			if(!_dragger){
				_dragger = new Sprite();
				_dragger.mouseEnabled = false;
				var gph:Graphics = _dragger.graphics;
				gph.clear();
				gph.beginFill(dragger_color);
				gph.drawCircle(0, 0, dragger_radius);
				gph.endFill();
				addChild(_dragger);
			}
			
			_dragger.x = _percent * _bwidth / 100;
//			TweenLite.to(_dragger, 0.1, {x: _percent * _bwidth / 100});
		}
		
		protected function initActiveBar():void{
			if(!_active_bar){
				_active_bar = new Sprite();
				_active_bar.mouseEnabled = false;
				addChild(_active_bar);
			}
			if(!_percent || _percent <= 0){
				return;
			}
			var gph:Graphics = _active_bar.graphics;
			gph.clear();
			gph.beginFill(active_color);
			gph.drawRoundRect(0, -bheight/2, _percent * _bwidth / 100, bheight, bradius);
			gph.endFill();
		}
		
		protected function mouseDown(evt:MouseEvent):void{
			mouseMove();
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		
		protected function mouseMove(evt:MouseEvent = null):void{
			if(mouseX < 0){
				_percent = 0;
			}else if(mouseX > _bwidth){
				_percent = 100;
			}else{
				_percent = 100 * mouseX / _bwidth;
			}
			dispatchEvent(new ControlBarEvent(ControlBarEvent.PROG_PLAYING));
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