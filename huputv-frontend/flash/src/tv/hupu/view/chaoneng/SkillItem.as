package tv.hupu.view.chaoneng
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class SkillItem extends Sprite
	{
		public static const LOGO_WIDTH:int = 50;	//技能图标宽度
		public static const LOGO_HEIGHT:int = 50;	//技能图标高度
		public static const SPACING:int = 30;	//技能间距
		
		protected var data:Object;	//技能数据
		protected var isRight:Boolean;	//显示在右侧
		protected var iconBg:Sprite;	//图标背景
		protected var loader:Loader;	//图标
		protected var txtCtn:Sprite;	//文字说明Sprite
		protected var txtField:TextField;	//文字
		protected var _skillId:String;	//技能ID

		
		public function SkillItem(data:Object, _isRight:Boolean = false)
		{
			this.data = data;
			isRight = _isRight;
			init();
		}

		public function get skillId():String
		{
			return data.hasOwnProperty('skill_id') ? data['skill_id'] : '';
		}
		
		public function init():void{
			iconBg = new Sprite();
			iconBg.graphics.beginFill(0xff0000, 0);
			iconBg.graphics.drawRect(-SkillItem.LOGO_WIDTH/2, -SkillItem.LOGO_HEIGHT/2, SkillItem.LOGO_WIDTH, SkillItem.LOGO_HEIGHT);
			iconBg.graphics.endFill();
			addChild(iconBg);
			
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loaderError);
			loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loaderError);
			loader.x = -SkillItem.LOGO_WIDTH / 2;
			loader.y = -SkillItem.LOGO_HEIGHT / 2;
			loader.load(new URLRequest(data['skill_logo']));
			
			txtField = new TextField();
			txtField.defaultTextFormat = new TextFormat(null, 12, 0xffffff);
			txtField.autoSize = 'left';
			txtField.selectable = false;
			txtField.htmlText = data['teamName'] + '正在使用<FONT COLOR="#ffc363">[' + data['skill_name'] + ']</FONT>';
			txtField.x = 3;
			txtField.y = -txtField.height/2;
			
			txtCtn = new Sprite();
			txtCtn.graphics.beginFill(0x000000, 0.5);
			txtCtn.graphics.lineStyle(1, 0xb3b5be);
			txtCtn.graphics.drawRect(-1, -11, txtField.width + 5, 22);
			txtCtn.graphics.endFill();
			txtCtn.visible = false;
			txtCtn.x = isRight ? -SkillItem.LOGO_WIDTH / 2 - txtCtn.width + 2 : SkillItem.LOGO_WIDTH / 2;
			txtCtn.addChild(txtField);
			addChild(txtCtn);
			
			addEventListener(MouseEvent.ROLL_OVER, mouseHandler);
			addEventListener(MouseEvent.ROLL_OUT, mouseHandler);
			addEventListener(MouseEvent.MOUSE_OVER, mouseHandler);
			addEventListener(MouseEvent.MOUSE_OUT, mouseHandler);
		}

		public function destroy():void{
			removeEventListener(MouseEvent.ROLL_OVER, mouseHandler);
			removeEventListener(MouseEvent.ROLL_OUT, mouseHandler);
			removeEventListener(MouseEvent.MOUSE_OVER, mouseHandler);
			removeEventListener(MouseEvent.MOUSE_OUT, mouseHandler);
			if(loader){
				loader.unloadAndStop();
			}
		}
		
		protected function mouseHandler(evt:MouseEvent):void{
			if(evt.type == MouseEvent.ROLL_OVER || evt.type == MouseEvent.MOUSE_OVER ){
				txtCtn.visible = true;
			}else{
				txtCtn.visible = false;
			}
		}
		
		/**
		 * 加载完成
		 * @param evt
		 * 
		 */		
		protected function loaderComplete(evt:Event):void{
			if(loader && loader.width && loader.height){	//缩放以适应尺寸
				loader.scaleX = SkillItem.LOGO_WIDTH / loader.width;
				loader.scaleY = SkillItem.LOGO_HEIGHT / loader.height;
				addChild(loader);
			}
		}
		
		/**
		 * 加载错误
		 * @param evt
		 * 
		 */		
		protected function loaderError(evt:Event):void{
			
		}
		
	}
}