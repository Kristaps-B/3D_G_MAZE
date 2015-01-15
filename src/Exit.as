package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	
	/**
	 * ...
	 * @author Kristaps
	 */
	public class Exit extends GameObject
	{
		
		private var isNowOnExit:Boolean = false;
		
		public function Exit(x:int, z:int, world:MyWorld, x_i:int, z_i:int) 
		{
			t = new Sprite();
			this.world = world.getWorld();
			this.hero = world.getHero();
			
			x_offset = x;
			z_offset = z;
			
			x_ind = x_i;
			z_ind = z_i;
			
			visKvadr = 10;
			
			t.x = x;
			t.z = z;
			t.y = 0;
			//t.rotationX = 30;
			
			//t.graphics.beginFill(0xFFFFFF,1);
			//t.graphics.drawCircle(0, 0, Global.PL_SIDE / 2 - 200);
			isLight = true;
			
			var img:Bitmap = new Global.GFX_DOORS();
			
			img.x = - 350;
			img.y = - 400;
			img.width = 700;
			img.height = 800;
			
			t.addChild(img);
			
			//trace("HERO X: " + hero.getXK() + " Z: " +hero.getZK());
		}
		
		public override function update():void
		{
			//updVisibility();
			//updDepth();
			
			//Update
			{
				t.x = x_offset - hero.x;
				t.z = z_offset - hero.z;
				t.rotationY = - hero.getAngle();
			}
			
			
			
		
			
			isOnExit();
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
			
			depth = Math.round(DistanceTwoPoints(h_x, h_z, x_k, z_k));
			depth -= 1;
			//text.text = "D: " + depth;
		}
		
		public override function updVisibility():void
		{
			
			var x_k:int = x_ind * 10;
			var z_k:int = z_ind * 10;
			
			
			
			var h_kx:int = hero.getXK();
			var h_kz:int = hero.getZK();
			
			isDrawing = true;
			
			if (
				depth > (visKvadr) * 4
			)
			{
				isDrawing = false;
				if (t.visible == true)
				{
					t.visible = false;
				}
			}
			else
			{
				if (t.visible == false)
				{
					t.visible = true;
				}
			}
			
		}
		
		private function isOnExit():void
		{
			
			
			if (x_ind == hero.getXK() && z_ind == hero.getZK())
			{
				
				
				if (isNowOnExit == false)
				{
					isNowOnExit = true;
					
					hero.canGoNextLVL = true;
					
					//x_ind = -100;
					//z_ind = -100;
				}
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
				
				var offset:Number = - 180 * ((depth / (visKvadr*4))) ;
				
				ct.blueOffset = offset;
				ct.greenOffset = offset;
				ct.redOffset=offset;
				t.transform.colorTransform = ct;
				
			}
		}
	
	}

}