package tv.hupu.view.stage
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import tv.hupu.utils.ConsTrace;
	import tv.hupu.utils.AS2JS;
	
	
	public class VideoJJ extends Sprite
	{
		private var loader:Loader;
		private var obj:Object;
		
		public function VideoJJ()
		{
			if(this.stage){
				init();
			}else{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		protected function init(evt:Event = null):void{
			/**
			 * 根据传入的object初始化
			 * 需要用到的参数有:
			 *  width       播放器宽度
			 *  height      播放器高度
			 *  appkey      应用标识
			 *  referer     当前页面的页面地址
			 *  source      视频地址(点播时为平台方ID＋视频唯一ID 如:"$youtube$123456dsfh"  直播时为平台方ID 如: "zhanqi")
			 *  type        播放类型 默认点播  0 直播 1 点播
			 * ====================以上参数直播／点播必填===================
			 *
			 *
			 *  time_callback       获取视频当前时间回调
			 *  play_callback       继续播放回调
			 *  pause_callback      暂停播放回调
			 *=====================以上3个参数点播必填=====================
			 *
			 *
			 *  mediaName   样式版本，有特殊定制样式需求的平台使用
			 *  anchor      是否开启打点模式（0：不开启 1:开启 直播模式下，这里由平台判断用户是否有权限打点）
			 *  userID      video＋＋用户名
			 *  userPwd		video＋＋密码
			 *  isAllowAD	是否开启广告通投 默认false
			 */
			
			
			obj = {};
			obj.width = stage.stageWidth;
			obj.height = stage.stageHeight;
			//obj.time_callback = function():Number{ return player.time };
			
			//合并js传入参数
			var cusParam:Object = AS2JS.getVideoJJ();
			if(cusParam){
				for(var item:Object in cusParam){
					obj[item] = cusParam[item];
				}
			}else{
				return;				
			}
			ConsTrace.htrace(JSON.stringify(obj));
			
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadCompleteHandler);
			loader.load(new URLRequest("http://flash.videojj.com/bin/videoPlus.swf"));
		}
		function loadCompleteHandler(e:Event):void
		{
			var videoPlsDS:DisplayObject = loader.content as DisplayObject;
			if(!videoPlsDS){
				return;
			}
			addChild(videoPlsDS);

			(videoPlsDS as Object).initializeByObject(obj);
		}

	}
}