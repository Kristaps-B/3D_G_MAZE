package  
{
	/**
	 * ...
	 * @author Kristaps
	 */
	public class MazeGen 
	{
		private var maze:Array;
		private var mazeSide:int;
		private var mazeLength:int;
		
		private var x_start:int = 0;
		private var y_start:int = 0;
		
		private var x_this:int = 0;
		private var y_this:int = 0;
		
		private var kvadrAdded:int = 0;
		
		private var itsEnd:Boolean = false;
		
		private var isEndingAdded:Boolean = false;
		
		public function MazeGen(side:int) 
		{
			mazeSide = side;
			mazeLength = side * side;
			maze = new Array(mazeLength);
			
			setAllZero();
			//writeAll();
		}
		
		private function setAllZero():void
		{
			for (var i:int = 0; i < mazeLength; i++ )
			{
				maze[i] = 0;
			}
		}
		
		private function writeAll():void
		{
			trace("=====================================");
			for (var i:int = 0; i < mazeSide; i++ )
			{
				var line:String = "";
				for (var j:int = 0; j < mazeSide; j++ )
				{
					line += get(j, i, maze) +"    ";
				}
				trace(line);
			}
			trace("=====================================");
		}
		
		
		private function leftIs(x:int, y:int, arr:Array):Boolean
		{
			var sideLength:int = Math.sqrt(arr.length);
			
			if (x == 0) return false;
			if (get(x - 1, y, arr) == 0) return false;
			
			return true;
		}
		
		private function rightIs(x:int, y:int, arr:Array):Boolean
		{
			var sideLength:int = Math.sqrt(arr.length);
			
			if (x == (sideLength-1)) return false;
			if (get(x + 1, y, arr) == 0) return false;
			
			return true;
		}
		
		private function upIs(x:int, y:int, arr:Array):Boolean
		{
			var sideLength:int = Math.sqrt(arr.length);
			
			if (y == 0) return false;
			if (get(x , y-1, arr) == 0) return false;
			
			return true;
		}
		
		private function downIs(x:int, y:int, arr:Array):Boolean
		{
			var sideLength:int = Math.sqrt(arr.length);
			
			if (y == sideLength-1) return false;
			if (get(x , y+1, arr) == 0) return false;
			
			return true;
		}
		
		private function hereIs(x:int, y:int, arr:Array):Boolean
		{
			var sideLength:int = Math.sqrt(arr.length);
			
			if (x<0 || x>=sideLength) return false;
			if (y<0 || y>=sideLength) return false;
			
			if (get(x, y, arr) == 0) return false;
			
			return true;
		}
		
		private function put(elem:int,x:int,y:int,arr:Array):void
		{
			var sideLength:int = Math.sqrt(arr.length);
			arr[y * sideLength + x] = elem;
		}
		
		private function get(x:int,y:int,arr:Array):int
		{
			var sideLength:int = Math.sqrt(arr.length);
			return arr[y*sideLength+x];
		}
		
		public function generateMaze():void
		{
			//Start generate maze
			setFirst();
			//writeAll();
			
			
			while (itsEnd == false)
			{
				chooseNext();
			}
			//writeAll();
			
			setEnd();
			
			//WRITE LEVEL
			//trace("LEVEL: " + Global.LVL);
			//writeAll();
		}
		
		private function chooseNext():void
		{
			if (
				canGoDown() == false &&
				canGoLeft() == false &&
				canGoRight() == false &&
				canGoUp() == false 
			)			
			{
				if (isEndingAdded == false)
				{
					put(1000000, x_this, y_this, maze);
					isEndingAdded = true;
				}
				
				//Go Back
				goBack();
				
			}
			else
			{
				//Choose next
				var izv:int = 0;
				
				izv = randomRange(1, 4);
				//trace("RAND: "+izv);
				
				if (canGoRight() == true && izv ==1)
				{
					
					goRight();
				}
				if (canGoLeft() == true && izv ==2)
				{
					goLeft();
				}
				if (canGoUp() == true && izv ==3)
				{
					
					goUp();
				}
				if (canGoDown() == true && izv ==4)
				{
					goDown();
				}
			}
			
			
		}
		
		private function goBack():void
		{
			
			var this_elem:int = get(x_this, y_this, maze);
			//Go down
			if (y_this < mazeSide -1  && get(x_this, y_this + 1,maze) < this_elem && get(x_this, y_this +1,maze) > 0 )
			{
				y_this ++;
				//trace("DOWN");
			}
			
			//Go up
			else if ( y_this > 0 && get(x_this, y_this - 1,maze) < this_elem && get(x_this, y_this -1, maze) > 0)
			{
				y_this --;
				//trace("UP");
			}
			
			//Go right
			else if (x_this < mazeSide-1  && get(x_this +1, y_this ,maze) < this_elem && get(x_this +1, y_this , maze) > 0 )
			{
				x_this ++;
				//trace("RIGHT");
			}
			
			//Go left
			else if (x_this > 0 && get(x_this -1, y_this ,maze) < this_elem && get(x_this -1, y_this , maze) > 0 )
			{
				x_this --;
				//trace("LEFT");
			}
			
			//trace("BACK AT: " + this_elem);
			if (get(x_this, y_this, maze) == 1)
			{
				//trace("<1>");
				itsEnd = true;
			}
			
			
		}
		
		private function canGoRight():Boolean
		{
			var x_there_go:int = x_this +1;
			var y_there_go:int = y_this;
			if (
				!hereIs(x_there_go, y_there_go, maze) &&
				!upIs(x_there_go, y_there_go, maze) && 
				!rightIs(x_there_go, y_there_go, maze) && 
				!downIs(x_there_go, y_there_go, maze) &&
				x_there_go < mazeSide 
			)
			return true;
			
			return false;
		}
		
		private function canGoLeft():Boolean
		{
			var x_there_go:int = x_this - 1;
			var y_there_go:int = y_this;
			
			if (
				!hereIs(x_there_go, y_there_go, maze) &&
				!upIs(x_there_go, y_there_go, maze) && 
				!leftIs(x_there_go, y_there_go, maze) && 
				!downIs(x_there_go, y_there_go, maze) &&
				x_there_go >= 0 
			)
			{
				
				return true;
			}
			
			return false;
		}
		
		private function canGoUp():Boolean
		{
			var x_there_go:int = x_this ;
			var y_there_go:int = y_this -1;
			if (
				!hereIs(x_there_go, y_there_go, maze) &&
				!upIs(x_there_go, y_there_go, maze) && 
				!rightIs(x_there_go, y_there_go, maze) && 
				!leftIs(x_there_go, y_there_go, maze) &&
				y_there_go >= 0 
			)
			return true;
			
			return false;
		}
		
		private function canGoDown():Boolean
		{
			var x_there_go:int = x_this;
			var y_there_go:int = y_this + 1;
			
			if (
				!hereIs(x_there_go, y_there_go, maze) &&
				!leftIs(x_there_go, y_there_go, maze) && 
				!rightIs(x_there_go, y_there_go, maze) && 
				!downIs(x_there_go, y_there_go, maze) &&
				y_there_go < mazeSide 
			)
			return true;
			
			return false;
		}
		
		private function goRight():void
		{
			kvadrAdded ++;
			x_this = x_this + 1;
			put(kvadrAdded, x_this, y_this, maze);
		}
		
		private function goLeft():void
		{
			kvadrAdded ++;
			x_this = x_this - 1;
			put(kvadrAdded, x_this, y_this, maze);
		}
		
		private function goDown():void
		{
			kvadrAdded ++;
			y_this = y_this + 1;
			put(kvadrAdded, x_this, y_this, maze);
		}
		
		private function goUp():void
		{
			kvadrAdded ++;
			y_this = y_this - 1;
			put(kvadrAdded, x_this, y_this, maze);
		}
		
		private function  setFirst():void
		{
			kvadrAdded ++;
			
			x_start = randomRange(0, mazeSide -1);
			y_start = randomRange(0, mazeSide - 1);
			
			x_this = x_start;
			y_this = y_start;
			
			put(kvadrAdded, x_start, y_start, maze);
			
		}
		
		private function setEnd():void
		{
			for (var i:int = 0; i < mazeSide; i++ )
			{	
				for (var j:int = 0; j < mazeSide; j++ )
				{
					if (get(j, i, maze) == 1) put(5, j, i, maze);
					else if (get(j, i, maze) == 1000000) put(3, j, i, maze);
					else if (get(j, i, maze) == 2) put(8, j, i, maze);
					else if (get(j, i, maze) != 0) put(1, j, i, maze);
				}
			}
			
			//writeAll();
		}
		
		private function randomRange(minNum:Number, maxNum:Number):Number
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
		public function getMap():Array
		{
			return maze;
		}
		
	}

}