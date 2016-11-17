package tv.hupu.view.gift
{
	import com.greensock.TweenLite;
	import com.jx.gif.GIF;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	import tv.hupu.events.SocketServiceEvent;
	import tv.hupu.service.JSSocketService;
	
	/**
	 * 特殊礼物，目前有666和MVP，显示在右上角
	 * @author meiandai
	 * 
	 */	
	public class SpecialGift extends Sprite
	{
		protected var isShown:Boolean = false;
		protected var queue:Array;
		protected var showTimer:Timer;
		protected var ctn:Sprite;
		protected var msgTf:TextField;
		protected var gif:GIF;
		protected var gifBG:Sprite;
		protected var bg:Bitmap;
		protected var thisX:Bitmap;
		protected var times:Sprite;
		
		protected const NUMBER_WIDTH:int = 23;	//倍数单个数字的宽度
		protected const PADDING:int = 8;	//元素间间隔
		protected const GIF_WIDTH:int = 70;	//gif动画宽高
		protected const GIF_HEIGHT:int = 70;
		
		//嵌入图片
		[Embed(source="../../../../../assets/spe_gift_bg.png")]
		private var SpecialGiftBG:Class;
		//x符号
		[Embed(source="../../../../../assets/x.png")]
		private var X:Class;
		//数字
		[Embed(source="../../../../../assets/numb.png")]
		private var Numb:Class;
		
		public function SpecialGift()
		{
			if(this.stage){
				init();
			}else{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		
		/**
		 * 初始化
		 * 
		 */		
		protected function init(evt:Event = null):void{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			initModel();
			initUI();
			
			stage.addEventListener(Event.RESIZE, resetStage);
			JSSocketService.getInstance().addEventListener(SocketServiceEvent.RECEIVE_SPECIAL_GIFT, receiveSpecialGift);
		}
		
		/**
		 * 初始化数据
		 * 
		 */		
		protected function initModel():void{
			queue = [];
		}
		
		
		/**
		 * 初始化界面
		 * 
		 */		
		protected function initUI():void{
			ctn = new Sprite();
			ctn.x = stage.stageWidth;
			ctn.y = 45;
			addChild(ctn);
			
			bg = new SpecialGiftBG() as Bitmap;
			bg.y = -bg.height / 2;
			ctn.addChild(bg);
			
			thisX = new X() as Bitmap;
			thisX.x = 296;
			thisX.y = -thisX.height / 2;
			ctn.addChild(thisX);
			
			times = new Sprite();
			times.y = -15;
			ctn.addChild(times);
			
			gifBG = new Sprite();
			gifBG.graphics.lineStyle(1, 0xcbb68b);
			gifBG.graphics.drawRect(0, 0, GIF_HEIGHT + 1, GIF_HEIGHT + 1);
			gifBG.graphics.endFill();
			gifBG.x = 32;
			gifBG.y = -GIF_HEIGHT/2 - 1;
			gifBG.visible = false;
			ctn.addChild(gifBG);
			
			gif = new GIF();
			gif.addEventListener(Event.COMPLETE, gifComplete);
			gif.addEventListener(SecurityErrorEvent.SECURITY_ERROR, gifError);
			gif.addEventListener(IOErrorEvent.IO_ERROR, gifError);
			gif.x = gifBG.x + 1;
			gif.y = gifBG.y + 1;
			ctn.addChild(gif);

			msgTf = new TextField();
			msgTf.selectable = false;
			msgTf.x = 112;
			msgTf.defaultTextFormat = new TextFormat('微软雅黑,Microsoft YaHei,黑体,Arial', 18, 0xffffff);
			msgTf.autoSize = 'left';

			ctn.addChild(msgTf);
		}
		
		/**
		 * 显示，弹出礼物特效
		 * 
		 */		
		protected function show():void{
			if(queue && queue.length && !isShown){
				isShown = true;
				var data:Object = queue.shift();
				data.username = String(data.username).substr(0, 12);
				var str:String = data.username + ' 送出';
				msgTf.text = str;
				msgTf.y = - msgTf.height/2;
				thisX.x = msgTf.x + msgTf.width + PADDING;
				times.x = thisX.x + thisX.width + PADDING;
				gif.load(new URLRequest(data['effect_file_gif_url']));
				addTimes(data.total);
				TweenLite.to(ctn, 0.5, {x: stage.stageWidth - Math.min(bg.width, times.x + NUMBER_WIDTH * String(data.total).length + PADDING), onComplete:showComplete});
			}
		}
		
		/**
		 * 隐藏，收回礼物特效
		 * 
		 */		
		protected function hide():void{
			showTimer.removeEventListener(TimerEvent.TIMER, showTimerHandler);
			showTimer = null;
			TweenLite.to(ctn, 0.5, {x: stage.stageWidth, onComplete:hideComplete});
		}
		
		/**
		 * 显示动画完成
		 * 
		 */		
		protected function showComplete():void{
			showTimer = new Timer(1000, 10);
			showTimer.addEventListener(TimerEvent.TIMER, showTimerHandler);
			showTimer.start();
		}
		
		protected function showTimerHandler(evt:TimerEvent):void{
			if((showTimer.currentCount >= 1 && queue.length) || showTimer.currentCount >= 5){
				hide();
			}
		}
		
		/**
		 * 隐藏动画完成
		 * 
		 */		
		protected function hideComplete():void{
			isShown = false;
			if(gif){
				gif.dispose();
				gifBG.visible = false;
			}
			if(queue.length){
				show();
			}
		}
		
		protected function addTimes(count:int):void{
			if(!count){
				return;
			}
			while(times.numChildren){
				times.removeChildAt(0);
			}
			var str:String = String(count);
			for(var i:int = 0 ;i < str.length; i++){
				var _number:int = int(str.substr(i,1));
				var _ctn:Sprite = new Sprite();
				var _bm:Bitmap = new Numb() as Bitmap;
				_bm.x = -_number * NUMBER_WIDTH;
				var _mask:Sprite = new Sprite();
				_mask.graphics.beginFill(0xffffff);
				_mask.graphics.drawRect(0,0,NUMBER_WIDTH,34);
				_mask.graphics.endFill();
				_bm.mask = _mask;
				_ctn.addChild(_bm);
				_ctn.addChild(_mask);
				_ctn.x = i * NUMBER_WIDTH;
				times.addChild(_ctn);
			}
		}
		
		/**
		 * 重置舞台元素
		 * @param evt
		 * 
		 */		
		protected function resetStage(evt:Event):void{
			if(isShown){
				ctn.x = stage.stageWidth - bg.width;
			}else{
				ctn.x = stage.stageWidth;
			}
		}
		
		/**
		 * 动画加载完成
		 * @param event
		 * 
		 */		
		protected function gifComplete(event:Event):void{
			gif.width = GIF_WIDTH;
			gif.height = GIF_HEIGHT;
			gif.play();
			gifBG.visible = true;
		}
		
		/**
		 * 动画加载失败
		 * @param event
		 * 
		 */		
		protected function gifError(event:Event):void{
			trace(event);
		}
		
		/**
		 * 收到礼物
		 * @param evt
		 * 
		 */		
		protected function receiveSpecialGift(evt:SocketServiceEvent):void{
			queue.push(evt.data);
			if(queue.length == 1){	//如果当前队列只有一个，则直接显示
				show();
			}
		}
		
	}
}