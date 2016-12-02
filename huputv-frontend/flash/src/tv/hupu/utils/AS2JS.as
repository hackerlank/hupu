package tv.hupu.utils
{
	import flash.external.ExternalInterface;

	/**
	 * JS交互接口收口 
	 * @author meiandai
	 * 
	 */	
	public class AS2JS
	{
		
		public static const GET_STREAM_ADDRESS:String = 'HTV.flashStreamAddress';
		public static const SEND_BAIDU_PLAYEVENT:String = 'HTV.sendBaiduPlayEvent';
		public static const SEND_DACE_PLAYEVENT:String = 'HTV.sendDacePlayTime';
		public static const EMIT_CHAT:String = 'HTV.emitChat';
		public static const GET_BEANS:String = 'HTV.getBeans';
		public static const GET_VIDEOJJ:String = 'HTV.getVideoJJ';
		public static const FULLSCREEN_VIDEO:String = 'HTV.fullScreenVideo';
		public static const GET_LOCATION:String = 'location.href';
		public static const SHARE_DATA:String = 'HTV.shareData';
		
		private static var pageUrl:String = "";
		private static var roomID:String = "";
		
		public function AS2JS(priv:PrivClass)
		{
		}
		
		private static function callJS(...args):*{
			trace("callJS: ", args);
			if(ExternalInterface.available){
				try{
					ConsTrace.htrace(args);
					var res:Object = ExternalInterface.call.apply(null, args);
					ConsTrace.htrace(JSON.stringify(res));
					return res;
				}catch(e:Error){
					
				}
				return;
			}
			return;
		}
		
		/**
		 * 发送聊天
		 * @return 
		 */		
		public static function getVideoJJ():Object{
			return callJS(GET_VIDEOJJ);
		}
		
		/**
		 * 发送聊天
		 * @return 
		 */		
		public static function emitChat(str:String):void{
			callJS(EMIT_CHAT, str);
		}
		
		/**
		 * 获取任务金豆
		 * @return 
		 */		
		public static function getBeans():void{
			callJS(GET_BEANS);
		}
		
		/**
		 * 发送百度统计事件
		 * @return 
		 */		
		public static function sendBaiduPlayEvent(type:String):void{
			callJS(SEND_BAIDU_PLAYEVENT, type);
		}
		
		/**
		 * 发送Dace统计时长
		 * @return 
		 */		
		public static function sendDaceDurEvent(val:Number):void{
			callJS(SEND_DACE_PLAYEVENT, val);
		}
		
		/**
		 * 发送百度统计时长
		 * @return 
		 */		
		public static function sendBaiduDurEvent(type:int, val:Number):void{
			callJS(SEND_BAIDU_PLAYEVENT, val, {"type":type, "source":"pc"});
		}
		/**
		 * 获取页面分享相关信息
		 * @return 
		 * 
		 */		
		public static function getShareData():Object{
			return callJS('eval', SHARE_DATA);
		}
		
		/**
		 * 获取页面URL
		 * @return 
		 * 
		 */		
		public static function getPageURL():String{
			if(!pageUrl){
				pageUrl = callJS('eval', 'window.location.href');
			}
			return pageUrl;
		}
		
		
		/**
		 * 获取房间ID
		 * @return 
		 * 
		 */		
		public static function getRoomID():String{
			if(!pageUrl){
				pageUrl = getPageURL();
			}
			if(!roomID && pageUrl){
				var pattern:RegExp = /(\/\d+)/ig; 
				var results:Array = pageUrl.match(pattern);
				roomID = results.length ? results[0].replace("/","") : "";
			}
			return roomID;
		}
		
		/**
		 * 获取流地址
		 * @return 
		 * 
		 */		
		public static function getAddress():Array{
			return callJS(GET_STREAM_ADDRESS);
		}
		
		/**
		 * 网页全屏
		 * 
		 */		
		public static function webFullscreen():void{
			callJS(FULLSCREEN_VIDEO);
		}
	}
}

class PrivClass{
	
}