package  
{
	/**
	 * ...
	 * @author Kristaps
	 */
	import flash.display.Sprite;
	 
	public class Map 
	{
		private var oworld:MyWorld;
		
		private var mapArr:Array;
		
		private var hero:Hero;
		
		public function Map(oWorld:MyWorld) 
		{
			this.oworld = oWorld;
			this.hero = oWorld.getHero();
			
			
		}
		
		public function createWorld(lvl_ind:int):void
		{
			if (Global.IS_GEN_NEW_LVL == true)
			{
				var mg:MazeGen;
				if (Global.LVL > 30)
				{
					 mg= new MazeGen(32);
				}
				else
				{
					mg = new MazeGen(Global.LVL + 2);
				}
				
				mg.generateMaze();
				Global.THIS_MAP = mg.getMap();
				Global.IS_GEN_NEW_LVL = false;
			}
			mapArr = Global.THIS_MAP;
			build(mapArr);
		}
		
		private function put(elem:int,x:int,y:int,arr:Array):void
		{
			
			arr[y * Math.sqrt(arr.length) + x] = elem;
		}
		
		private function get(x:int,y:int,arr:Array):int
		{
			return arr[y*Math.sqrt(arr.length)+x];
		}
		
		private function build(arr:Array):void
		{
			var sideLength:int = Math.sqrt(arr.length);
			for (var y:int = 0; y < sideLength; y++ )
			{
				for (var x:int = 0; x < sideLength; x++ )
				{
					//trace(get(x, y, arr) );
					
					//Add
					if (get(x, y, arr) != 0)
					{
						//Griestu tails
						//oworld.add(new Plane(x * Global.PL_SIDE+Global.PL_SIDE / 2, -Global.PL_SIDE / 2, y * Global.PL_SIDE+Global.PL_SIDE / 2, Global.PL_SIDE, Global.PL_SIDE, 90, 0, oworld,x,y,"ROOF"));
						
						//Gridas tails
						//oworld.add(new Plane(x * Global.PL_SIDE+Global.PL_SIDE / 2, Global.PL_SIDE / 2, y * Global.PL_SIDE+Global.PL_SIDE / 2, Global.PL_SIDE, Global.PL_SIDE, 90, 0, oworld,x,y,"FLOOR"));
						
						//Pa kreisi siena
						if (leftIs(x, y, arr) == false)
						oworld.add(new Plane(x * Global.PL_SIDE, 0, y * Global.PL_SIDE+Global.PL_SIDE / 2, Global.PL_SIDE, Global.PL_SIDE, 0, 90, oworld,x,y,"L"));
						
						//Pa labi siena
						if (rightIs(x, y, arr) == false)
						oworld.add(new Plane(x * Global.PL_SIDE+Global.PL_SIDE, 0, y * Global.PL_SIDE+Global.PL_SIDE / 2, Global.PL_SIDE, Global.PL_SIDE, 0, 90, oworld,x,y,"R"));
						
						//Uz augsu
						if (upIs(x, y, arr) == false)
						oworld.add(new Plane(x * Global.PL_SIDE+Global.PL_SIDE / 2, 0, y * Global.PL_SIDE, Global.PL_SIDE, Global.PL_SIDE, 0, 0, oworld,x,y,"U"));
						
						//Uz leju
						if (downIs(x, y, arr) == false)
						oworld.add(new Plane(x * Global.PL_SIDE+Global.PL_SIDE/2, 0, y * Global.PL_SIDE+Global.PL_SIDE, Global.PL_SIDE, Global.PL_SIDE, 0, 0, oworld,x,y,"D"));
						
						if (get(x, y, arr) == 8)
						{
							//Ieliek Spoku
							oworld.add(new Ghost(x*Global.PL_SIDE+Global.PL_SIDE/2, y*Global.PL_SIDE+Global.PL_SIDE/2,oworld,x,y));
						}
						if (get(x, y, arr) == 3)
						{
							//Ieliek Izeju
							oworld.add(new Exit(x*Global.PL_SIDE+Global.PL_SIDE/2, y*Global.PL_SIDE+Global.PL_SIDE/2,oworld,x,y));
						}
						if (get(x, y, arr) == 5)
						{
							//Uzliek varoni
							if (downIs(x, y, mapArr))
							hero.setHeroPlace(x, y, 0);
							if (upIs(x, y, mapArr))
							hero.setHeroPlace(x, y, 180);
							if (leftIs(x, y, mapArr))
							hero.setHeroPlace(x, y, 90);
							if (rightIs(x, y, mapArr))
							hero.setHeroPlace(x, y, 270);
						}
						
					}
					
				}
			}
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
		
		public function getMapArr():Array
		{
			return mapArr;
		}
		
	}

}