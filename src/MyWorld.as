package  
{
	import flash.display.Shape;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Matrix;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	

	/**
	 * ...
	 * @author Kristaps
	 */
	public class MyWorld 
	{
		private var t1:Shape;
		private var view:Sprite;
		private var t2:Shape;
		private var xOffset:int = 0;
		private var yOffset:int = 0;
		private var zOffset:int = 0;
		private var speed:int = 740;
		private var delta:Number = 0;
		private var lastTime:Number = 0;
		private var d:Date = new Date();
		private var objects:Array = new Array();
		private var world:Sprite;
		
		public var keyWDown:Boolean = false;
		public var keySDown:Boolean = false;
		public var keyADown:Boolean = false;
		public var keyDDown:Boolean = false;
		public var keyQDown:Boolean = false;
		public var keyEDown:Boolean = false;
		public var keySpaceDown:Boolean = false;
		
		private var hero:Hero;
		
		private var map:Map;
		
		private var isZSorting:Boolean = true;
		
		private var zSortingTime:Number = 0;
		
		private var lastHeroXK:int = -1;
		private var lastHeroZK:int = -1;
		
		
		private var lastEightPart:int = 0;
		private var lastHeroDir:String = "D";
		
		private var sortingDelay:int = 1.1;
		
		private var rotSpeed:int = 4;
		
		private var fps_timer:Number = 0;
		private var fps_counter:int = 0;
		
		private var lastFourPart:int = 0;
	
		
		public function MyWorld(oWorld:Sprite)
		{
			
			
			world = new Sprite();
			oWorld.addChild(world);
			world.x = Global.WIDTH/2;
			world.y = Global.HEIGHT/2;
			world.z = 0;
			
			
			
			view = new Sprite();
			oWorld.addChild(view);
			view.x = Global.WIDTH/2;
			view.y = Global.HEIGHT/2;
			view.z = 0;
			
			
			
			oWorld.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			oWorld.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			oWorld.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
			hero = new Hero(this);
			map = new Map(this);
			
			
			createLevel(Global.LVL);
			
			
			
			lastTime = getTimer();
		}
		
		private function createLevel(lvl_ind:int):void
		{
			//if (Global.LVL >= Global.LEVEL_ARRAYS.length) return;
			
			map.createWorld(lvl_ind);
			hero.setMapArr(Global.THIS_MAP);
			
			//hero.setHeroPlace(0, 0, 0);
			
			//Sorting
			for (var i:int = 0; i < objects.length; i++ )
			{
				objects[i].update();
			}
			sortingZ();
		}
		
		
		private function destroyLevel():void
		{
			//Destroy Level
			
			//Izmet objektus no display lista
			var i:int;
			while (world.numChildren > 0) {
				world.removeChildAt(0);
			}
			
			//Izmet objektus no masiva
			for (i = 0; i < objects.length; i++ )
			{
				objects[i] = null;
			}
			
			objects = new Array();
		}
		
		private function selectionSort(input: Array):Array {
			//find the i'th element
			var l1:int=input.length
			for (var i:int = 0; i < l1; i++) {
				//set minIndex to an arbitrary value
				var minIndex:int=i;
				//find the smallest number
				for (var j:int = i; j < input.length; j++) {
					if (input[j].getDepth()<input[minIndex].getDepth()) {
						minIndex=j;
					}
				}
				//swap the smallest number into place
				var tmp:GameObject=input[i];
				input[i]=input[minIndex];
				input[minIndex]=tmp;
			}
			return input;
		}
		
		public function sortingZ():void
		{
			//trace("Pirms " + world.numChildren);
			var i:int;
			while (world.numChildren > 0) {
				world.removeChildAt(0);
			}
			
			//Izveido  masivu no redzamajiem objektiem
			var drawingObj:Array = new Array();
			for (i = 0; i < objects.length; i++ )
			{
				objects[i].updVisibility();
				objects[i].updDepth();
				if (objects[i].getIsDrawing() == true)
				{
					drawingObj.push(objects[i]);
				}
			}
			
			
			drawingObj = selectionSort(drawingObj);
			
			var l1:int = drawingObj.length;
			for (i = drawingObj.length-1; i >=0; i-- )
			{
				if (drawingObj[i].getIsDrawing() == true)
				{					
					world.addChild(drawingObj[i].getSprite());
					if (lastHeroXK != hero.getXK() || lastHeroZK != hero.getZK() || lastFourPart != hero.getFourPart())
					{
						drawingObj[i].ligthingUpdate();
						
					}
					
					
					
				}
			}
			
		}
		
		private function updFps():void
		{
			fps_timer+=delta;
			fps_counter++;
			if (fps_timer > 1)
			{
				fps_timer = 0
				Global.FPS = fps_counter;
				fps_counter = 0;
				//trace(Global.FPS);
			}
		}
		
		//UPDATE
		private function onEnterFrame(e:Event):void
		{	
			//TIME
			delta = (getTimer() - lastTime) / 1000;
			Global.delta = delta;
			lastTime = getTimer();
			updFps();
			
			
			var i:int = 0;
			//Sakuma updeito varoni
			hero.update();
			
			//Pec tam updeito pasauli
			for (i = 0; i < objects.length; i++ )
			{
				objects[i].update();
			}
			
			
			if (isZSorting == true)
			{
				//Sorting
		
				if (lastHeroXK!=hero.getXK() || lastHeroZK!=hero.getZK() || lastEightPart!= hero.getEightPart())
				{
					sortingZ();
					zSortingTime = 0;
				}
				lastHeroXK = hero.getXK();
				lastHeroZK = hero.getZK();
				lastEightPart = hero.getEightPart();
				lastHeroDir = hero.getDir();
				lastFourPart = hero.getFourPart();
			}
			
			//Vai jamaina raundu
			tryChangeLVL();
			
			
			keyBoardControl();
			
		}
		
		private function tryChangeLVL():void
		{
			if (Global.IS_CHANGING_LVL == true)
			{
				Global.IS_CHANGING_LVL = false
				//Parmaina raundu
				destroyLevel();
				//Palielina lvla skaitu
				//Global.LVL ++;
				//Create Level
				createLevel(Global.LVL);
			}
		}
		
		public function keyBoardControl():void
		{
			var d_z:Number = 0;
			var d_x:Number = 0;
			//Control
			if (keyDDown == true)
			{
				var rot:int = ((world.rotationY  % 360)) - rotSpeed;
				//trace(rot);
				if (hero.canMove == true)
				world.rotationY = 360 + rot;
			}
			if (keyADown == true)
			{
				if (hero.canMove == true)
				world.rotationY+=rotSpeed;
			}
			if (keyWDown == true)
			{
				d_z = -(speed * delta) * Math.cos((Math.PI / 180) * world.rotationY);
				d_x=(speed * delta) * Math.sin((Math.PI / 180) * world.rotationY);
			}
			if (keySDown == true)
			{
				d_z = (speed * delta) * Math.cos((Math.PI / 180) * world.rotationY);
				d_x=-(speed*delta)*Math.sin((Math.PI/180)*world.rotationY);
			}
			
			if (keySpaceDown == true)
			{
				Global.spacePressed = true;
			}
			else
			{
				Global.spacePressed = false;
			}
		
			
			hero.move(d_x, d_z);
		}
		
		
		public function add(p:GameObject):void
		{
			objects[objects.length] = p;
		}
		
		public function onKeyUp(e:KeyboardEvent):void
		{
			var key:uint = e.keyCode;
			switch (key)
			{
				case Keyboard.RIGHT:
				case Keyboard.D:
					keyDDown = false;
				break;
				
				case Keyboard.LEFT:
				case Keyboard.A:
					keyADown = false;
				break;
				
				case Keyboard.UP:
				case Keyboard.W:
					keyWDown = false;
				break;
				
				case Keyboard.DOWN:
				case Keyboard.S:
					keySDown = false;
				break;
				case Keyboard.SPACE:
					keySpaceDown = false;
				break;
				
				
			}
		}
		
		public function onKeyDown(e:KeyboardEvent):void
		{
			var key:uint = e.keyCode;
			
			switch (key)
			{
				case Keyboard.RIGHT:
				case Keyboard.D:
					keyDDown = true;
				break;
				
				case Keyboard.LEFT:
				case Keyboard.A:
					keyADown = true;
				break;
				
				case Keyboard.UP:
				case Keyboard.W:
					keyWDown = true;
				break;
				
				case Keyboard.DOWN:
				case Keyboard.S:
					keySDown = true;
				break;
				case Keyboard.SPACE:
					keySpaceDown = true;
				break;
				
				
			}
		}
		
		public function getView():Sprite
		{
			return view;
		}
		
		public function getWorld():Sprite
		{
			return world;
		}
		
		public function getHero():Hero
		{
			return hero;
		}
		
		public function getMap():Map
		{
			return map;
		}
		
		
	
		
	}

}