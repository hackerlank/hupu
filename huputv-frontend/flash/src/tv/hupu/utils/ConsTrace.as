package tv.hupu.utils
{
	import flash.external.ExternalInterface;

	/**
	 * flash日志在chrome控制台输出
	 * @author meiandai
	 * 
	 */	
	public class ConsTrace
	{
		public static function htrace(...arg):void
		{
			var str:String = arg.join(", ");
			if(str){
				trace(str);
				if(ExternalInterface.available){
					ExternalInterface.call("HTV.trace", str);
				}
			}
		}
	}
}