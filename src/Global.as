package  
{
	import flash.display.Stage;
	/**
	 * ...
	 * @author Kristaps
	 */
	public  class Global 
	{
		public static  var WIDTH:int=640;
		public static  var HEIGHT:int = 480;
		
		public static  var PL_SIDE = 768;
		
		public static var IS_GEN_NEW_LVL:Boolean = true;
		
		
		[Embed(source = "../res/gfx_brick.png")]
		public static var GFX_BRICK:Class;
		
		[Embed(source = "../res/gfx_doors.png")]
		public static var GFX_DOORS:Class;
		
		[Embed(source="../res/gfx_light.png")]
		public static var GFX_LIGHT:Class;
		
		[Embed(source = "../res/gfx_ghost.png")]
		public static var GFX_GHOST:Class;
		
		
		public static var m1:Array = [
			0, 0, 0, 5, 0, 0,
			0, 0, 0, 1, 0, 0,
			0, 0, 0, 8, 0, 0,
			0, 0, 0, 3, 0, 0,
			0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0,
		];
		
		public static var m2:Array = [
			0, 0, 0, 5, 0, 0,
			0, 0, 0, 1, 0, 0,
			0, 1, 8, 1, 1, 3,
			0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0,
		];
		
		public static var m3:Array = [
			0, 3, 0, 5, 0, 1,
			0, 1, 0, 1, 0, 8,
			0, 1, 0, 1, 0, 1,
			0, 1, 1, 1, 1, 1,
			0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0,
		];
		
		public static var m4:Array = [
			5, 0, 1, 0, 0, 3,
			1, 0, 1, 0, 0, 1,
			1, 1, 1, 1, 1, 1,
			0, 0, 1, 0, 0, 1,
			0, 0, 1, 0, 0, 1,
			8, 1, 1, 0, 0, 1,
		];
		
		public static var m_last:Array = [
			5
		];
		
		public static var LEVEL_ARRAYS:Array =
		[m1, m2, m3, m4, m_last];
		
		
		public static var THIS_MAP:Array;
		
		public static var FPS:int = 0;
		
		public static var LVL:int = 1;
		
		public static var hero
		
		public static var stage:Stage;
		
		public static var IS_CHANGING_LVL:Boolean = false;
		
		public static var delta:Number = 0;
		
		public static var IS_SOUND:Boolean = true;
		
		public static var ghostImgParse:ImageParser = new ImageParser(Global.GFX_GHOST, 60, 1);
		
		public static var imgPars:ImageParser = new ImageParser(Global.GFX_BRICK, 32, 0);
		
		[Embed(source = "../res/SFX_STEPS.mp3")]
		public static var SFX_STEPS:Class;
		
		[Embed(source = "../res/SFX_SCREAM.mp3")]
		public static var SFX_SCREAM:Class;
		
		[Embed(source = "../res/SFX_HOUNT.mp3")]
		public static var SFX_HOUNT:Class;
		
		[Embed(source = "../res/SFX_END.mp3")]
		public static var SFX_END:Class;
		
		[Embed(source = "../res/SFX_CLICK.mp3")]
		public static var SFX_CLICK:Class;
		
		[Embed(source = "../res/SFX_OVER.mp3")]
		public static var SFX_OVER:Class;
		
		[Embed(source = "../res/SFX_SPRAY.mp3")]
		public static var SFX_SPRAY:Class;
		
		[Embed(source = "../res/SFX_SPARK.mp3")]
		public static var SFX_SPARK:Class;
		
		public static var spacePressed:Boolean = false;
		
		public static var isGhost:Boolean = false;
		
		public static function randomRange(minNum:Number, maxNum:Number):Number
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
		public static var scaryWords:Array = [
			"DREAM",
			"DEATH",
			"DARK",
			"GHOST",
			"NIGHTMARE",
			"MAZE",
			"BLOOD",
			"BEHIND YOU!",
			"WHISPERS",
			"ETERNITY",
			"DON'T LOOK"
			
		];
		
		
	}

}