package tv.hupu.events
{
	import flash.events.Event;
	
	/**
	 * 控制栏事件
	 * @author meiandai
	 * @date 2016-01-21
	 */	
	public class ControlBarEvent extends Event
	{
		
		/**
		 * 全屏/非全屏切换
		 */
		public static const BTN_SCREEN:String = "BTN_SCREEN";
		
		/**
		 * 分辨率切换
		 */
		public static const BTN_DEFI:String = "BTN_DEFI";
		
		/**
		 * 网页全屏/非全屏切换
		 */
		public static const BTN_WEB_SCREEN:String = "BTN_WEB_SCREEN";
		/**
		 * 音量
		 */
		public static const BTN_VOLUME:String = "BTN_VOLUME";
		
		/**
		 * 弹幕开关
		 */
		public static const BTN_BARRAGE:String = "BTN_BARRAGE";
		
		/**
		 * 点击刷新流
		 */		
		public static const BTN_REFRESH:String = "BTN_REFRESH";
		
		/**
		 * 音量条改变
		 */		
		public static const PROG_VOLUME:String = "PROG_VOLUME";
		
		/**
		 * 发送弹幕
		 */		
		public static const BTN_SEND:String = "BTN_SEND";
		
		private var _data:Object;
		
		public function ControlBarEvent(type:String, data:Object = null){
			super(type, true, false);
			_data = data;
		}
		
		public function get data():Object {
			return _data;
		}
	}
}