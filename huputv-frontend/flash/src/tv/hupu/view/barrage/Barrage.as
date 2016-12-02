package tv.hupu.view.barrage
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import tv.hupu.conf.BarrageConfig;
	import tv.hupu.events.JSInterfaceEvent;
	import tv.hupu.utils.JS2AS;
	
	/**
	 * 弹幕层
	 * @author meiandai
	 * @date 2016-01-21
	 */	
	public class Barrage extends Sprite
	{
		protected var _on:Boolean = true;
		protected var _trackList:Vector.<Track>;
		
		public function Barrage()
		{
			if(this.stage){
				init();
			}else{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		/**
		 * 是否开启
		 * @return 
		 * 
		 */		
		public function get on():Boolean
		{
			return _on;
		}
		
		/**
		 * 是否开启
		 * 
		 */
		public function set on(value:Boolean):void
		{
			_on = value;
			if(_trackList){
			for(var i:int = 0, ilen:int = _trackList.length; i < ilen; i++){
				var track:Track = _trackList[i];
					track.on = value;
					track.visible = value;
				}
			}
		}

		/**
		 * 注入Service实例
		 * @param srv
		 * 
		 */		
		public function injectService(srv:JS2AS):void{
			srv.addEventListener(JSInterfaceEvent.RECEIVE_MSG, receiveMsg);
			srv.addEventListener(JSInterfaceEvent.RECEIVE_SELF_MSG, receiveMsg);
		}
		
		/**
		 * 初始化
		 * 
		 */		
		protected function init(evt:Event = null):void{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(Event.RESIZE, resetTrack);
			_trackList = new Vector.<Track>();
			resetTrack();
		}
		
		/**
		 * 重置轨道
		 * 
		 */		
		protected function resetTrack(evt:Event = null):void{
			var track:Track;
			var _num:int = Math.floor(stage.stageHeight * 4 / 5 / BarrageConfig.TRACK_HEIGHT);
			while(_trackList.length > _num){
				track = _trackList.pop();
				if(contains(track)){
					removeChild(track);
				}
			}
			while(_trackList.length < _num){
				track = new Track();
				track.name = "track_" + _trackList.length;
				track.x = 0;
				track.y = _trackList.length * BarrageConfig.TRACK_HEIGHT;
				track.on = _on;
				addChild(track);
				_trackList.push(track);
			}
		}
		
		/**
		 * 获取特定的轨道，目前是随机
		 * @return 
		 * 
		 */		
		protected function getSpecTrack():Track{
			if(_trackList && _trackList.length){
				var index:int = -1;
				var frames:int = int.MAX_VALUE;
				var pos:Number = stage.stageWidth * 2;
				for(var i:int = 0, ilen:int = _trackList.length; i < ilen; i++){
					var track:Track = _trackList[i];
					
					if(track.rightPos < pos){	//取最后个弹幕在最左的轨道
						pos = track.rightPos;
						index = i;
					}				
//					if(track.trackframes < frames){	//取剩余帧数最小的轨道
//						frames = track.trackframes;
//						index = i;
//					}
				} 
				return index >= 0 ? _trackList[index] : null;
			}
			return null;
		}
		
		/**
		 * 接收到消息
		 * @param evt
		 * 
		 */		
		protected function receiveMsg(evt:JSInterfaceEvent):void{
			if(_on && evt && evt.data){
				var data:String = String(evt.data);
				var track:Track = getSpecTrack();
				if(track && data){
					track.addBullet(data, evt.type == JSInterfaceEvent.RECEIVE_SELF_MSG);
				}
			}
			
		}
	}
}