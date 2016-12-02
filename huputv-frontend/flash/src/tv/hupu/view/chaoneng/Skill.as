package tv.hupu.view.chaoneng
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import tv.hupu.events.JSInterfaceEvent;
	import tv.hupu.utils.JS2AS;
	
	/**
	 * 超能技能
	 * @author meiandai
	 * 
	 */	
	public class Skill extends Sprite
	{
		
		protected var leftList:SkillList;
		protected var rightList:SkillList;
		
		public function Skill()
		{
			if(this.stage){
				init();
			}else{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		
		/**
		 * 初始化
		 * 
		 */		
		protected function init(evt:Event = null):void{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			initUI();
			
			stage.addEventListener(Event.RESIZE, resetStage);
			JS2AS.getInstance().addEventListener(JSInterfaceEvent.RECEIVE_SKILL_STAT_ON, skillOn);
			JS2AS.getInstance().addEventListener(JSInterfaceEvent.RECEIVE_SKILL_STAT_OFF, skillOff);
		}
		
		/**
		 * 初始化界面
		 * 
		 */		
		protected function initUI():void{
			leftList = new SkillList();
			leftList.x = 20 + SkillItem.LOGO_WIDTH / 2;
			leftList.y = 80;
			addChild(leftList);
			
			rightList = new SkillList(true);
			rightList.x = stage.stageWidth - leftList.x;
			rightList.y = leftList.y;
			addChild(rightList);
		}
		
		/**
		 * 技能上线
		 * @param evt
		 * @return 
		 * 
		 */		
		protected function skillOn(evt:JSInterfaceEvent){
			var data:Object = evt.data;
			if(data && data.hasOwnProperty('isHomeTeam')){
				if(data['isHomeTeam']){
					leftList.addSkill(data);
				}else{
					rightList.addSkill(data);
				}
			}
		}
		
		/**
		 * 技能下线
		 * @param evt
		 * @return 
		 * 
		 */		
		protected function skillOff(evt:JSInterfaceEvent){
			var data:Object = evt.data;
			if(data && data.hasOwnProperty('isHomeTeam')){
				if(data['isHomeTeam']){
					leftList.removeSkill(data['skill_id']);
				}else{
					rightList.removeSkill(data['skill_id']);
				}
			}
		}
		
		/**
		 * 重置舞台元素
		 * @param evt
		 * 
		 */		
		protected function resetStage(evt:Event):void{
			if(stage && rightList){
				rightList.x = stage.stageWidth - leftList.x;
			}
		}
	}
}