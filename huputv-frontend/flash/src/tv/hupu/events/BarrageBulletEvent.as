package tv.hupu.events
{
	import flash.events.Event;
	
	/**
	 * 弹幕元素事件
	 * @author meiandai
	 * @date 2016-01-21
	 */	
	public class BarrageBulletEvent extends Event
	{
		
		/**
		 * 移动位置完成 
		 */
		public static const JOB_DONE:String = "JOB_DONE";
		
		private var _data:Object;
		
		public function BarrageBulletEvent(type:String, data:Object = null){
			super(type, true, false);
			_data = data;
		}
		
		public function get data():Object {
			return _data;
		}
	}
}