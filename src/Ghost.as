package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.Sprite;
	import flash.events.TextEvent;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Kristaps
	 */
	public class Ghost extends GameObject
	{
		private var movingDirection:String = "DOWN";
		private var isMoving:Boolean = false;
		private var movingEnabled:Boolean = true;
		
		private var d_x:int;
		private var d_z:int;
		
		private var speed:int = 1400;
		
		private var x:int;
		private var z:int;
		
		private var x_stop:int;
		private var z_stop:int;
		
		private var mArr:Array;
		
		private var sideLength:int;
		
		private var text:TextField;
		
		private var oworld:MyWorld;
		
		private var waitTime:int = 8;
		
		private var scareTimer:Number = 0;
		private var timeToNextScare:Number = waitTime;
		
		private var hountSound:Soundy;
		
		public function Ghost(x:int, z:int, world:MyWorld, x_i:int, z_i:int) 
		{
			t = new Sprite();
			this.world = world.getWorld();
			this.hero = world.getHero();
			
			oworld = world;
			
			hountSound = new Soundy(Global.SFX_HOUNT, 0.6);
			
			mArr = Global.THIS_MAP;
			sideLength = Math.sqrt(mArr.length );
			
			
	
			
			visKvadr = 5;
			
			t.y = 0;
			//t.rotationX = 30;
	
			
			
			
			
			var img:Bitmap = new Bitmap(Global.ghostImgParse.getBD());
		
			
			img.x = - 220;
			img.y = - 300;
			img.width = 440;
			img.height = 600;
			
			t.addChild(img);
			
		
			
			
			setIdle();
		}
		
		private function setIdle():void
		{
			setGhostCord( -3 * Global.PL_SIDE+Global.PL_SIDE, -3 * Global.PL_SIDE+Global.PL_SIDE );
			Global.isGhost = false;

			//isDrawing = false;
			t.visible = false;
			isMoving = false;
			//trace("POOF");
			
		}
		
		private function setGhost(x_kv:int, z_kv:int):void
		{
			setGhostCord(x_kv * Global.PL_SIDE+Global.PL_SIDE / 2, z_kv * Global.PL_SIDE+Global.PL_SIDE / 2);
			
			Global.isGhost = true;
			
			t.visible = true;
			//isDrawing = true;
			//trace("BOO");
		}
		
		
		
		private function tryToScare():void
		{
			if (t.visible == false)
			{
				scareTimer += Global.delta;
			
				if (scareTimer > timeToNextScare)
				{
					var h_dir:String = hero.getDir();
					var h_xk:int = hero.getXK();
					var h_zk:int = hero.getZK();
					
					
					
					var dist:int = 3;
					
					if (h_dir == "D" && hereIs(h_xk, h_zk + 1, mArr) && hereIs(h_xk, h_zk + 2, mArr) && hereIs(h_xk, h_zk + 3, mArr))
					{
						setGhost(h_xk, h_zk + dist);
						isMoving = true;
						movingDirection = "UP";
						
						
						hountSound.play();
					}
					if (h_dir == "U" && hereIs(h_xk, h_zk - 1, mArr) && hereIs(h_xk, h_zk - 2, mArr) && hereIs(h_xk, h_zk - 3, mArr))
					{
						setGhost(h_xk, h_zk - dist);
						isMoving = true;
						movingDirection = "DOWN";
						
						hountSound.play();
					}
					if (h_dir == "L" && hereIs(h_xk - 1, h_zk, mArr) && hereIs(h_xk - 2, h_zk, mArr) && hereIs(h_xk - 3, h_zk, mArr))
					{
						setGhost(h_xk - dist, h_zk );
						isMoving = true;
						movingDirection = "RIGHT";
						
						hountSound.play();
					}
					if (h_dir == "R" && hereIs(h_xk +1, h_zk, mArr) && hereIs(h_xk +2, h_zk, mArr) && hereIs(h_xk +3, h_zk, mArr))
					{
						setGhost(h_xk+dist, h_zk );
						isMoving = true;
						movingDirection = "LEFT";
						
						
						hountSound.play();
					}
					
					
					scareTimer = 0;
					timeToNextScare = Math.random() * waitTime+waitTime/2;
					
				}
			}
		}
		
		private function tryToHide():void
		{
			if (t.visible == true )
			{
				var h_dir:String = hero.getDir();
				if (movingDirection == "UP" && h_dir != "D") 
				{
					setIdle();
					hountSound.stop();
				}
				if (movingDirection == "DOWN" && h_dir != "U") 
				{
					setIdle();
					hountSound.stop();
				}
				if (movingDirection == "LEFT" && h_dir != "R") 
				{
					setIdle();
					hountSound.stop();
				}
				if (movingDirection == "RIGHT" && h_dir != "L") 
				{
					setIdle();
					hountSound.stop();
				}
				
				if (Global.isGhost == false)
				{
					setIdle();
					hountSound.stop();
				}
			}
		}
		
		private function setGhostCord(x_n:int, z_n:int):void
		{
			x_offset = x_n;
			z_offset = z_n;
			
			d_x = 0;
			d_z = 0;
		}
		
		public override function update():void
		{
			//Update
			{
				//updVisibility();
				//updDepth();
				
				t.x = x_offset - hero.x + d_x;
				t.z = z_offset - hero.z + d_z;
				
				x = t.x + hero.x;
				z = t.z + hero.z;
				
				
				
				t.rotationY = - hero.getAngle();
				
				//Update index
				x_ind = Math.floor(x / Global.PL_SIDE);
				z_ind = Math.floor(z / Global.PL_SIDE);
			}
			
		
			
			moving();
			
			//updateDepth();
			
			isOnGhost();
			
			tryToScare();
			
			tryToHide();
			
			//text.text = "" + depth;
		}
		
		private function isOnGhost():void
		{
			if (hero.getXK() == x_ind && hero.getZK() == z_ind)
			{
				
				hero.isDead = true;
			}
		}
		
		private function moving():void
		{
			if (movingEnabled == false || isMoving == false) return;
			
			if (movingDirection == "DOWN")
			{
				moveDown();
			}
			else if (movingDirection == "UP")
			{
				moveUp();
			}
			else if (movingDirection == "LEFT")
			{
				moveLeft();
			}
			else if (movingDirection == "RIGHT")
			{
				moveRight();
			}
			
			//Update index
			x_ind = Math.floor(x / Global.PL_SIDE);
			z_ind = Math.floor(z / Global.PL_SIDE);
			
		
			
		}
		
		private function moveLeft():void
		{
			d_x -= speed * Global.delta;
			
		
		}
		
		private function moveRight():void
		{
			d_x += speed * Global.delta;
			
		
		}
		
		private function moveDown():void
		{
			//MOVE DOWN
			d_z += speed * Global.delta;
			
			
		}
		
		private function moveUp():void
		{
			//MOVE DOWN
			d_z -= speed * Global.delta;
			
			
		}
		
		public override function getSprite():Sprite
		{
			return t;
		}
		
		public override function updDepth():void
		{
			//depth = Math.abs(t.transform.getRelativeMatrix3D(view).position.z);
			
			var x_k:int = x_ind * 10+5;
			var z_k:int = z_ind * 10+5;
			
			var h_x:int = hero.getXK()*10+5;
			var h_z:int = hero.getZK()*10+5;
			
			depth = Math.floor(DistanceTwoPoints(h_x, h_z, x_k, z_k));
			depth -= 1;
			//text.text = "D: " + depth;
			depth = 1;
		}
		
		public override function updVisibility():void
		{
			
			var x_k:int = x_ind * 10;
			var z_k:int = z_ind * 10;
			
			var h_kx:int = hero.getXK();
			var h_kz:int = hero.getZK();
			
			isDrawing = true;
			
			if (
				depth > 80
			)
			{
				isDrawing = false;
			}
			
		}
		
		public override function getDepth():int
		{
			return depth;
		}
		
		public override function getIsDrawing():Boolean
		{
			return isDrawing;
		}
		
		public override function ligthingUpdate():void
		{
			if (isLight == true )
			{
				//depth = Math.abs(t.transform.getRelativeMatrix3D(view).position.z);
				
				var ct:ColorTransform = new ColorTransform();
				
				var offset:Number = - 180 * ((depth / (visKvadr*10))) ;
				
				ct.blueOffset = offset;
				ct.greenOffset = offset;
				ct.redOffset=offset;
				t.transform.colorTransform = ct;
				
			}
		}
		
		private function leftIs(x:int, y:int, arr:Array):Boolean
		{
			//var sideLength:int = Math.sqrt(arr.length);
			
			if (x == 0) return false;
			if (get(x - 1, y, arr) == 0) return false;
			
			return true;
		}
		
		private function rightIs(x:int, y:int, arr:Array):Boolean
		{
			//var sideLength:int = Math.sqrt(arr.length);
			
			if (x == (sideLength-1)) return false;
			if (get(x + 1, y, arr) == 0) return false;
			
			return true;
		}
		
		private function upIs(x:int, y:int, arr:Array):Boolean
		{
			//var sideLength:int = Math.sqrt(arr.length);
			
			if (y == 0) return false;
			if (get(x , y-1, arr) == 0) return false;
			
			return true;
		}
		
		private function downIs(x:int, y:int, arr:Array):Boolean
		{
			//var sideLength:int = Math.sqrt(arr.length);
			
			if (y == sideLength-1) return false;
			if (get(x , y+1, arr) == 0) return false;
			
			return true;
		}
		
		private function hereIs(x:int, y:int, arr:Array):Boolean
		{
			//var sideLength:int = Math.sqrt(arr.length);
			
			if (x<0 || x>=sideLength) return false;
			if (y<0 || y>=sideLength) return false;
			
			if (get(x, y, arr) == 0) return false;
			
			return true;
		}
		
		private function put(elem:int,x:int,y:int,arr:Array):void
		{
			
			arr[y * sideLength + x] = elem;
		}
		
		private function get(x:int,y:int,arr:Array):int
		{
			return arr[y*sideLength+x];
		}
		
	
	}

}