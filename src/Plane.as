package  
{
	/**
	 * ...
	 * @author Kristaps
	 */
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.geom.Vector3D;
	import flash.display.Bitmap;
	
	public class Plane extends GameObject
	{
		
		private var text:TextField;
		
		private var w:int;
		private var h:int;
		
		protected var image:Bitmap;
		
		
		
		private var isAdvancedVisibility:Boolean = true;
		
		private var type:String = "N";
		
		private var oldVis:Boolean = true;
		private var oldDraw:Boolean = true;
		
		private var goingForward:Boolean = false;
		
		private var isInDisplList:Boolean = false;
		
		private var markText:TextField;
		
		private var hasMark:Boolean = false;
		
		private var startRemoveMark:Boolean = false;
		
		public var needsToUpdateLight:Boolean = false;
		
		
		private var without_shake_x:int = 0;
		private var without_shake_y:int = 0;
		
		private var shaked:Boolean = false;
		
		public function Plane(x:int,y:int,z:int,w:int,h:int,rX:int,rY:int,world:MyWorld,x_i:int,z_i:int,type:String) 
		{
			this.type = type;
			t = new Sprite();
			hero = world.getHero();
			this.world = world.getWorld();
			this.view = world.getView();
			t.y = y;
			
			this.w = w;
			this.h = h;
			
			x_ind = x_i;
			z_ind=z_i
			
			x_offset = x;
			z_offset = z;

			t.z = z;
			t.rotationX = rX;
			t.rotationY = rY;
			
			visKvadr = 3;
			
			
			
			
			var m:Matrix = new Matrix();
			m.scale(12, 12);
			t.graphics.beginBitmapFill(Global.imgPars.getBD(),m);
			//t.graphics.lineStyle(8, 0x000000);
			t.graphics.drawRect( -Global.PL_SIDE / 2, -Global.PL_SIDE / 2, w, h);
			
			
			/*
			var myFormat:TextFormat = new TextFormat();
			myFormat.size = 60;
			myFormat.color = 0xFFFFFF;
			
			
			text = new TextField();
			text.x = 0;
			text.y = 0;
			text.defaultTextFormat = myFormat;
			text.width = 400;
			text.text = "isDrawing:";
			text.selectable=false
			t.addChild(text);
			text.text = "" + depth;
			*/
			
			
		}
		
		private function addMark():void
		{
			var myFormat:TextFormat = new TextFormat();
			myFormat.size = 50;
			myFormat.color = 0xFF0000;
			myFormat.bold = true;
			myFormat.align = "center";
			
			
			markText = new TextField();
			markText.x = -250;
			markText.y = -70;
			markText.defaultTextFormat = myFormat;
			markText.width = 500;
			markText.height = 140;
			markText.text = Global.scaryWords[Global.randomRange(0, Global.scaryWords.length -1)];
			markText.selectable=false
			t.addChild(markText);
			markText.alpha = 0.01;
			
			
			if (type == "U" || type == "L") t.scaleX = -1;
			
			hasMark = true;
		}
		
		private function removeMark():void
		{
			t.removeChild(markText);
			markText = null;
			hasMark = false;
			
		}
		
		private function updateMark():void
		{
			if (isDrawing == true)
			{
				if (Global.spacePressed == true && hasMark == false && startRemoveMark == false )
				{
					var h_dir:String = hero.getDir();
					if (hero.getXK() == x_ind && hero.getZK() == z_ind)
					{
						//Add mark
						if (type  == h_dir)
						{
							addMark();
							hero.spray();
						}
					}
				}
				
				else if (Global.spacePressed == true && hasMark == true && startRemoveMark == false)
				{
					var h1_dir:String = hero.getDir();
					if (hero.getXK() == x_ind && hero.getZK() == z_ind && markText.alpha == 1)
					{
						//Add mark
						if (type  == h1_dir)
						{
							startRemoveMark = true;
							hero.spray();
							//trace("SAK");
						}
						//removeMark();
					}
				}
			}
			
			if (startRemoveMark == true)
			{
				//trace(markText.scaleX);
				if (markText.alpha> 0.01)
				{
					markText.alpha -= 0.06;
				}
				else
				{
					startRemoveMark = false;
					removeMark();
				}
			}
			
			if (hasMark == true && startRemoveMark == false)
			{
				if (markText.alpha < 1)
				{
					markText.alpha += 0.06;
				}
				if (markText.alpha > 1)
				{
					markText.alpha = 1;
				}
			}
		}
		
		public override function updDepth():void
		{
			
			var x_k:int = x_ind * 10;
			var z_k:int = z_ind * 10;
			
			var h_x:int = hero.getXK()*10 + 5;
			var h_z:int = hero.getZK() * 10 + 5;
			
			//trace("H_X "+ h_x +" H_Z " + h_z);
			
			if (type == "D")
			{
				z_k += 7;
				x_k += 5;
			}
			else if (type == "U") 
			{
				z_k += 3;
				x_k += 5;
			}
			else if (type == "R") 
			{
				x_k += 7;
				z_k += 5;
			}
			else if (type == "L") 
			{
				x_k += 3;
				z_k += 5;
			}
			
			
			depth = Math.round(DistanceTwoPoints(h_x, h_z, x_k, z_k));
			
		}
		
		public override function update():void
		{
			//updVisibility();
			//updDepth();
			if (t.visible == true)
			{
				t.visible = false;
			}
			
			
			if (isDrawing == true )
			{
				
				t.x = x_offset - hero.x +hero.shake_x;
				t.z = z_offset - hero.z;
				t.y = t.y + hero.shake_y;
				
				
				
				if (hero.shake_x != 0 || hero.shake_y != 0)
				{
					shaked = true;
					without_shake_x = x_offset - hero.x;
				}
				if (shaked == true && hero.shake_x == 0 && hero.shake_y == 0)
				{
					shaked = false;
					t.x = without_shake_x;
					t.y = 0;
				}
				
				
				
				
				updAdvVis();
				updateMark();
				
				if (t.visible == false)
				{
					t.visible = true;
				}
			}
			

			
		}
		
		private function dontDrawBack():void
		{
			//Lai cauri sienai nespidetu
			var h_a:int = hero.getAngle();
			//Augseja siena
			if (type == "U")
			{
				if ( h_a >= 300 || h_a <= 60)
				{
					isDrawing = false;
					//trace("NOTIEK!!!");
				}
			}
			if (type == "D")
			{
				if ( h_a >= 120 && h_a <= 240)
				{
					isDrawing = false;
					//trace("NOTIEK!!!");
				}
			}
			if (type == "L")
			{
				if ( h_a >= 210 && h_a <= 331)
				{
					isDrawing = false;
					//trace("NOTIEK!!!");
				}
			}
			if (type == "R")
			{
				if ( h_a >= 30 && h_a <= 150)
				{
					isDrawing = false;
					//trace("NOTIEK!!!");
				}
			}
		}
		
		public override function updVisibility():void
		{
			isDrawing = true;
			dontDrawBack();
					
			var h_d:String = hero.getDir();
			//Attalums
			if (h_d == "D")
			{
				if (
				x_ind > hero.getXK()+1  ||
				x_ind < hero.getXK() -1 ||
				z_ind > hero.getZK() + visKvadr ||
				z_ind < hero.getZK() -1
				)
				{
					isDrawing = false;
				}
				
			}
			else if (h_d== "U")
			{
				if (
				x_ind > hero.getXK() +1 ||
				x_ind < hero.getXK() -1 ||
				z_ind > hero.getZK() +1 ||
				z_ind < hero.getZK() - visKvadr
				)
				{
					isDrawing = false;
				}
				
			}
			else if (h_d == "R")
			{
				if (
				x_ind > hero.getXK() +visKvadr ||
				x_ind < hero.getXK()-1||
				z_ind > hero.getZK()+1 ||
				z_ind < hero.getZK() -1
				)
				{
					isDrawing = false;
				}
				
			}
			else if (h_d == "L")
			{
				if (
				x_ind > hero.getXK() ||
				x_ind < hero.getXK()-visKvadr ||
				z_ind > hero.getZK()+1 ||
				z_ind < hero.getZK() -1
				)
				{
					isDrawing = false;
				}
				
			}
			
		}
		
		private function updAdvVis():void
		{
			var this_dpth:int = Math.abs(t.transform.getRelativeMatrix3D(view).position.z);
			
			t.visible = true;
			
			if (isAdvancedVisibility == true )
			{
				var visibleSide:Number=0;
				if (t.rotationX == 0)
				{
					if (t.rotationY == 0)
					{
						visibleSide = ( Math.sin((Math.PI / 180) * world.rotationY)) * (Global.PL_SIDE / 2);
					}
					if (t.rotationY == 90)
					{
						visibleSide = ( Math.cos((Math.PI / 180) * world.rotationY)) * (Global.PL_SIDE / 2);
					}
					visibleSide = Math.round(Math.abs(visibleSide));
					
					if (this_dpth < -visibleSide) 
					{
						t.visible = false;
					}
				}
				else
				{
					if (this_dpth < ( -Global.PL_SIDE * 1.5))
					{
						t.visible = false;
					}
				}
			}
			
			
		}
		
		public override function getDepth():int
		{
			return depth;
		}
		
		public override function getSprite():Sprite
		{
			return t;
		}
		
		public override function getIsDrawing():Boolean
		{
			return isDrawing;
		}
		
		public override function ligthingUpdate():void
		{
			if (isLight == true  )
			{
				
				var ct:ColorTransform = new ColorTransform();
				
				var offset:Number = - 140 * ((depth / (visKvadr*10))) ;
				
				ct.blueOffset = offset;
				ct.greenOffset = offset;
				ct.redOffset=offset;
				t.transform.colorTransform = ct;
				
				
			}
		}
		
		public function setInDLTRUE():void
		{
			isInDisplList = true;
		}
		
		public function setInDLFALSE():void
		{
			isInDisplList = false;
		}
		
		public function setText(txt:String):void
		{
			text.text = txt;
		}
		
		
	}

}