package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Matrix3D;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.system.System;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Kristaps
	 */
	public class Hero 
	{
		private var world:Sprite;
		public var x:int=0;
		public var z:int = 0;
		public var y:int = 0; 
		private var view:Sprite;
		
		private var text_1:TextField;
		private var text_2:TextField;
		private var text_3:TextField;
		private var text_4:TextField;
		private var text_5:TextField;
		private var text_6:TextField;
		
		private var text_lvl:TextField;
		
		private var x_kvadr:int = -1;
		private var z_kvadr:int = -1;
		private var oWorld:MyWorld;
		
		private var direction:String = "DOWN";
		
		private var eightPart:int = 0;
		
		private var lastAngle:int = 0;
		
		
		private var drawingBoard:Sprite;
		
		private var mArr:Array;
		private var canLookForColl:Boolean = false;
		
		private var last_X:int;
		private var last_Z:int;
		
		private var x_k_inKv:int = 0;
		private var z_k_inKv:int = 0;
		
		private var sideLength:int;
		
		private var heroRadius:int = 220;
		
		private var collWorks:Boolean = true;
		
		private var angle:int = 0;
		
		private var light:Bitmap;
		
		public var canMove:Boolean = true;
		
		private var text_big_lvl:TextField;
		
		public var isDead:Boolean = false;
		
		private var deadTimer:Number = 0;
		
		private var howLongDead:Number = 1;
		
		private var img:Bitmap;
		
		public var canGoNextLVL:Boolean = false;
		
		private var nextTimer:Number = 0;
		private var howLongNext:Number = 1;
		
		private var endPlane:Shape;
		private var darkPlane:Shape;
		
		private var text_button_sound:TextField;
		private var button_sound:Sprite;
		
		private var stepSound:Soundy;
		private var sparkSound:Soundy;
		private var screamSound:Soundy;
		private var buttonSound:Soundy;
		
		private var endSound:Soundy;
		
		private var overSound:Soundy;
		private var spraySound:Soundy;
		
		private var start_x:int;
		private var start_z:int;
		private var start_angle:int;
		
		private var fourPart:int = 0;
		
		private var flashTime:Number = 0;
		
		private var flashAfterTime:Number = 3;
		
		public var shake_x:int = 0;
		public var shake_y:int = 0;
		
		
		public function Hero(oWorld:MyWorld) 
		{
			world = oWorld.getWorld();
			view = oWorld.getView();
			
			this.oWorld = oWorld;
			
			
			
			
			stepSound = new Soundy(Global.SFX_STEPS, 0.2);
			screamSound = new Soundy(Global.SFX_SCREAM, 0.6);
			endSound = new Soundy(Global.SFX_END, 0.3);
			buttonSound = new Soundy(Global.SFX_CLICK, 0.5);
			overSound = new Soundy(Global.SFX_OVER, 0.5);
			spraySound = new Soundy(Global.SFX_SPRAY, 0.3);
			sparkSound = new Soundy(Global.SFX_SPARK, 0.07);
			
			drawAll();
		}
		
		public function setMapArr(arr:Array):void
		{
			mArr = arr;
			sideLength = Math.sqrt(arr.length);
			
			canLookForColl = true;
			
		}
		
		
		
		public function setHeroPlace(x_k:int, z_k:int, angle:Number):void
		{
			text_lvl.text = "LVL - " +Global.LVL;
			text_big_lvl.text = "LEVEL - " + Global.LVL;
			text_big_lvl.alpha = 1;
			text_lvl.alpha = 0;
			
			x = x_k * Global.PL_SIDE + Global.PL_SIDE/2;
			z = z_k * Global.PL_SIDE + Global.PL_SIDE / 2;
			
			world.rotationY = angle;
			
			lastAngle = angle;
			
			start_x = x_k;
			start_z = z_k;
			start_angle = angle;
		}
		
		
		private function drawAll():void
		{
			//Dark Plane
			darkPlane = new Shape();
			darkPlane.graphics.beginFill(0x000000);
			darkPlane.graphics.drawRect( -Global.WIDTH / 2, -Global.HEIGHT / 2, Global.WIDTH, Global.HEIGHT);
			darkPlane.alpha = 0;
			view.addChild(darkPlane);
			
			
			//SOUND BUTTON
			var buttonFormat_sound:TextFormat = new TextFormat();
			buttonFormat_sound.size = 50;
			buttonFormat_sound.bold;
			buttonFormat_sound.color = 0xDEFF00;
			
			//GHOST
			img = new Bitmap(Global.ghostImgParse.getBD());
			img.x = - 350;
			img.y = - 340;
			img.width = 700;
			img.height = 800;
			
			view.addChild(img);
			img.visible = false;
			
			//Light
			light = new Global.GFX_LIGHT();
			light.x = -Global.WIDTH / 2;
			light.y = -Global.HEIGHT / 2;
			light.width = Global.WIDTH;
			light.height = Global.HEIGHT;
			
			view.addChild(light);
			
			//Text
			var myFormat:TextFormat = new TextFormat();
			myFormat.size = 15;
			myFormat.color = 0xDFDFDF;
			
			text_1 = new TextField();
			text_1.x = Global.WIDTH * 0.66 - Global.WIDTH / 2;
			text_1.y = Global.HEIGHT*0.01-Global.HEIGHT / 2;
			text_1.defaultTextFormat = myFormat;
			text_1.width = 400;
			text_1.text = "z:";
			text_1.selectable = false;
			view.addChild(text_1);	
			
			text_2 = new TextField();
			text_2.x = Global.WIDTH * 0.66 - Global.WIDTH / 2;
			text_2.y = Global.HEIGHT*0.04-Global.HEIGHT / 2;
			text_2.defaultTextFormat = myFormat;
			text_2.width = 400;
			text_2.text = "x:";
			text_2.selectable = false;
			view.addChild(text_2);	
			
			text_3 = new TextField();
			text_3.x = Global.WIDTH * 0.66 - Global.WIDTH / 2;
			text_3.y = Global.HEIGHT*0.07-Global.HEIGHT / 2;
			text_3.defaultTextFormat = myFormat;
			text_3.width = 400;
			text_3.text = "angle:";
			text_3.selectable = false;
			view.addChild(text_3);	
			
			text_4 = new TextField();
			text_4.x = Global.WIDTH * 0.66 - Global.WIDTH / 2;
			text_4.y = Global.HEIGHT*0.1-Global.HEIGHT / 2;
			text_4.defaultTextFormat = myFormat;
			text_4.width = 400;
			text_4.text = "kvadr:";
			text_4.selectable = false;
			view.addChild(text_4);	
			
			text_5 = new TextField();
			text_5.x = Global.WIDTH * 0.66 - Global.WIDTH / 2;
			text_5.y = Global.HEIGHT*0.13-Global.HEIGHT / 2;
			text_5.defaultTextFormat = myFormat;
			text_5.width = 400;
			text_5.text = "kvadr:";
			text_5.selectable = false;
			view.addChild(text_5);	
			
			text_6 = new TextField();
			text_6.x = Global.WIDTH * 0.66 - Global.WIDTH / 2;
			text_6.y = Global.HEIGHT*0.16-Global.HEIGHT / 2;
			text_6.defaultTextFormat = myFormat;
			text_6.width = 400;
			text_6.text = "MB:";
			text_6.selectable = false;
			view.addChild(text_6);	
			
			
			var format_lvl:TextFormat = new TextFormat();
			format_lvl.size = 15;
			format_lvl.bold;
			format_lvl.color = 0xDEFF00;
			
			text_lvl = new TextField();
			text_lvl.x = Global.WIDTH * 0.02 - Global.WIDTH / 2;
			text_lvl.y = Global.HEIGHT*0.02-Global.HEIGHT / 2;
			text_lvl.defaultTextFormat = format_lvl;
			text_lvl.width = 400;
			text_lvl.text = "LVL - " +Global.LVL;
			text_lvl.selectable = false;
			view.addChild(text_lvl);
			
			var bigFormat:TextFormat = new TextFormat();
			bigFormat.size = 40;
			bigFormat.bold;
			bigFormat.color = 0xDEFF00;
			
			text_big_lvl = new TextField();
			text_big_lvl.x = Global.WIDTH * 0.4 - Global.WIDTH / 2;
			text_big_lvl.y = Global.HEIGHT*0.45-Global.HEIGHT / 2;
			text_big_lvl.defaultTextFormat = bigFormat;
			text_big_lvl.width = 400;
			text_big_lvl.text = "LEVEL - " +Global.LVL;
			text_big_lvl.selectable = false;
			view.addChild(text_big_lvl);
			
			
			
			
			text_button_sound = new TextField();
			text_button_sound.defaultTextFormat = buttonFormat_sound;
			text_button_sound.width = 240;
			text_button_sound.x = -120;
			text_button_sound.y = -20;
			text_button_sound.selectable = false;
			if (Global.IS_SOUND == true)
			{
				text_button_sound.text = "SOUND ON";
			}
			else
			{
				text_button_sound.text = "SOUND OFF";
			}
			
			
			button_sound = new Sprite();
			button_sound.x = -Global.WIDTH / 2 + Global.WIDTH * 0.9;
			button_sound.y = -Global.HEIGHT/2 +Global.HEIGHT*0.03;
			button_sound.addChild(text_button_sound);
			
			view.addChild(button_sound);
			
			button_sound.width = 90;
			button_sound.height = 30;
			
			
			
			button_sound.addEventListener(MouseEvent.CLICK, mouseClicked_sound);
			button_sound.addEventListener(MouseEvent.MOUSE_OVER, mouseOver_sound);
			button_sound.addEventListener(MouseEvent.MOUSE_OUT, mouseOut_sound);
			
			
			//End Plane
			endPlane = new Shape();
			endPlane.graphics.beginFill(0xFF0000);
			endPlane.graphics.drawRect( -Global.WIDTH / 2, -Global.HEIGHT / 2, Global.WIDTH, Global.HEIGHT);
			endPlane.alpha = 0;
			view.addChild(endPlane);
			
			
			
			
			
			setConsTextNotVis();
		}
		
		private function updateFlash():void
		{
			flashTime+= Global.delta;
			
			if (flashTime > flashAfterTime )
			{
				if (isDead == false)
				{
					flashTime = 0;
					
					
					if (darkPlane.alpha == 0)
					{
						flashAfterTime = 0.2;
						darkPlane.alpha = Math.random();
						sparkSound.play();
					}
					else
					{
						darkPlane.alpha = 0;
						flashAfterTime = Math.random() * 10;
					}
				}
				else
				{
					flashTime = 0;
					flashAfterTime = Math.random() * 5;
				}
				
				
			}
		}
		
		private function mouseClicked_sound(e:Event):void
		{
			if (Global.IS_SOUND == true)
			{
				Global.IS_SOUND = false;
				text_button_sound.text = "SOUND OFF";
				buttonSound.play();
			} 
			else
			{
				Global.IS_SOUND = true;
				text_button_sound.text = "SOUND ON";
				buttonSound.play();
			}
			world.stage.focus = world.stage;
		}
		
		private function mouseOver_sound(e:Event):void
		{
			if (text_button_sound.scaleX == 1 ) overSound.play();
			text_button_sound.scaleX = 1.2;
			text_button_sound.scaleY=1.2;
		}
		
		private function mouseOut_sound(e:Event):void
		{
			text_button_sound.scaleX = 1;
			text_button_sound.scaleY= 1;
		}
		
		public function collision():void
		{
			if (canLookForColl == true && collWorks==true)
			{
				x_k_inKv = x % Global.PL_SIDE;
				z_k_inKv = z % Global.PL_SIDE;
				
				
				var d_z:int = z - last_Z;
				var d_x:int = x - last_X; 
				
				//Citadaks collision
				
				if (d_x!=0 || d_z !=0)
				{
					
					//Uzlabots collision
					//Booleanu noteiksana
					var collUp:Boolean = false;
					var collDown:Boolean = false;
					var collLeft:Boolean = false;
					var collRight:Boolean = false;
					
					var collUL:Boolean = false;
					var collUR:Boolean = false;
					var collDL:Boolean = false;
					var collDR:Boolean = false;
					
					var pl_side:int = Global.PL_SIDE;
					
					//DOWN
					if (z_k_inKv + heroRadius > pl_side && !hereIs(x_kvadr,z_kvadr+1,mArr)) 
					{
						//trace("WALL DOWN");
						collDown = true;
					}
					//UP
					if (z_k_inKv - heroRadius < 0 && !hereIs(x_kvadr,z_kvadr-1,mArr)) 
					{
						//trace("WALL UP");
						collUp = true;
					}
					//RIGHT
					if (x_k_inKv + heroRadius > pl_side && !hereIs(x_kvadr + 1, z_kvadr, mArr))
					{
						//trace("WALL RIGHT");
						collRight = true;
					}
					//LEFT
					if (x_k_inKv - heroRadius < 0 && !hereIs(x_kvadr - 1, z_kvadr, mArr))
					{
						//trace("WALL LEFT");
						collLeft = true;
					}
					
					//Ja atrodas krustojuma
					if ((downIs(x_kvadr, z_kvadr, mArr) && rightIs(x_kvadr, z_kvadr, mArr)))
					{
						//DOWN RIGHT
						if (z_k_inKv + heroRadius > pl_side && x_k_inKv + heroRadius > pl_side &&  !hereIs(x_kvadr + 1, z_kvadr + 1, mArr) )
						{
							//trace("WALL DOWN RIGHT");
							collDR = true;
						}
					}
					if ((downIs(x_kvadr, z_kvadr, mArr) && leftIs(x_kvadr, z_kvadr, mArr)))
					{
						//DOWN LEFT
						if (z_k_inKv + heroRadius > pl_side && x_k_inKv - heroRadius < 0 &&  !hereIs(x_kvadr - 1, z_kvadr + 1, mArr))
						{
							//trace("WALL DOWN LEFT");
							collDL = true;
						}
					}
					if ((upIs(x_kvadr, z_kvadr, mArr) && rightIs(x_kvadr, z_kvadr, mArr)))
					{
						//UP RIGHT
						if (x_k_inKv + heroRadius > pl_side && z_k_inKv - heroRadius < 0 && !hereIs(x_kvadr + 1, z_kvadr -1, mArr) )
						{
							//trace("WALL UP RIGHT");
							collUR = true;
						}
					}
					if ((upIs(x_kvadr, z_kvadr, mArr) && leftIs(x_kvadr, z_kvadr, mArr)))
					{
						//UP LEFT
						if (x_k_inKv - heroRadius < 0 && z_k_inKv - heroRadius < 0 && !hereIs(x_kvadr - 1, z_kvadr-1, mArr) )
						{
							//trace("WALL UP LEFT");
							collUL = true;
						}
					}
					
					//Moving code
					//Going DOWN
					if (d_z > 0)
					{
						//trace("GOING DOWN!!!!!!!!!");
						if (collDown || collDL || collDR)
						{
							//trace("Colliding DOWN ->");
							z = (z_kvadr+1) * Global.PL_SIDE-heroRadius;
						}
					}
					//Going UP
					if (d_z < 0)
					{
						//trace("GOING UP!!!!!!!!!");
						if (collUp || collUL || collUR)
						{
							//trace("Colliding UP ->");
							z = z_kvadr * Global.PL_SIDE+heroRadius;
						}
					}
					//Going LEFT
					if (d_x < 0)
					{
						//trace("GOING LEFT!!!!!!!!!");
						if (collLeft || collUL || collDL)
						{
							//trace("Colliding LEFT ->");
							x = x_kvadr * Global.PL_SIDE+heroRadius;
						}
					}
					//Going RIGHT
					if (d_x > 0)
					{
						//trace("GOING RIGHT!!!!!!!!!");
						if (collRight || collUR || collDR)
						{
							//trace("Colliding RIGHT ->");
							x = (x_kvadr+1) * Global.PL_SIDE-heroRadius;
						}
					}

				}
				
				last_X = x;
				last_Z = z;
				
				//Velreiz kolizija
				
				
			}
			
			//Maina kameras x un z pec tam
		}
		
		public function update():void
		{
			//Kvadr
			x_kvadr = Math.floor((x - Global.PL_SIDE) / Global.PL_SIDE) + 1;
			z_kvadr = Math.floor((z - Global.PL_SIDE) / Global.PL_SIDE) + 1;
			
			
			if (text_big_lvl.alpha > 0) 
			{
				text_big_lvl.alpha -= 0.03;
			}
			else
			{
				text_lvl.alpha = 1;
			}

			
			//Virziens
			//Down
			angle = world.rotationY % 360;
			eightPart = (angle) / 15;
			fourPart = (angle) / 45;
			
			
			updateDirection();
			
			//Text
			text_1.text = "x: " + x + " z: "+ z;
			text_2.text = "x_kv: " + x_k_inKv + " z_kv: "+z_k_inKv;
			text_3.text = "["+ direction +"] ["+eightPart+"]" + angle ;
			text_4.text = "[" + x_kvadr + "] [" + z_kvadr + "]";
			text_5.text = "FPS: " + Global.FPS;
			
			
			showMemory();
			
			
			collision();
			
			die();
			goNext();
			
			updateFlash();
			
			updShake();
		}
		
		private function updateDirection():void
		{
			if (angle <45 || angle > 315)
			{
				direction = "D";
			}
			else if (angle > 135 && angle < 225)
			{
				direction = "U";
			}
			else if (angle >= 225 && angle <= 315)
			{
				direction = "R";
			}
			else if (angle >= 45 && angle <= 135)
			{
				direction = "L";
			}
		}
		
		public function getZK():int
		{
			return z_kvadr;
		}
		
		public function getXK():int
		{
			return x_kvadr;
		}
		
		public function getDir():String
		{
			return direction;
		}
		public function getEightPart():int
		{
			return eightPart;
		}
		
		public function getFourPart():int
		{
			return fourPart;
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
		
		public function getAngle():int
		{
			return angle;
		}
		
		private function showMemory():void
		{
			var mem:String = Number( System.totalMemory / 1024 / 1024 ).toFixed( 2 ) + "MB";

			text_6.text = "MEMORY: " + mem;
		}
		
		public function move(dx:int,dz:int):void
		{
			if (canMove == true)
			{
				z -= dz;
				x -= dx;
				
				//Pagaja
				if (last_X != x || last_Z != z || lastAngle != angle)
				{
					stepSound.play();
				}
				else
				{
					stepSound.stop();
				}
				
				lastAngle = angle;
			}
		}
		
		private function setConsTextNotVis():void
		{
			text_1.visible = false;
			text_2.visible = false;
			text_3.visible = false;
			text_4.visible = false;
			text_5.visible = false;
			text_6.visible = false;
		}
		
		private function die ():void
		{
			if (isDead == true)
			{
				//Nomira
				if (canMove == true)
				{
					darkPlane.alpha = 1;
					img.visible = true;
				}
				canMove = false;
				
				screamSound.play();
				
				deadTimer += Global.delta;
				
				endPlane.alpha =Math.random()/2;
				
				if (deadTimer > howLongDead)
				{
					Global.isGhost = false;
					endPlane.alpha = 0;
					img.visible = false;
					canMove = true;
					isDead = false;
					deadTimer = 0;
					darkPlane.alpha = 0;
					//Global.IS_CHANGING_LVL = true;
					setHeroPlace(start_x, start_z, start_angle);
				}
				
			}
		}
		
		private function goNext():void
		{
			if (canGoNextLVL == true)
			{
				nextTimer += Global.delta;
				canMove = false;
				
				if (endPlane.alpha < 1)
				endPlane.alpha += 0.03;
				
				endSound.play();
				
				if (nextTimer > howLongNext)
				{
					canMove = true;
					canGoNextLVL = false;
					nextTimer = 0;
					endPlane.alpha = 0;
					
					Global.imgPars.randomizeFrame(0);
					Global.ghostImgParse.randomizeFrame(1);
					
					Global.IS_CHANGING_LVL = true;
					Global.LVL ++;
					Global.IS_GEN_NEW_LVL = true;
					
					x_kvadr = -50;
					z_kvadr = -50;
				}
			}
		}
		
		public function spray():void
		{
			spraySound.play();
		}
		
		private function updShake():void
		{
			
			if (Global.isGhost == true)
			{
				shake_x = Math.random() * 20 - 10;
				shake_y = Math.random() * 20 - 10;
			}
			else
			{
				shake_x = 0;
				shake_y = 0;
			}
			
			//view.x = view.x +shake_x;
			//view.y = view.y +shake_y;
		}
	}

}