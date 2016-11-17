package tv.hupu.utils
{
	import flash.net.SharedObject;

	public class SOStorage
	{
		
		private static const NAME:String = "hupu.tv";
		/**
		 * 是否关闭弹幕
		 */		
		public static const KEY_BARRAGE_OFF:String = "KEY_BARRAGE_OFF";
		/**
		 * 音量
		 */		
		public static const KEY_VOLUME:String = "KEY_VOLUME";
		/**
		 * 输入文本
		 */		
		public static const KEY_CHAT_INPUT:String = "KEY_CHAT_INPUT";
		/**
		 * 分辨率
		 */		
		public static const KEY_DEFI:String = "KEY_DEFI";
		/**
		 * 统计，播放时长
		 */		
		public static const KEY_STATIS_PLAYTIME:String = "KEY_STATIS_PLAYTIME";
		
		public function SOStorage()
		{
		}
		
		public static function setValue(key:String, val:*):void{
			getSo().data[key] = val;
			getSo().flush();
		}
		
		public static function getValue(key:String):Object{
			return getSo().data[key];
		}
		
		public static function clear():void{
			return getSo().clear();
		}
		
		private static function getSo():SharedObject {
			return SharedObject.getLocal(NAME);
		}
	}
}