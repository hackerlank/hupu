package tv.hupu.view.gift
{
	import com.greensock.TweenLite;
	import com.jx.gif.GIF;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	import org.bytearray.display.ScaleBitmap;
	
	import tv.hupu.events.JSInterfaceEvent;
	import tv.hupu.utils.JS2AS;
	
	/**
	 * 人浪礼物特效，显示在底部
	 * @author meiandai
	 * 
	 */	
	public class WaveGift extends Sprite
	{
		protected var isShown:Boolean = false;
		protected var swfLoader:Loader;
		protected var queue:Array;
		protected var showTimer:Timer;
		protected var ctn:Sprite;
		protected var msgSpt:Sprite;
		protected var msgTf:TextField;
		protected var gif:GIF;
		protected var bg:Bitmap;
		protected var bgscale9:ScaleBitmap;
		protected var pngLoader:Loader;
		protected const PADDING:int = 10;	//元素间间隔

		//嵌入图片
		[Embed(source="../../../../../assets/gift_msg_bg_transp.png")]
		private var GiftMsgBg:Class;
		
		public function WaveGift()
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
			
			stage.addEventListener(Event.RESIZE, loaderComplete);
			JS2AS.getInstance().addEventListener(JSInterfaceEvent.RECEIVE_WAVE_GIFT, receiveGift);
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
			addChild(ctn);
			
			msgSpt = new Sprite();
			msgSpt.visible = false;
			msgSpt.alpha = 0;
			
			bg = new GiftMsgBg() as Bitmap;
			bgscale9 = new ScaleBitmap(bg.bitmapData);
			bgscale9.scale9Grid = new Rectangle(40,1,140,44);
			msgSpt.addChild(bgscale9);
			
			msgTf = new TextField();
			msgTf.selectable = false;
			msgTf.defaultTextFormat = new TextFormat('微软雅黑,Microsoft YaHei,黑体,Arial', 18, 0xffffff);
			msgTf.autoSize = 'left';
			msgTf.x = 40;

			msgSpt.addChild(msgTf);
			msgSpt.x = (stage.stageWidth - msgSpt.width)/2;
			msgSpt.y = stage.stageHeight - 100;
			ctn.addChild(msgSpt);
		}
		
		/**
		 * 加载完成
		 * @param evt
		 * 
		 */		
		protected function loaderComplete(evt:Event):void{
			if(swfLoader){
				//人浪舞台尺寸为800*600, 
				swfLoader.scaleX = swfLoader.scaleY = stage.stageWidth / 1000;	//1000为礼物显示的最佳尺寸，将按比例进行缩放
				swfLoader.x = (stage.stageWidth - 800*swfLoader.scaleX)/2; 	//定位于舞台中下方
				swfLoader.y = stage.stageHeight - 600*swfLoader.scaleY + 50; 
			}
			msgSpt.x = (stage.stageWidth - msgSpt.width)/2;
			msgSpt.y = stage.stageHeight - 100;
		}
		
		/**
		 * 加载错误
		 * @param evt
		 * 
		 */		
		protected function loaderError(evt:Event):void{
			
		}
		
		/**
		 * 显示，弹出礼物特效
		 * 
		 */		
		protected function show():void{
			if(isShown){
				return;
			}
			var data:Object = queue.shift();
			while(!data.hasOwnProperty('effect_file_flash_url') && queue.length){
				data = queue.shift();
			}
			
			if(data.hasOwnProperty('effect_file_flash_url')){
				isShown = true;
				if(!swfLoader){
					swfLoader = new Loader();
					swfLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderComplete);
					swfLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loaderError);
					swfLoader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loaderError);
					ctn.addChildAt(swfLoader, 0); 
				}
				data.username = String(data.username).substr(0, 12);
				var str:String = '<FONT COLOR="#fff43c">'+data.username + '</FONT> 送出' + data.total + '个';
				msgTf.htmlText = str;
				msgTf.y = (bg.height - msgTf.height)/2;
				if(!pngLoader){
					pngLoader = new Loader();
					pngLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(){
						pngLoader.width = pngLoader.height = 60;
						pngLoader.y = (bgscale9.height - pngLoader.height)/2;
					});
					pngLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function(){});
					pngLoader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, function(){});
					msgSpt.addChild(pngLoader); 
//					pngLoader.width = pngLoader.height = 60;
				}
				pngLoader.x = msgTf.x + msgTf.width + PADDING;
				pngLoader.load(new URLRequest(data['effect_file_icon_url']));
				swfLoader.load(new URLRequest(data['effect_file_flash_url']));
				swfLoader.visible = isShown;
				msgSpt.visible = isShown;
				msgSpt.x = (stage.stageWidth - msgSpt.width)/2;
				bgscale9.width = pngLoader.x + 60 + 40;
				TweenLite.to(swfLoader, 0.5, {alpha: 0.8, y:swfLoader.y - 50});
				TweenLite.to(msgSpt, 0.1, {alpha: 1});
				showTimer = new Timer(15000, 1);
				showTimer.addEventListener(TimerEvent.TIMER, hide);
				showTimer.start();
			}
		}
		
		/**
		 * 隐藏，收回礼物特效
		 * 
		 */		
		protected function hide(evt:TimerEvent):void{
			showTimer.removeEventListener(TimerEvent.TIMER, hide);
			showTimer = null;
			TweenLite.to(swfLoader, 0.5, {alpha: 0, y:swfLoader.y + 50, onComplete:hideComplete});
			TweenLite.to(msgSpt, 0.1, {alpha: 0});
		}

		/**
		 * 隐藏动画完成
		 * 
		 */		
		protected function hideComplete():void{
			isShown = false;
			swfLoader.visible = isShown;
			msgSpt.visible = isShown;

			if(queue.length){
				show();
			}
		}

		/**
		 * 收到礼物
		 * @param evt
		 * 
		 */		
		protected function receiveGift(evt:JSInterfaceEvent):void{
			queue.push(evt.data);
			if(queue.length == 1){	//如果当前队列只有一个，则直接显示
				show();
			}
		}
		
	}
}