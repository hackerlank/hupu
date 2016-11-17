package tv.hupu.view.barrage
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import tv.hupu.conf.BarrageConfig;
	import tv.hupu.events.BarrageBulletEvent;
	
	/**
	 * 弹幕元素
	 * @author meiandai
	 * 
	 */	
	public class Bullet extends Sprite
	{
		protected var _isSelf:Boolean;
		protected var _speed:Number;
		protected var _color:uint;
		protected var _content:String;
		protected var _size:int;
		protected var _font:String;
		protected var _text:TextField;
		protected var _on:Boolean = true;
		protected var _trackframes:int;	//上一个弹幕运行完成所需帧数
		public static const OFFSET:int = 40;	//偏移，防止弹幕过于集中
		
		public function Bullet(){
			
		}

		public function get frames():int
		{
			return Math.ceil((x + _text.width + OFFSET) / _speed);;
		}

		public function set on(value:Boolean):void
		{
			_on = value;
		}
		
		public function get canInsertSibling():Boolean{
			return x + _text.width + OFFSET < stage.stageWidth;
		}

		public function setData(cfg:Object = null):void
		{	
			_isSelf = Boolean(cfg.self);
			_font = cfg.font ? cfg.font : BarrageConfig.BULLET_FONT;
			_size = cfg.size ? cfg.size : BarrageConfig.BULLET_SIZE;
			_color = cfg.color != undefined ? cfg.color : BarrageConfig.BULLET_COLOR;
			_speed = cfg.speed ? cfg.speed : (BarrageConfig.BULLET_MIN_SPEED + Math.random()*(BarrageConfig.BULLET_MAX_SPEED - BarrageConfig.BULLET_MIN_SPEED));
			_content = cfg.content;

			if(this.stage){
				init();
			}else{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}

		public function get content():String
		{
			return _content;
		}

		public function set content(value:String):void
		{
			_content = value;
		}

		public function get color():uint
		{
			return _color;
		}

		public function set color(value:uint):void
		{
			_color = value;
		}

		public function get speed():Number
		{
			return _speed;
		}

		public function set speed(value:Number):void
		{
			_speed = value;
		}
		
		protected function init(evt:Event = null):void{
			mouseEnabled = false;
			mouseChildren = false;
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_text= new TextField();
			_text.multiline = false;
			_text.autoSize = "left";
			_text.defaultTextFormat = new TextFormat(_font, _size, _color, false, null, _isSelf);
			_text.htmlText = _content;
			_text.y = (BarrageConfig.TRACK_HEIGHT - _text.height) / 2;
			_text.antiAliasType = "normal";
			_text.filters = [new GlowFilter(0x000000, 0.3, 2, 2, 6, 1, false, false)];  
			addChild(_text);
			
			x = stage.stageWidth;
			
			addEventListener(Event.ENTER_FRAME, move);
		}
		
		protected function move(evt:Event):void{
			if(!_on){
//				return;
			}
			x -= _speed;
			if(x <= -width - OFFSET){
				destroy();
			}
		}
		
		protected function destroy():void{
			dispatchEvent(new BarrageBulletEvent(BarrageBulletEvent.JOB_DONE));
			removeEventListener(Event.ENTER_FRAME, move);
			if(parent){
				parent.removeChild(this);
			}
		}
	}
}