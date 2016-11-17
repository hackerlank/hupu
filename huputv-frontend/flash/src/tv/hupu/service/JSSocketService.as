package tv.hupu.service
{
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.utils.Timer;
	
	import tv.hupu.events.SocketServiceEvent;
	import tv.hupu.utils.ConsTrace;
	import tv.hupu.utils.JSInterface;

	/**
	 * JS Socket收发service，单例
	 * @author meiandai
	 * @date 2016-01-21
	 */	
	public class JSSocketService extends EventDispatcher
	{
		
		protected static var _instance:JSSocketService;
		
		public function JSSocketService(priv:privateClass)
		{
			
		}
		
		/**
		 * 单例方法
		 * @return 
		 * 
		 */		
		public static function getInstance():JSSocketService{
			if(!_instance){
				_instance = new JSSocketService(new privateClass());
				if(ExternalInterface.available){
					try{
						ExternalInterface.addCallback("vjs_rcvChat", _instance.rcvChat);
						ExternalInterface.addCallback("vjs_rcvSelfChat", _instance.rcvSelfChat);
						ExternalInterface.addCallback("vjs_rcvGift", _instance.rcvGift);
						ExternalInterface.addCallback("callFromJS", _instance.callFromJS);
					}catch(e:Error){
						
					}
				}
				
//				var timer:Timer = new Timer(2000);
//				timer.addEventListener(TimerEvent.TIMER, function(evt:TimerEvent):void{
//					_instance.callFromJS({
//						"data": {
//							"skill_visible": "1", 
//							"skill_logo": "http://w2.hoopchina.com.cn/3a/1d/c3/3a1dc321e9a6b7f4eea16aecbb709c57001.jpg", 
//							"skill_name": "胡蓉测试技能1", 
//							"skill_id": "34", 
//							"skill_value": "1", 
//							"isHomeTeam": Math.random() > 0.5 ? true : false,
//							"teamName": Math.random() > 0.5 ? "国青队" : "中国队",
//							"team_id": Math.random() > 0.5 ? "12" : "66", 
//							"skill_status": 1, 
//							"game_id": "72"
//						}, 
//						"key": Math.random() > 0.5 ? "skillcardOnline" : "skillcardOffline"
//					});
//				});
//				timer.start();
				
//				var stimer:Timer = new Timer(6000);
//				stimer.addEventListener(TimerEvent.TIMER, function(evt:TimerEvent):void{
//					_instance.callFromJS({ 
//						"key":"getBeans",    //通知领取金豆
//						"data":{
//							"msg":"你有10个金豆可 <FONT COLOR='#ff7e00'><a href='event:getBeans'>领取</a></FONT>"
//						}
//					});
//				});
//				stimer.start();
			}
			return _instance;
		}
		
		/**
		 * JS-Flash通用接口
		 * @param obj [Object]
		 * 
		 */		
		public function callFromJS(obj:Object):void{
			ConsTrace.htrace('callFromJS: ' + JSON.stringify(obj));
			if(obj && obj.hasOwnProperty('key')){
				var _data:Object = obj.hasOwnProperty('data') ? obj['data'] : '';
				switch(obj['key']){
					case 'getBeans':
						if(_data.hasOwnProperty('msg')){
							_instance.getBeans(String(_data['msg']));
						}
						break;
					case 'getBeansResult':
						if(_data.hasOwnProperty('msg')){
							_instance.getBeansResult(String(_data['msg']));
						}
						break;
					case 'skillcardOnline':
						rcvSkillStat(_data, 1);
						break;
					case 'skillcardOffline':
						rcvSkillStat(_data, 0);
						break;
					case 'videojjInit':
						rcvSkillStat(_data, 0);
						break;
					default:
						break;
				}
			}
		}
		
		/**
		 * 接收弹幕
		 * @param str
		 * 
		 */		
		public function rcvChat(str:String):void{
			if(str){
				dispatchEvent(new SocketServiceEvent(SocketServiceEvent.RECEIVE_MSG, str));
			}
		}
		
		/**
		 * 接收自己的弹幕
		 * @param str
		 * 
		 */		
		public function rcvSelfChat(str:String):void{
			if(str){
				dispatchEvent(new SocketServiceEvent(SocketServiceEvent.RECEIVE_SELF_MSG, str));
			}
		}
		
		/**
		 * Video++参数
		 * @param data 技能数据
		 * @param on 上线1, 下线0
		 * 
		 */		
		public function rcvVideoJJ(data:Object, on:int = 0):void{
			//ConsTrace.htrace('rcvSkillStat: ' + data.team_id, on);
			if(data && data.hasOwnProperty('skill_logo') && data.hasOwnProperty('team_id')){
				dispatchEvent(new SocketServiceEvent(on ? SocketServiceEvent.RECEIVE_SKILL_STAT_ON : SocketServiceEvent.RECEIVE_SKILL_STAT_OFF, data));
			}
		}
		
		/**
		 * 超能技能上下线
		 * @param data 技能数据
		 * @param on 上线1, 下线0
		 * 
		 */		
		public function rcvSkillStat(data:Object, on:int = 0):void{
//			ConsTrace.htrace('rcvSkillStat: ' + data.team_id, on);
			if(data && data.hasOwnProperty('skill_logo') && data.hasOwnProperty('team_id')){
				dispatchEvent(new SocketServiceEvent(on ? SocketServiceEvent.RECEIVE_SKILL_STAT_ON : SocketServiceEvent.RECEIVE_SKILL_STAT_OFF, data));
			}
		}
		
		/**
		 * 接收特殊礼物，显示在右上角
		 * @param str
		 * 
		 */		
		public function rcvGift(obj:Object):void{
			if(obj && obj.hasOwnProperty('position')){
				switch (int(obj.position)){
					case 1:	//特殊礼物，从右上角弹出
						dispatchEvent(new SocketServiceEvent(SocketServiceEvent.RECEIVE_SPECIAL_GIFT, obj));
						break;
					case 2:	//人浪
						dispatchEvent(new SocketServiceEvent(SocketServiceEvent.RECEIVE_WAVE_GIFT, obj));
						break;
					default:
						break;
				}
				
			}
		}
		
		public function getBeans(msg:String):void{
			dispatchEvent(new SocketServiceEvent(SocketServiceEvent.RECEIVE_GET_BEANS, msg));
		}
		
		public function getBeansResult(msg:String):void{
			dispatchEvent(new SocketServiceEvent(SocketServiceEvent.RECEIVE_GET_BEANS_RESULT, msg));
		}
		
		/**
		 * 发送弹幕
		 * 
		 */		
		public function send(str:String):void{
			if(str){
				JSInterface.emitChat(str);
			}
		}
		
	}
}

class privateClass{
	
}