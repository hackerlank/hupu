package tv.hupu{

    import com.greensock.TweenLite;
    
    import flash.display.DisplayObject;
    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.display.StageDisplayState;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import flash.events.NetStatusEvent;
    import flash.events.TimerEvent;
    import flash.external.ExternalInterface;
    import flash.media.Video;
    import flash.net.URLRequest;
    import flash.utils.Timer;
    import flash.utils.getTimer;
    
    import tv.hupu.conf.ControlBarConfig;
    import tv.hupu.conf.ExternalErrorEventName;
    import tv.hupu.conf.ExternalEventName;
    import tv.hupu.events.ControlBarEvent;
    import tv.hupu.events.SocketServiceEvent;
    import tv.hupu.events.VideoJSEvent;
    import tv.hupu.events.VideoPlaybackEvent;
    import tv.hupu.service.JSSocketService;
    import tv.hupu.utils.ConsTrace;
    import tv.hupu.utils.JSInterface;
    import tv.hupu.utils.SOStorage;
    import tv.hupu.utils.Statistics;
    import tv.hupu.view.barrage.Barrage;
    import tv.hupu.view.chaoneng.Skill;
    import tv.hupu.view.gift.SpecialGift;
    import tv.hupu.view.gift.WaveGift;
    import tv.hupu.view.stage.StageLoading;
    import tv.hupu.view.stage.Toast;
    import tv.hupu.view.stage.VideoJJ;
    import tv.hupu.view.toolbar.ControlBar;

    public class VideoJSView extends Sprite{

        private var _uiVideo:Video;
        private var _uiBackground:Sprite;
		private var _uiWaveGift:WaveGift;	//人浪礼物特效层
		private var _uiSpecialGift:SpecialGift;	//礼物特效层
		private var _uiBarrage:Barrage;	//弹幕层
		private var _uiControl:ControlBar;	//控制栏
		private var _ctrlTimer:Timer;
		private var _stgLoading:StageLoading;
		private var _toast:Toast;
//		private var _skill:Skill;
		private var _videojj:VideoJJ;

		private var jsSocketService:JSSocketService;
        private var _model:VideoJSModel;

        public function VideoJSView(){
			if(this.stage){
				init();
			}else{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(evt:Event = null):void{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
            _model = VideoJSModel.getInstance();
            _model.addEventListener(VideoJSEvent.BACKGROUND_COLOR_SET, onBackgroundColorSet);
            _model.addEventListener(VideoJSEvent.STAGE_RESIZE, onStageResize);
            _model.addEventListener(VideoPlaybackEvent.ON_META_DATA, onMetaData);
            _model.addEventListener(VideoPlaybackEvent.ON_VIDEO_DIMENSION_UPDATE, onDimensionUpdate);
			_model.addEventListener(VideoPlaybackEvent.ON_NETSTREAM_STATUS, onNetStreamStatus);
			
			jsSocketService = JSSocketService.getInstance();
			jsSocketService.addEventListener(SocketServiceEvent.RECEIVE_GET_BEANS, rcvCoin);
			jsSocketService.addEventListener(SocketServiceEvent.RECEIVE_GET_BEANS_RESULT, rcvCoinResult);
			Statistics.getInstance().model = _model;
	
            _uiBackground = new Sprite();
            _uiBackground.graphics.beginFill(0xff0000, 1);
            _uiBackground.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
            _uiBackground.graphics.endFill();
            _uiBackground.alpha = 0;
            addChild(_uiBackground);

            _uiVideo = new Video();
            _uiVideo.width = _model.stageRect.width;
            _uiVideo.height = _model.stageRect.height;
//			_uiVideo.opaqueBackground = 0xff0000;
//            _uiVideo.smoothing = true;
            addChild(_uiVideo);
			
//			_skill = new Skill();
//			addChild(_skill);
			
			_stgLoading = new StageLoading();
			addChild(_stgLoading);
			_stgLoading.show();

			_uiBarrage = new Barrage();
			_uiBarrage.injectService(jsSocketService);
			addChild(_uiBarrage);
			
			_uiSpecialGift = new SpecialGift();
			addChild(_uiSpecialGift);
			
			_uiWaveGift = new WaveGift();
			addChild(_uiWaveGift);
			
			_uiControl = new ControlBar();
			_uiControl.x = 0;
			_uiControl.y = stage.stageHeight;
			_uiControl.addEventListener(ControlBarEvent.BTN_REFRESH, controlbarEvent);
			_uiControl.addEventListener(ControlBarEvent.BTN_BARRAGE, controlbarEvent);
			_uiControl.addEventListener(ControlBarEvent.BTN_WEB_SCREEN, controlbarEvent);
			_uiControl.addEventListener(ControlBarEvent.BTN_SCREEN, controlbarEvent);
			_uiControl.addEventListener(ControlBarEvent.BTN_VOLUME, controlbarEvent);
			_uiControl.addEventListener(ControlBarEvent.BTN_SEND, controlbarEvent);
			_uiControl.addEventListener(ControlBarEvent.BTN_DEFI, controlbarEvent);
			stage.addEventListener(Event.RESIZE, stageResize);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, showCtrlbar);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, showCtrlbar);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, showCtrlbar);
			stage.addEventListener(MouseEvent.MOUSE_OUT, resetCtrlTimer);
			_ctrlTimer = new Timer(2500, 1);
			_ctrlTimer.addEventListener(TimerEvent.TIMER, ctrlTimer);
			addChild(_uiControl);
			
			_toast = new Toast();
			addChild(_toast);
			
			_videojj = new VideoJJ();
			addChild(_videojj);
			
//			addChild(_skill);
			
            _model.videoReference = _uiVideo;
			_uiControl.getStreamData();
			
        }
		
		/**
		 * 控制栏事件
		 * @param evt
		 * @return 
		 * 
		 */		
		private function controlbarEvent(evt:ControlBarEvent):void{
			if(evt.type == ControlBarEvent.BTN_REFRESH){
				Statistics.getInstance().sendBtnClick(Statistics.COUNT_REFRESH);
				//刷新当前流
				if(_model.rtmpStream){
					_model.rtmpStream = _model.rtmpStream;
				}
			}else if(evt.type == ControlBarEvent.BTN_BARRAGE){
				//弹幕开关
				var _on:Boolean = Boolean(evt.data);
				Statistics.getInstance().sendBtnClick(_on ? Statistics.COUNT_BARON : Statistics.COUNT_BAROFF);
				_uiBarrage.on = _on;
				SOStorage.setValue(SOStorage.KEY_BARRAGE_OFF, _on);
			}else if(evt.type == ControlBarEvent.BTN_SCREEN){
				//屏幕控制
				if(stage.displayState == StageDisplayState.NORMAL){
					Statistics.getInstance().sendBtnClick(Statistics.COUNT_FULLSCREEN);
					stage.displayState = StageDisplayState.FULL_SCREEN;
				}else{
					stage.displayState = StageDisplayState.NORMAL;
				}
			}else if(evt.type == ControlBarEvent.BTN_WEB_SCREEN){
				//切换网页全屏
				if(Boolean(evt.data)){
					Statistics.getInstance().sendBtnClick(Statistics.COUNT_WEBFS);
				}
				if(ExternalInterface.available){
					//屏幕控制
					if(stage.displayState != StageDisplayState.NORMAL){
						stage.displayState = StageDisplayState.NORMAL;
					}
					try{
						ExternalInterface.call('HTV.fullScreenVideo');
					}catch(e:Error){
						
					}
				}
			}else if(evt.type == ControlBarEvent.BTN_VOLUME){
				//音量控制
				_model.volume = Number(evt.data) / 100;
			}else if(evt.type == ControlBarEvent.BTN_SEND){
				//发送弹幕
				JSSocketService.getInstance().send(String(evt.data));
				Statistics.getInstance().sendBtnClick(Statistics.COUNT_SEND);
			}else if(evt.type == ControlBarEvent.BTN_DEFI){
				//清晰度选择
				var _arr:Array = String(evt.data).split("/");
				var _st:String = _arr.pop();
//				ConsTrace.htrace(_arr.join("/") + "|" + _st);
				if(_model.rtmpStream != _st){
					_model.autoplay = true;
					_model.rtmpConnectionURL = _arr.join("/");	//rtmpConnectionURL: rtmp://pull6.arenazb.hupu.com/test
					_model.rtmpStream = _st;	//rtmpStream：f1c12bd966d0ae1a71b2b0b723fd0473_1000
//					_model.rtmpConnectionURL = "rtmp://hsn.mpl.miisolutions.net/hsn-live01";
//					_model.rtmpStream = "mp4:420p500kB31";
				}
			}
		}


        private function sizeVideoObject():void{

            var __targetWidth:int, __targetHeight:int;

            var __availableWidth:int = _model.stageRect.width;
            var __availableHeight:int = _model.stageRect.height;

            var __nativeWidth:int = 100;

            if(_model.metadata.width != undefined){
                __nativeWidth = Number(_model.metadata.width);
            }

            if(_uiVideo.videoWidth != 0){
                __nativeWidth = _uiVideo.videoWidth;
            }

            var __nativeHeight:int = 100;

            if(_model.metadata.width != undefined){
                __nativeHeight = Number(_model.metadata.height);
            }

            if(_uiVideo.videoWidth != 0){
                __nativeHeight = _uiVideo.videoHeight;
            }

            // first, size the whole thing down based on the available width
            __targetWidth = __availableWidth;
            __targetHeight = __targetWidth * (__nativeHeight / __nativeWidth);

            if(__targetHeight > __availableHeight){
                __targetWidth = __targetWidth * (__availableHeight / __targetHeight);
                __targetHeight = __availableHeight;
            }

            _uiVideo.width = __targetWidth;
            _uiVideo.height = __targetHeight;

            _uiVideo.x = Math.round((_model.stageRect.width - _uiVideo.width) / 2);
            _uiVideo.y = Math.round((_model.stageRect.height - _uiVideo.height) / 2);
        }

        private function onBackgroundColorSet(e:VideoPlaybackEvent):void{
            _uiBackground.graphics.clear();
            _uiBackground.graphics.beginFill(_model.backgroundColor, 1);
            _uiBackground.graphics.drawRect(0, 0, _model.stageRect.width, _model.stageRect.height);
            _uiBackground.graphics.endFill();
        }

        private function onStageResize(e:VideoJSEvent):void{

            sizeVideoObject();
        }

        private function onMetaData(e:VideoPlaybackEvent):void{
			for (var i:String in _model.metadata) {  
				ConsTrace.htrace(i + ": " + _model.metadata[i]);  
			}  
			
//			_model.volume = Number(_uiControl.getVolume()) / 100;
			_uiControl.setVolume(_model.volume * 100);
			
            sizeVideoObject();
        }

        private function onDimensionUpdate(e:VideoPlaybackEvent):void{
            sizeVideoObject();
        }
		
		private function onNetStreamStatus(evt:VideoPlaybackEvent):void{
			switch(evt.data.info.code){
				case "NetStream.Play.Start":
				case "NetStream.Buffer.Empty":
				case "NetStream.Seek.Notify":
					_stgLoading.show();
					break;
				case "NetStream.Buffer.Full":
					_stgLoading.hide();
					break;
				case "NetStream.Play.Stop":
				case "NetStream.Play.StreamNotFound":
					break;
				default:
					break;
			}
		}
		
		/**
		 * 领取任务金豆通知
		 * @param evt [SocketServiceEvent] msg: 你有10个金豆可 <FONT COLOR='#ff7e00'><a href='event:getBeans'>领取</a></FONT>
		 * 
		 */		
		private function rcvCoin(evt:SocketServiceEvent):void{
			//只在全屏模式下才显示领取金豆
			var msg:String = String(evt.data);
			if(msg && (_uiControl.isWebFullscreen || stage.displayState != StageDisplayState.NORMAL)){
				_toast.show(msg, 5);
				if(!_toast.hasEventListener('getBeans')){
					_toast.addEventListener('getBeans', getBeans);
				}
			}
		}
		
		/**
		 * 用户点击获取金币
		 * 
		 */		
		private function getBeans(evt:Event):void{
			JSInterface.getBeans();
//			rcvCoinResult(new SocketServiceEvent(SocketServiceEvent.RECEIVE_GET_BEANS_RESULT, "领取成功"));
		}
		
		/**
		 * 领取任务金豆通知
		 * @param num
		 * 
		 */		
		private function rcvCoinResult(evt:SocketServiceEvent):void{
			//只在全屏模式下才显示领取金豆成功/失败
			var msg:String = String(evt.data);
			if(msg && (_uiControl.isWebFullscreen || stage.displayState != StageDisplayState.NORMAL)){
				_toast.show(msg, 2);
			}
		}
		
		private function stageResize(e:Event):void{
			_uiBackground.graphics.clear();
			_uiBackground.graphics.beginFill(0xff0000, 1);
			_uiBackground.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			_uiBackground.graphics.endFill();
			
			TweenLite.killTweensOf(_uiControl);
			resetCtrlTimer();
			_uiControl.y = stage.stageHeight - ControlBarConfig.CONTROLBAR_HEIGHT;
		}

		private function showCtrlbar(evt:Event = null):void{
			resetCtrlTimer();
			TweenLite.to(_uiControl, 0.4, {y: stage.stageHeight - ControlBarConfig.CONTROLBAR_HEIGHT});
		}
		
		private function resetCtrlTimer(evt:Event = null):void{
			_ctrlTimer.reset();
			_ctrlTimer.start();
		}
		
		private function ctrlTimer(evt:TimerEvent):void{
			_uiControl.hideDefiPopup();
			TweenLite.to(_uiControl, 0.6, {y: stage.stageHeight});
		}

    }
}
