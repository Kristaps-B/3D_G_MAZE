package 
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.Stage; 
	import flash.display.StageAlign; 
	import flash.display.StageScaleMode; 
	
	/**
	 * ...
	 * @author Kristaps
	 */
	[Frame(factoryClass = "Preloader")]
	[SWF(width = "640", height = "480", backgroundColor = "#000000", frameRate = "60")]
	
	 
	public class Main extends MovieClip
	{
		
		public function Main():void 
		{
			//if (stage) init();
			//else addEventListener(Event.ADDED_TO_STAGE, init);
			
			Global.stage.scaleMode = StageScaleMode.NO_BORDER;
			
			var m:Menu = new Menu(this);
			
		}
		
		private function init(e:Event = null):void 
		{
			//removeEventListener(Event.ADDED_TO_STAGE, init);
			
			
			
			
			
		}
		
	}
	
}