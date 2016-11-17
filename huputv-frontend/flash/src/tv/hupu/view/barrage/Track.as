package tv.hupu.view.barrage
{
	import flash.display.Sprite;
	
	import tv.hupu.conf.BarrageConfig;
	import tv.hupu.events.BarrageBulletEvent;
	
	/**
	 * 轨道
	 * @author meiandai
	 * 
	 */	
	public class Track extends Sprite
	{
		protected var _on:Boolean = true;
		protected var _speed:Number;
		protected var _bullets:Vector.<Bullet>;
		
		public function Track()
		{
			_bullets = new Vector.<Bullet>();
			_speed = BarrageConfig.BULLET_MIN_SPEED + Math.random()*(BarrageConfig.BULLET_MAX_SPEED - BarrageConfig.BULLET_MIN_SPEED);
		}
		
		/**
		 * 当前轨道的弹幕全部走完的时间
		 * @return 
		 * 
		 */		
		public function get trackframes():int
		{
			return _bullets.length ? _bullets[_bullets.length - 1].frames : -1;
		}
		
		/**
		 * 当前轨道最后个弹幕的位置
		 * @return 
		 * 
		 */		
		public function get rightPos():Number
		{
			return _bullets.length ? _bullets[_bullets.length - 1].x + _bullets[_bullets.length - 1].width : 0;
		}

		public function set on(value:Boolean):void
		{
			_on = value;
			for(var i:int = 0, ilen:int = _bullets.length; i<ilen; i++){
				var blt:Bullet = _bullets[i];
				blt.on = value;
			}
		}
		
		public function get available():Boolean{
			return _bullets.length ? _bullets[_bullets.length - 1].canInsertSibling : true;
		}

		/**
		 * 添加一个弹幕元素
		 * @param blt
		 * 
		 */		
		public function addBullet(content:String, fromSelf:Boolean = false):void{
			var data:Object = {"content": content, "self":fromSelf, "speed": _speed};
			if(fromSelf || available){
				var blt:Bullet = new Bullet();
				addChild(blt);
				blt.setData(data);
				blt.addEventListener(BarrageBulletEvent.JOB_DONE, bulletDone);
				
				if(fromSelf && _bullets.length){
					blt.x = Math.max(blt.x, _bullets[_bullets.length - 1].x + _bullets[_bullets.length - 1].width + Bullet.OFFSET);
				}
				_bullets.push(blt);
			}
		}
		
		/**
		 * 
		 * @param evt
		 * 
		 */		
		protected function bulletDone(evt:BarrageBulletEvent):void{
			_bullets.shift();
		}
	}
}