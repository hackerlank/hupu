package tv.hupu.events
{
	import flash.events.Event;
	
	/**
	 * socket收发服务事件
	 * @author meiandai
	 * @date 2016-01-21
	 */	
	public class SocketServiceEvent extends Event
	{
		
		/**
		 * 收到弹幕事件 
		 */
		public static const RECEIVE_MSG:String = "RECEIVE_MSG";
		
		/**
		 * 收到自己的弹幕事件 
		 */
		public static const RECEIVE_SELF_MSG:String = "RECEIVE_SELF_MSG";
		/**
		 * 收到特殊礼物，右上角弹出
		 */
		public static const RECEIVE_SPECIAL_GIFT:String = "RECEIVE_SPECIAL_GIFT";
		/**
		 * 收到底部礼物，如人浪，在播放器底部弹出
		 */
		public static const RECEIVE_WAVE_GIFT:String = "RECEIVE_WAVE_GIFT";
		/**
		 * 获取金豆
		 */
		public static const RECEIVE_GET_BEANS:String = "RECEIVE_GET_BEANS";
		/**
		 * 获取金豆结果
		 */
		public static const RECEIVE_GET_BEANS_RESULT:String = "RECEIVE_GET_BEANS_RESULT";
		/**
		 * 获取金豆成功
		 */
		public static const RECEIVE_GET_BEANS_SUC:String = "RECEIVE_GET_BEANS_SUC";
		/**
		 * 获取金豆失败
		 */
		public static const RECEIVE_GET_BEANS_FAI:String = "RECEIVE_GET_BEANS_FAI";
		/**
		 * 超能技能上线
		 */
		public static const RECEIVE_SKILL_STAT_ON:String = "RECEIVE_SKILL_STAT_ON";
		/**
		 * 超能技能下线
		 */
		public static const RECEIVE_SKILL_STAT_OFF:String = "RECEIVE_SKILL_STAT_OFF";
		
		private var _data:Object;
		
		public function SocketServiceEvent(type:String, data:Object = null){
			super(type, true, false);
			_data = data;
		}
		
		public function get data():Object {
			return _data;
		}
	}
}