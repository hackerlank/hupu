package tv.hupu.view.chaoneng
{
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	
	/**
	 * 技能列表，多个SkillItem从上到下排列
	 * @author meiandai
	 * 
	 */	
	public class SkillList extends Sprite
	{
		protected var isRight:Boolean;	//显示在右侧
		protected var items:Vector.<SkillItem>;
		protected var _teamId:String;	//球队ID，一个球队对应一个SkillList
		
		public function SkillList(_isRight:Boolean = false)
		{
			isRight = _isRight;
			items = new Vector.<SkillItem>();
			super();
		}

		public function get teamId():String
		{
			return _teamId;
		}

		public function set teamId(value:String):void
		{
			_teamId = value;
		}
		
		/**
		 * 增加一个技能
		 * @param data
		 * 
		 */		
		public function addSkill(data:Object):void{
			var item:SkillItem = new SkillItem(data, isRight);
			item.y = (SkillItem.SPACING + SkillItem.LOGO_HEIGHT) * items.length;
			item.alpha = 0;
			TweenLite.to(item, 0.5, {alpha: 1});
			addChild(item);
			items.push(item);
		}
		
		/**
		 * 下线一个技能
		 * @param data
		 * 
		 */		
		public function removeSkill(skill_id:String):void{
			if(skill_id){
				var item:SkillItem;
				var hasFound:Boolean = false;	//已找到对应的技能
				var len:int = items.length;
				for(var i:int = 0; i < len; i++){
					item = items[i];
					if(hasFound){	//如果已经找到，后面的图标顺势往上移
						TweenLite.killTweensOf(item);
						TweenLite.to(item, .5, {y: i*(SkillItem.SPACING + SkillItem.LOGO_HEIGHT)});
					}else if(item.skillId == skill_id){
//						trace(contains(item));
						TweenLite.to(item, 0.3, {alpha: 0, onComplete: function(_pnt:DisplayObjectContainer, _item:SkillItem){
							if(_pnt.contains(_item)){
								_pnt.removeChild(_item);
							}
						}, onCompleteParams: [this, item]});
						hasFound = true;
						item.destroy();
						items.splice(i, 1);
						len--;
						i--;
					}
					
				}
			}
		}
	}
}