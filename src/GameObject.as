package  
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Kristaps
	 */
	public class GameObject 
	{
		protected var depth:Number = 0;
		protected var t:Sprite;
		protected var hero:Hero;
		protected var world:Sprite;
		protected var view:Sprite;
		
		protected var x_offset:int;
		protected var z_offset:int;
		
		protected var x_ind:int;
		protected var z_ind:int;
		
		protected var isDrawing:Boolean = true;
		
		protected var visKvadr:int = 10;
		
		protected var isLight:Boolean = true;
		
		public function GameObject() 
		{
			
		}
		
		public function update():void
		{
			
		}
		
		public function getSprite():Sprite
		{
			return null;
		}
		
		public function ligthingUpdate():void
		{
			
		}
		
		public function getDepth():int
		{
			return 0;
		}
		
		public function getIsDrawing():Boolean
		{
			return true;
		}
		
		public function updVisibility():void
		{
			
		}
		
		public function updDepth():void
		{
			
		}
		
		protected function DistanceTwoPoints(x1:Number, y1:Number,  x2:Number, y2:Number):Number
		{
			var dx:Number = x1-x2;
			var dy:Number = y1-y2;
			return Math.sqrt(dx * dx + dy * dy);
		}
		
	}

}