package tv.hupu.view.toolbar
{
	import tv.hupu.conf.ControlBarConfig;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class CtlButton extends Sprite
	{
		
		protected var _btm:Bitmap;
		protected var _width:Number;
		protected var _height:Number;
		private var _invalidate:Boolean = false;
		
		public function CtlButton()
		{
			buttonMode = true;
			_width = ControlBarConfig.CONTROL_BTN_WIDTH;
			_height = ControlBarConfig.CONTROL_BTN_HEIGHT;
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		/**
		 * 设置宽度
		 * @param _w
		 * 
		 */		
		override public function set width(_w:Number):void{
			if(_w > 0 && _w != _width){
				_width = _w;
				_invalidate = true;
			}
		}
		
		/**
		 * 设置高度
		 * @param _h
		 * 
		 */		
		override public function set height(_h:Number):void{
			if(_h > 0 && _h != _height){
				_height = _h;
				_invalidate = true;
			}
		}
		
		/**
		 * 设置按钮图片
		 * @param path
		 * 
		 */		
		public function set btm(btm:Bitmap):void{
			_btm = btm;
			_invalidate = true;
		}

		/**
		 * 下帧延迟渲染
		 * @param evt
		 * 
		 */		
		private function onEnterFrame(evt:Event):void{
			if(_invalidate && _btm){
				graphics.clear();
				graphics.beginFill(0xFF0000, 0);
				graphics.drawRect(-_width/2, -_height/2, _width, _height);
				graphics.endFill();
				y = ControlBarConfig.CONTROLBAR_HEIGHT/2;
				
				var _scale:Number = 1;//Math.min(_btm.width / _width, _btm.height / _height);
				_btm.x = - (_scale*_btm.width)/2;
				_btm.y = - (_scale*_btm.height)/2;
				addChild(_btm);
				
				_invalidate = false;
			}
		}
	}
}