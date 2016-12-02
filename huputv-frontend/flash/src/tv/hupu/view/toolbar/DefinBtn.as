package tv.hupu.view.toolbar
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import tv.hupu.events.ControlBarEvent;
	import tv.hupu.utils.AS2JS;
	import tv.hupu.utils.ConsTrace;
	import tv.hupu.utils.SOStorage;
	import tv.hupu.utils.Statistics;
	
	/**
	 * 分辨率按钮
	 * @author meiandai
	 * 
	 */	
	public class DefinBtn extends Sprite
	{
		
		private var _defiText:TextField;
		private var _graphics:Graphics;
		private var _popupSpt:Sprite;
		private var _dispBtn:Sprite;
		private var _defData:Array;

		public function DefinBtn()
		{
			if(this.stage){
				init();
			}else{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		public function hidePopup():void{
			stageClick();
		}
		
		public function set enabled(bool:Boolean):void{
			buttonMode = bool;
			_dispBtn.mouseEnabled = bool;
		}
		
		public function highLight(id:int):void{
			var item:DefiItem;
			var itemNum:int = _popupSpt.numChildren;
			var minId:int = 0;
			var maxId:int = itemNum - 1;
			while(minId < itemNum && !DefiItem(_popupSpt.getChildAt(minId)).avail){
				minId ++;
			}
			while(maxId > 0 && !DefiItem(_popupSpt.getChildAt(maxId)).avail){
				maxId --;
			}
			id = id < minId ? minId : id;
			id = id > maxId ? maxId : id;
			for(var i:int = 0; i < itemNum; i++){
				if(_popupSpt.getChildAt(i) is DefiItem){
					DefiItem(_popupSpt.getChildAt(i)).setHighlight(false);
				}
			}
			DefiItem(_popupSpt.getChildAt(id)).setHighlight(true);
			_defiText.text = DefiItem(_popupSpt.getChildAt(id)).txt;
			dispatchEvent(new ControlBarEvent(ControlBarEvent.BTN_DEFI, _defData[id]['rtmp']));
			_defiText.x = -_defiText.width/2;
			_defiText.y = -_defiText.height/2;
		}
		
		public function getDefData():void{
			//通过JS接口获取直播地址
			var arr:Array = AS2JS.getAddress();
			if(_popupSpt && arr && arr is Array){
				_dispBtn.buttonMode = true;
				_defData = arr;
				var item:DefiItem;
				while(_popupSpt.numChildren){
					item = _popupSpt.getChildAt(0) as DefiItem;
					item.destroy();
					_popupSpt.removeChild(item);
				}
				var arrowHeight:Number = 10;
				var arrowWidth:Number = 10;
				var padding:Number = 0.5;
				for(var i:int = 0; i < arr.length; i++){
					var _data:Object = arr[i];
				  	item = new DefiItem(String(_data['name']), Boolean(_data['rtmp']));
					item.name = "item_" + i;
					item.y = -arrowHeight - padding - (i + 0.5)*DefiItem.ITEM_HEIGHT;
					item.addEventListener(MouseEvent.CLICK, itemClick);
					_popupSpt.addChild(item);
				}
				
				_popupSpt.graphics.clear();
				_popupSpt.graphics.beginFill(0x000000, 0.4);
				_popupSpt.graphics.lineStyle(1, 0xa9a9b2);
				_popupSpt.graphics.moveTo(0, 0);
				_popupSpt.graphics.lineTo(arrowWidth/2, -arrowHeight);
				_popupSpt.graphics.lineTo(DefiItem.ITEM_WIDTH/2 + padding, -arrowHeight);
				_popupSpt.graphics.lineTo(DefiItem.ITEM_WIDTH/2 + padding, -arrowHeight-DefiItem.ITEM_HEIGHT*i - padding*2);
				_popupSpt.graphics.lineTo(-DefiItem.ITEM_WIDTH/2 - padding, -arrowHeight-DefiItem.ITEM_HEIGHT*i - padding*2);
				_popupSpt.graphics.lineTo(-DefiItem.ITEM_WIDTH/2 - padding, -arrowHeight);
				_popupSpt.graphics.lineTo(-arrowWidth/2, -arrowHeight);
				_popupSpt.graphics.lineTo(0, 0);
				_popupSpt.graphics.endFill();
				
				highLight(SOStorage.getValue(SOStorage.KEY_DEFI) ? int(SOStorage.getValue(SOStorage.KEY_DEFI)) : 0);

			}else{
				buttonMode = false;
			}
		}
		
		protected function init(evt:Event = null):void{
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_dispBtn = new Sprite();
			_graphics = _dispBtn.graphics;
			_graphics = graphics;
			_graphics.lineStyle(1, 0xa9a9b2);
			_graphics.beginFill(0xFF0000, 0);
			_graphics.drawRect(-15, -10, 30, 20);
			_graphics.endFill();
			_dispBtn.addEventListener(MouseEvent.CLICK, dispClick);
			addChild(_dispBtn);
			
			_defiText = new TextField();
			_defiText.mouseEnabled = false;
			_defiText.defaultTextFormat = new TextFormat(null, 12, 0xa9a9b2);
			_defiText.autoSize = "left";
			_defiText.text = "标清";
			_defiText.x = -_defiText.width/2;
			_defiText.y = -_defiText.height/2;
			_dispBtn.addChild(_defiText);
			
			_popupSpt = new Sprite();
			_popupSpt.y = -18;
			_popupSpt.visible = false;
			addChild(_popupSpt);
		}
		
		protected function dispClick(evt:MouseEvent):void{
			_popupSpt.visible = !_popupSpt.visible;
			Statistics.getInstance().sendBtnClick(Statistics.COUNT_DEFI);
			if(stage && _popupSpt.visible){
				stage.addEventListener(MouseEvent.CLICK, stageClick, true);
			}
		}
		
		protected function stageClick(evt:MouseEvent = null):void{
			_popupSpt.visible = false;
			stage.removeEventListener(MouseEvent.CLICK, stageClick);
		}
		
		protected function itemClick(evt:MouseEvent):void{
			stage.removeEventListener(MouseEvent.CLICK, stageClick);
			var id:int = evt.currentTarget.name ? evt.currentTarget.name.split("_")[1] : 0;
			if(id == _defData.length - 1){	//如果选取了超清/普清的清晰度，下次进来将继续使用这个清晰度
				SOStorage.setValue(SOStorage.KEY_DEFI, int.MAX_VALUE);
			}else{
				SOStorage.setValue(SOStorage.KEY_DEFI, id);
			}
			Statistics.getInstance().sendBtnClick(Statistics.COUNT_DEFIITEM, _defData[id].name);
			highLight(id);
		}
	}
}


import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFormat;

/**
 * 清晰度选择项
 * @author meiandai
 * 
 */
class DefiItem extends Sprite{
	
	private var _txt:String;
	private var _tf:TextField;
	private var _avail:Boolean = true;
	
	public static const ITEM_WIDTH:int = 38;
	public static const ITEM_HEIGHT:int = 22;
	private const COLOR_NORMAL:uint = 0xffffff;
	private const COLOR_INAVAIL:uint = 0x999999;
	private const COLOR_HIGHLIGHT:uint = 0xf04e6f;
	private const TYPE_OVER:String = "TYPE_OVER";
	private const TYPE_NORMAL:String = "TYPE_NORMAL";
	
	public function DefiItem(txt:String, available:Boolean = true){
		this._txt = txt;
		this._avail = available;
		init();
	}
	
	public function get txt():String
	{
		return _txt;
	}
	
	public function get avail():Boolean
	{
		return _avail;
	}

	public function set txt(value:String):void
	{
		_txt = value;
		_tf.text = _txt;
	}

	public function setHighlight(hl:Boolean):void{
		if(_tf && _avail){
			_tf.textColor = hl ? COLOR_HIGHLIGHT : COLOR_NORMAL;
		}
	}
	
	public function destroy():void{
		removeEventListener(MouseEvent.MOUSE_OVER, mouseOver);
		removeEventListener(MouseEvent.MOUSE_OUT, mouseOut);
	}
	
	private function init():void{
		buttonMode = _avail;
		mouseEnabled = _avail;
		
		_tf = new TextField();
		_tf.mouseEnabled = false;
		_tf.defaultTextFormat = new TextFormat(null, 12, _avail ? COLOR_NORMAL : COLOR_INAVAIL, true);
		_tf.autoSize = "left";
		_tf.text = _txt;
		_tf.x = -_tf.width/2;
		_tf.y = -_tf.height/2;
		addChild(_tf);
		
		resetState();
		if(_avail){
			addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
	//		addEventListener(MouseEvent.CLICK, mouseClick);
		}
	}
	
	private function mouseOver(evt:MouseEvent){
		resetState(TYPE_OVER);
	}
	
	private function mouseOut(evt:MouseEvent){
		resetState(TYPE_NORMAL);
	}
	
	private function resetState(type:String = TYPE_NORMAL):void{
		if(_avail){
			graphics.clear();
			graphics.beginFill(0x000000, type == TYPE_NORMAL ? 0 : 0.7);
			graphics.drawRect(-ITEM_WIDTH/2, -ITEM_HEIGHT/2, ITEM_WIDTH, ITEM_HEIGHT);
			graphics.endFill();
		}
	}
}