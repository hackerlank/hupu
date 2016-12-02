package tv.hupu.utils
{
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.utils.Timer;
	
	import tv.hupu.VideoJSModel;
	import tv.hupu.events.VideoPlaybackEvent;
	
	/**
	 * 统计
	 * @author meiandai
	 * 
	 */	
	public class Statistics
	{
		public static const COUNT_ERROR:String = "错误";
		public static const COUNT_LOADING:String = "卡顿";
		public static const COUNT_REFRESH:String = "刷新按钮";
		public static const COUNT_FULLSCREEN:String = "窗口全屏按钮";
		public static const COUNT_WEBFS:String = "网页全屏按钮";
		public static const COUNT_SEND:String = "弹幕发送按钮";
		public static const COUNT_DEFI:String = "清晰度按钮";
		public static const COUNT_BARON:String = "弹幕打开按钮";
		public static const COUNT_BAROFF:String = "弹幕关闭按钮";
		public static const COUNT_DEFIITEM:String = "清晰度项";
		
		public static const TYPE_DUR_PLAYTIME:int = 1;	//播放时长
		public static const TYPE_DUR_LOADING:int = 2;	//加载时长
		

		protected static var _instance:Statistics;
		protected static var _playTimer:Timer;
		protected static var _playTimerDur:Number = 5;//本地记录统计间隔/s
		protected static var _playTimerCount:int = 12;//记录次数，达到时发送统计
		protected static var _loadingStartTime:Number;//loading起始时间，用于统计loading时长
		
		protected var _model:VideoJSModel;
		
		public function Statistics(priv:privateClass)
		{
			
		}
		
		/**
		 * 单例方法
		 * @return 
		 * 
		 */		
		public static function getInstance():Statistics{
			if(!_instance){
				_instance = new Statistics(new privateClass());
				_playTimer = new Timer(_playTimerDur * 1000, _playTimerCount);
				_playTimer.addEventListener(TimerEvent.TIMER, timerHandler);
				_playTimer.addEventListener(TimerEvent.TIMER_COMPLETE, compHandler);
				_playTimer.start();
				
				if(SOStorage.getValue(SOStorage.KEY_STATIS_PLAYTIME)){
					sendPlayTime(Number(SOStorage.getValue(SOStorage.KEY_STATIS_PLAYTIME)));
				}
			}
			return _instance;
		}
		
		/**
		 * 发送错误信息
		 * @param info
		 * 
		 */		
		public function sendError(info:String):void{
			sendBaiduPlayEvent(COUNT_ERROR);
		}
		
		/**
		 * 发送按钮点击数
		 * @param info
		 * 
		 */		
		public function sendBtnClick(type:String, detail:String = ""):void{
			switch(type){
				case COUNT_REFRESH:
				case COUNT_FULLSCREEN:
				case COUNT_WEBFS:
				case COUNT_SEND:
				case COUNT_DEFI:
				case COUNT_BARON:
				case COUNT_BAROFF:
					sendBaiduPlayEvent(type);
					break;
				case COUNT_REFRESH:
					sendBaiduPlayEvent(type + (detail?"_"+detail:""));
					break;
				default:
					break;
			}
			
		}
		
		/**
		 * 设置model
		 * @param _m
		 * 
		 */		
		public function set model(_m:VideoJSModel):void{
			if(_model){
				_model.removeEventListener(VideoPlaybackEvent.ON_NETSTREAM_STATUS, onNetStreamStatus);
				_model = null;
			}
			
			if(_m){
				_model = _m;
				_model.addEventListener(VideoPlaybackEvent.ON_NETSTREAM_STATUS, onNetStreamStatus);
			}
		}
		
		public function get model():VideoJSModel{
			return _model;
		}
		
		/**
		 * 播放状态变更
		 * @param evt
		 * 
		 */		
		private function onNetStreamStatus(evt:VideoPlaybackEvent):void{
			switch(evt.data.info.code){
				case "NetStream.Buffer.Empty":
					sendLoadingCount();
				case "NetStream.Play.Start":
				case "NetStream.Seek.Notify":
					_loadingStartTime = new Date().time;
					break;
				case "NetStream.Buffer.Full":
					sendLoadingTime(new Date().time - _loadingStartTime);
					break;
				case "NetStream.Play.Stop":
				case "NetStream.Play.StreamNotFound":
				default:
					break;
			}
		}
		
		/**
		 * 定时器，写入本地
		 * @param evt
		 * 
		 */		
		private static function timerHandler(evt:TimerEvent):void{
			SOStorage.setValue(SOStorage.KEY_STATIS_PLAYTIME, Number(SOStorage.getValue(SOStorage.KEY_STATIS_PLAYTIME)) + _playTimerDur);
		}
		
		/**
		 * 定时器跑完，发送统计请求
		 * @param evt
		 * 
		 */		
		private static function compHandler(evt:TimerEvent):void{
			sendPlayTime(Number(SOStorage.getValue(SOStorage.KEY_STATIS_PLAYTIME)));
			_playTimer.reset();
			_playTimer.start();
		}
		
		/**
		 * 发送播放时长
		 * @param _sec
		 * 
		 */		
		private static function sendPlayTime(_sec:Number):void{
			sendBaiduDurEvent(TYPE_DUR_PLAYTIME, _sec/60);
			AS2JS.sendDaceDurEvent(_sec/60);
			SOStorage.setValue(SOStorage.KEY_STATIS_PLAYTIME, 0);
		}
		
		
		/**
		 * 发送loading时长
		 * @param _sec
		 * 
		 */		
		private static function sendLoadingTime(_sec:Number):void{
			sendBaiduDurEvent(TYPE_DUR_LOADING, _sec/1000);
		}
		
		/**
		 * 发送播放过程中loading次数，不包括第一次加载的loading
		 * @param _sec
		 * 
		 */		
		private static function sendLoadingCount():void{
			sendBaiduPlayEvent(COUNT_LOADING);
		}
		
		/**
		 * 发送百度事件统计
		 * @param _sec
		 * 
		 */		
		private static function sendBaiduPlayEvent(type:String):void{
//			ConsTrace.htrace("sendBaiduPlayEvent: " + type);
			AS2JS.sendBaiduPlayEvent(type);
		}
		
		/**
		 * 发送百度时长统计
		 * @param _sec
		 * 
		 */		
		private static function sendBaiduDurEvent(type:int, val:Number):void{
//			ConsTrace.htrace("sendBaiduDurEvent: " + type, val);
			AS2JS.sendBaiduDurEvent(type, val);
		}
	}
}

class privateClass{
	
}
