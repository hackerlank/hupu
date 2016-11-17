package tv.hupu
{ 
	import flash.display.Sprite;
	import flash.events.NetStatusEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.net.ObjectEncoding;
	
	import tv.hupu.utils.ConsTrace;
	
	
	public class testRtmpPlayer extends Sprite  
	{  
		var nc:NetConnection;  
		var ns:NetStream;  
		var video:Video;  
		
		
		public function testRtmpPlayer()  
		{  
			nc = new NetConnection();  
			nc.client = this;
			nc.objectEncoding = ObjectEncoding.AMF0;
			nc.addEventListener(NetStatusEvent.NET_STATUS, netConnectionStatusHandler);  
			nc.connect("rtmp://pull6.arenazb.hupu.com/test");  
//			nc.connect("rtmp://ws.live.hupucdn.com/prod");  
			
			
		}  
		
		public function onBWDone():void { 
			trace("onBWDone"); 
		} 

		private function netConnectionStatusHandler(event:NetStatusEvent):void  
		{  
			trace("netConnectionStatusHandler event.info.level: " + event.info.level + "\n", "event.info.code: " + event.info.code);  
			switch (event.info.code)  
			{  
				case "NetConnection.Connect.Success":  
					doVideo(nc);  
					break;  
				case "NetConnection.Connect.Failed":  
					break;  
				case "NetConnection.Connect.Rejected":  
					break;  
				case "NetStream.Play.Stop":  
					break;  
				case "NetStream.Play.StreamNotFound":  
					break;  
			}  
		}  
		
		private function netStreamStatusHandler(event:NetStatusEvent):void  
		{  
			trace("netStreamStatusHandler event.info.level: " + event.info.level + "\n", "event.info.code: " + event.info.code);  
			switch (event.info.code)  
			{  
				case "NetConnection.Connect.Success":  
					doVideo(nc);  
					break;  
				case "NetConnection.Connect.Failed":  
					break;  
				case "NetConnection.Connect.Rejected":  
					break;  
				case "NetStream.Play.Stop":  
					break;  
				case "NetStream.Play.StreamNotFound":  
					break;  
			}  
		}  
		
		// play a recorded stream on the server  
		private function doVideo(nc:NetConnection):void {  
			ns = new NetStream(nc);  
			var customClient:Object = new Object(); 
			customClient.onMetaData = function(obj:*){
				for (var i:String in obj) {  
					trace(i + ": " + obj[i]);  
				} 
			}
			ns.client = customClient;
			ns.addEventListener(NetStatusEvent.NET_STATUS, netStreamStatusHandler);  
			
			
			video = new Video(640,480);  
			video.attachNetStream(ns);  
			
			
//			ns.play("18f31436ebf7217b0e629ae1dcc47596_1500");  
//			ns.close();
//			ns.play("18f31436ebf7217b0e629ae1dcc47596");  
//			ns.play("ef7165e6ccef99742d1dbe73d1b957dc");  
			ns.play("ef7165e6ccef99742d1dbe73d1b957dc");  
			addChild(video);  
		}  
		
	}  
} 