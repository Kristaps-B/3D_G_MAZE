package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Kristaps
	 */
	public class ImageParser 
	{
		private var bm:Bitmap;
		private var bmData:BitmapData;
		
		private var bmFrame:BitmapData;
		
		private var side:int;
		
		private var thisFrame:int = 0;
		
		private var frameCount:int;
		
		public function ImageParser(source:Class, s:int, id:int) 
		{
			side = s;
			bm = new source();
			bmData = bm.bitmapData;
			frameCount = bmData.width / side;	
			bmFrame = new BitmapData(side, side,true, 0x00000000);
			
			
				
			randomizeFrame(id);
			
			
		}
		
		private function setFrame(frNumb:int, y:int):void
		{
			bmFrame.copyPixels(bmData, new Rectangle(side * frNumb, side * y, side, side), new Point(0, 0),null,null, true);
			
		}
		
		public function randomizeFrame(id:int):void
		{
			if (id == 0)
			{
				var frN:int = randomRange(0, frameCount - 1);
				//var frN:int = 8;
				setFrame(frN, 0);
			}
			else
			{
				createGhost();
			}
			
		}
		
		public function getBD():BitmapData
		{
			return bmFrame;
		}
		
		private function randomRange(minNum:Number, maxNum:Number):Number
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
		private function createGhost():void
		{
			bmFrame.fillRect(new Rectangle(0, 0, side, side), 0x00000000);
			createBody();
			createEyes();
			createMouth();
			createOther();
		}
		
		private function createBody():void
		{
			var frN:int = randomRange(0, frameCount - 1);
			setFrame(frN, 0);
		}
		
		private function createEyes():void
		{
			var frN:int = randomRange(0, frameCount - 1);
			setFrame(frN, 1);
		}
		
		private function createMouth():void
		{
			var frN:int = randomRange(0, frameCount - 1);
			setFrame(frN, 2);
		}
		
		private function createOther():void
		{
			var frN:int = randomRange(0, frameCount - 1);
			setFrame(frN, 3);
		}
		
	}

}