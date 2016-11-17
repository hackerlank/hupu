package tv.hupu.view.toolbar
{
	import flash.display.Bitmap;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	
	import tv.hupu.conf.ControlBarConfig;
	import tv.hupu.events.ControlBarEvent;
	import tv.hupu.utils.ConsTrace;
	import tv.hupu.utils.SOStorage;
	import tv.hupu.utils.ToolTip;
	
	/**
	 * 控制栏
	 * @author meiandai
	 * 
	 */	
	public class ControlBar extends Sprite
	{
		//嵌入图片
		[Embed(source="../../../../../assets/refresh.png")]
		private var RefreshBitmap:Class;
		[Embed(source="../../../../../assets/fullscreen.png")]
		private var FullScreenBitmap:Class;
		[Embed(source="../../../../../assets/normalscreen.png")]
		private var NormalScreenBitmap:Class;
		[Embed(source="../../../../../assets/fullscreen_web.png")]
		private var FullScreenWebBitmap:Class;
		[Embed(source="../../../../../assets/normalscreen_web.png")]
		private var NormalScreenWebBitmap:Class;
		[Embed(source="../../../../../assets/barrage.png")]
		private var BarrageBitmap:Class;
		[Embed(source="../../../../../assets/barrage_off.png")]
		private var BarrageOffBitmap:Class;
		[Embed(source="../../../../../assets/volume.png")]
		private var VolumeBitmap:Class;
		
		private var _vol:Number;
		private var _isBarrageOn:Boolean = true;
		
		private var _leftGroup:Sprite;
		private var _rightGroup:Sprite;
		private var _inputGroup:Sprite;
		private var _inputText:TextField;
		private var _sendBtn:Sprite;
		private var _refreshBtn:CtlButton;
		private var _fullscreenWebBtn:CtlButton;
		private var _normalscreenWebBtn:CtlButton;
		private var _isWebFullscreen:Boolean = false;
		private var _fullscreenBtn:CtlButton;
		private var _normalscreenBtn:CtlButton;
		private var _barrageBtn:CtlButton;
		private var _barrageOffBtn:CtlButton;
		private var _volumeBtn:CtlButton;
		private var _volumeBar:VolumeBar;
		private var _defiBtn:DefinBtn;
		
		public function ControlBar()
		{
			if(this.stage){
				init();
			}else{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		/**
		 * 获取流地址
		 * 
		 */		
		public function getStreamData():void{
			_defiBtn.getDefData();
		}
		
		/**
		 * 获取音量
		 * 
		 */		
		public function getVolume():Number{
			if(_volumeBar){
				return _volumeBar.percent;
			}
			return 0;
		}
		
		/**
		 * 设置音量
		 * 
		 */		
		public function setVolume(val:Number):void{
			if(_volumeBar){
				_volumeBar.percent = val;
			}
		}
		
		/**
		 * 弹幕是否开启
		 * @return 
		 * 
		 */		
		public function get isBarrageOn():Boolean
		{
			return _isBarrageOn;
		}
		
		/**
		 * 是否网页全屏
		 * @return 
		 * 
		 */		
		public function get isWebFullscreen():Boolean
		{
			return _isWebFullscreen;
		}
		
		/**
		 * 隐藏弹出层
		 * @return 
		 * 
		 */		
		public function hideDefiPopup():void
		{
			return _defiBtn.hidePopup();
		}

		/**
		 * 初始化
		 * 
		 */		
		protected function init(evt:Event = null):void{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(Event.RESIZE, stageResize);
			stage.addEventListener(FullScreenEvent.FULL_SCREEN, fullScreen);
			initBG();
			initLeftGroup();
			initRightGroup();
			//initInputGroup();   //延迟初始化输入框，防止全屏时弹出输入确认框
			//resetInputSize();
		}
		
		/**
		 * 初始化背景
		 * 
		 */		
		protected function initBG():void{
			graphics.clear();
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(stage.stageWidth, ControlBarConfig.CONTROLBAR_HEIGHT, Math.PI/2);
			graphics.beginGradientFill(GradientType.LINEAR, [ControlBarConfig.CONTROLBAR_COLOR, ControlBarConfig.CONTROLBAR_COLOR], [ControlBarConfig.CONTROLBAR_ALPHA1, ControlBarConfig.CONTROLBAR_ALPHA2], [0,255], matrix);
			graphics.drawRect(0, 0, stage.stageWidth, ControlBarConfig.CONTROLBAR_HEIGHT);
			graphics.endFill();
		}
		
		/**
		 * 左按钮组
		 * 
		 */		
		protected function initLeftGroup():void{
			_leftGroup = new Sprite();
			addChild(_leftGroup);
			
			_refreshBtn = new CtlButton();
			_refreshBtn.addEventListener(MouseEvent.CLICK, refresh);
			_refreshBtn.btm = new RefreshBitmap() as Bitmap;
			_refreshBtn.x = 35;
			_leftGroup.addChild(_refreshBtn);
			ToolTip.register(_refreshBtn, "刷新");
		}
		
		/**
		 * 右按钮组
		 * 
		 */		
		protected function initRightGroup():void{
			_rightGroup = new Sprite();
			_rightGroup.x = stage.stageWidth;
			addChild(_rightGroup);
			
			//全屏按钮
			_fullscreenBtn = new CtlButton();
			_fullscreenBtn.addEventListener(MouseEvent.CLICK, screenClick);
			_fullscreenBtn.btm = new FullScreenBitmap() as Bitmap;
			_fullscreenBtn.x = -30;
			_rightGroup.addChild(_fullscreenBtn);
			ToolTip.register(_fullscreenBtn, "窗口全屏");
			
			//退出全屏按钮
			_normalscreenBtn = new CtlButton();
			_normalscreenBtn.visible = false;
			_normalscreenBtn.addEventListener(MouseEvent.CLICK, screenClick);
			_normalscreenBtn.btm = new NormalScreenBitmap() as Bitmap;
			_normalscreenBtn.x = _fullscreenBtn.x;
			_rightGroup.addChild(_normalscreenBtn);
			ToolTip.register(_normalscreenBtn, "退出窗口全屏");
			
			
			//网页全屏按钮
			_fullscreenWebBtn = new CtlButton();
			_fullscreenWebBtn.addEventListener(MouseEvent.CLICK, webScreenClick);
			_fullscreenWebBtn.btm = new FullScreenWebBitmap() as Bitmap;
			_fullscreenWebBtn.x = -80;
			_rightGroup.addChild(_fullscreenWebBtn);
			ToolTip.register(_fullscreenWebBtn, "网页全屏");
			
			//退出网页全屏按钮
			_normalscreenWebBtn = new CtlButton();
			_normalscreenWebBtn.visible = false;
			_normalscreenWebBtn.addEventListener(MouseEvent.CLICK, webScreenClick);
			_normalscreenWebBtn.btm = new NormalScreenWebBitmap() as Bitmap;
			_normalscreenWebBtn.x = _fullscreenWebBtn.x;
			_rightGroup.addChild(_normalscreenWebBtn);
			ToolTip.register(_normalscreenWebBtn, "退出网页全屏");
			
			//弹幕打开按钮
			_barrageBtn = new CtlButton();
			_barrageBtn.addEventListener(MouseEvent.CLICK, barrageClick);
			_barrageBtn.btm = new BarrageBitmap() as Bitmap;
			_barrageBtn.x = -130;
			_rightGroup.addChild(_barrageBtn);
			ToolTip.register(_barrageBtn, "点击关闭弹幕");
			
			//弹幕关闭状态按钮
			_barrageOffBtn = new CtlButton();
			_barrageOffBtn.addEventListener(MouseEvent.CLICK, barrageOffClick);
			_barrageOffBtn.btm = new BarrageOffBitmap() as Bitmap;
			_barrageOffBtn.x = -130;
			_barrageOffBtn.visible = false;
			_rightGroup.addChild(_barrageOffBtn);
			ToolTip.register(_barrageOffBtn, "点击打开弹幕");
			
			//清晰度选择
			_defiBtn = new DefinBtn();
			_defiBtn.x = -185;
			_defiBtn.y = ControlBarConfig.CONTROLBAR_HEIGHT/2;
			_defiBtn.addEventListener(ControlBarEvent.BTN_DEFI, defiClick);
			_rightGroup.addChild(_defiBtn);
			
			//音量按钮
			_volumeBtn = new CtlButton();
			_volumeBtn.addEventListener(MouseEvent.CLICK, volumeClick);
			_volumeBtn.btm = new VolumeBitmap() as Bitmap;
			_volumeBtn.x = -350;
			_rightGroup.addChild(_volumeBtn);
			ToolTip.register(_volumeBtn, "音量");
			
			_volumeBar = new VolumeBar();
			_volumeBar.x = -330;
			_volumeBar.y = ControlBarConfig.CONTROLBAR_HEIGHT/2;
			_volumeBar.addEventListener(ControlBarEvent.PROG_VOLUME, volumeProg);
			_rightGroup.addChild(_volumeBar);
		}
		
		/**
		 * 输入文本框组
		 * 
		 */		
		protected function initInputGroup():void{
			_inputGroup = new Sprite();
			_inputGroup.x = 66;
			
			
			_inputText = new TextField();
			_inputText.multiline = false;
			_inputText.type = TextFieldType.INPUT;
			_inputText.defaultTextFormat = new TextFormat(null, 14, 0xffffff);
			_inputText.height = 20;//_inputText.textHeight;
			_inputText.maxChars = 60;
			_inputText.y = (ControlBarConfig.CONTROLBAR_HEIGHT - _inputText.height)/2;
			_inputText.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			_inputText.text = SOStorage.getValue(SOStorage.KEY_CHAT_INPUT) ? String(SOStorage.getValue(SOStorage.KEY_CHAT_INPUT)) : "";
			_inputGroup.addChild(_inputText);
			
			_sendBtn = new Sprite();
			_sendBtn.buttonMode = true;
			_sendBtn.mouseChildren = false;
			_sendBtn.graphics.beginFill(0xc01e2f);
			_sendBtn.graphics.drawRoundRect(-37, -12, 74, 25, 3);
			_sendBtn.graphics.endFill();
			_sendBtn.addEventListener(MouseEvent.CLICK, send);
			var _sendText:TextField = new TextField();
			_sendText.defaultTextFormat = new TextFormat("Microsoft YaHei", 13, 0xffffff);
			_sendText.autoSize = "left";
			_sendText.text = "发送";
			_sendText.x = -_sendText.width/2;
			_sendText.y = -_sendText.height/2;
			_sendBtn.addChild(_sendText);
			_sendBtn.y = ControlBarConfig.CONTROLBAR_HEIGHT/2;
			_inputGroup.addChild(_sendBtn);
		}
		
		/**
		 * 重置输入区尺寸
		 * 
		 */		
		protected function resetInputSize():void{
			var marginHor:int = 4;
			var marginVer:int = 2;
			
			if(_inputGroup){
				_inputText.x = marginHor;
				_inputText.width = stage.stageWidth - 580;
				_inputGroup.graphics.clear();
				_inputGroup.graphics.lineStyle(1, 0x434141);
				_inputGroup.graphics.drawRect(0, -_inputText.height/2 - marginVer + ControlBarConfig.CONTROLBAR_HEIGHT/2, _inputText.width + marginHor*2, _inputText.height + marginVer*2);
				_inputGroup.graphics.endFill();
				_sendBtn.x = _inputText.width + 56;
			}
		}
		
		/**
		 * 键盘事件
		 * @param evt
		 * 
		 */		
		protected function keyDown(evt:KeyboardEvent):void{
			if(evt.keyCode == Keyboard.ENTER){
				send();
			}else{
				SOStorage.setValue(SOStorage.KEY_CHAT_INPUT, _inputText.text);
			}
		}
		
		/**
		 * 舞台尺寸变更
		 * @param evt
		 * 
		 */		
		protected function stageResize(evt:Event):void{
			initBG();
			_rightGroup.x = stage.stageWidth;
			resetInputSize();
		}
		
		/**
		 * 发送弹幕
		 * @param evt
		 * 
		 */		
		protected function send(evt:MouseEvent = null):void{
			var str:String = _inputText.text.replace(/(^\s*)|(\s*$)/g,"");
			if(str){
				dispatchEvent(new ControlBarEvent(ControlBarEvent.BTN_SEND, str));
				_inputText.text = "";
				SOStorage.setValue(SOStorage.KEY_CHAT_INPUT, _inputText.text);
			}
		}
		
		/**
		 * 刷新流
		 * @param evt
		 * 
		 */		
		protected function refresh(evt:MouseEvent = null):void{
			dispatchEvent(new ControlBarEvent(ControlBarEvent.BTN_REFRESH));
		}
		
		/**
		 * 切换弹幕
		 * @param evt
		 * 
		 */		
		protected function barrageClick(evt:MouseEvent = null):void{
			dispatchBarrageSwitch(false);
		}
		
		/**
		 * 切换弹幕
		 * @param evt
		 * 
		 */		
		protected function barrageOffClick(evt:MouseEvent = null):void{
			dispatchBarrageSwitch(true);
		}
		
		protected function dispatchBarrageSwitch(on:Boolean = false):void{
			_isBarrageOn = on;
			_barrageBtn.visible = on;
			_barrageOffBtn.visible = !on;
			dispatchEvent(new ControlBarEvent(ControlBarEvent.BTN_BARRAGE, _isBarrageOn));
		}
		
		/**
		 * 切换清晰度
		 * @param evt
		 * 
		 */		
		protected function defiClick(evt:ControlBarEvent):void{
			dispatchEvent(new ControlBarEvent(ControlBarEvent.BTN_DEFI, evt.data));
		}
		
		/**
		 * 音量按钮
		 * @param evt
		 * 
		 */
		protected function volumeClick(evt:MouseEvent = null):void{
			if(_volumeBar.percent){
				_vol = _volumeBar.percent;
				_volumeBar.percent = 0;
			}else{
				_volumeBar.percent = _vol;
			}
			
			dispatchEvent(new ControlBarEvent(ControlBarEvent.BTN_VOLUME, _volumeBar.percent));
		}
		
		/**
		 * 音量条
		 * @param evt
		 * 
		 */
		protected function volumeProg(evt:ControlBarEvent = null):void{
			if(_volumeBar.percent){
				_vol = _volumeBar.percent;
			}
			
			dispatchEvent(new ControlBarEvent(ControlBarEvent.BTN_VOLUME, _volumeBar.percent));
		}
		
		/**
		 * 切换网页全屏/非全屏
		 * @param evt
		 * 
		 */		
		protected function webScreenClick(evt:MouseEvent = null):void{
			_isWebFullscreen = !_isWebFullscreen;
			_normalscreenWebBtn.visible = _isWebFullscreen;
			_fullscreenWebBtn.visible = !_isWebFullscreen;
			if(!_inputGroup){
				initInputGroup();
				resetInputSize();
			}
			if(_isWebFullscreen){
				addChild(_inputGroup);
			}else{
				if(contains(_inputGroup)){
					removeChild(_inputGroup);
				}
			}
			dispatchEvent(new ControlBarEvent(ControlBarEvent.BTN_WEB_SCREEN, _isWebFullscreen));
		}
		
		/**
		 * 切换全屏/非全屏
		 * @param evt
		 * 
		 */		
		protected function screenClick(evt:MouseEvent = null):void{
			
			dispatchEvent(new ControlBarEvent(ControlBarEvent.BTN_SCREEN));
		}
		
		/**
		 * 全屏事件
		 * @param evt
		 * 
		 */		
		protected function fullScreen(evt:FullScreenEvent):void{
			var isFullScreen:Boolean = evt.fullScreen;
			_normalscreenBtn.visible = isFullScreen;
			_fullscreenBtn.visible = !isFullScreen;
			if(_inputGroup && contains(_inputGroup)){
				removeChild(_inputGroup);
			}
//			_inputGroup.visible = isFullScreen || _isWebFullscreen;
		}
	}
}