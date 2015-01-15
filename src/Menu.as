package  
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.display.Bitmap;
	import flash.geom.Matrix;
	
	
	/**
	 * ...
	 * @author Kristaps
	 */
	public class Menu 
	{
		private var world:Sprite;
		
		private var text_title:TextField;
		
		private var text_button_start:TextField;
		private var button_start:Sprite;
		
		private var text_button_sound:TextField;
		private var button_sound:Sprite;
		
		private var buttonSound:Soundy;
		
		private var overSound:Soundy;
		private var whitePlane:Shape;
		private var light:Bitmap;
		
		private var timer:int = 0;
		private var clickTime:int = 20;
		
		private var sparkSound:Soundy;
		
		private var text_author:TextField;
		
		private var text_controls:TextField;
		
		public function Menu(oWorld:Sprite) 
		{
			world = oWorld;
			
			drawAll();
			
			world.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			buttonSound = new Soundy(Global.SFX_CLICK, 0.5);
			overSound = new Soundy(Global.SFX_OVER, 0.5);
			sparkSound = new Soundy(Global.SFX_SPARK, 0.06);
			
			//startGame();
		}
		
		private function drawAll():void
		{
			//White Plane
			var m:Matrix = new Matrix();
			m.scale(12, 12);
			whitePlane = new Shape();
			whitePlane.graphics.beginBitmapFill(Global.imgPars.getBD(),m);
			whitePlane.graphics.drawRect(0, 0, Global.WIDTH, Global.HEIGHT);
			whitePlane.alpha = 0.5;
			world.addChild(whitePlane);
			
			//Light
			light = new Global.GFX_LIGHT();
			light.x = 0;
			light.y = 0;
			light.width = Global.WIDTH;
			light.height = Global.HEIGHT;			
			world.addChild(light);
			
			
			
			//TITLE
			var bigFormat:TextFormat = new TextFormat();
			bigFormat.size = 40;
			bigFormat.bold = true;
			bigFormat.color = 0xDEFF00;
			
			text_title = new TextField();
			text_title.x = Global.WIDTH * 0.25;
			text_title.y = Global.HEIGHT*0.33;
			text_title.defaultTextFormat = bigFormat;
			text_title.width = 400;
			text_title.text = "3D GHOST MAZE";
			text_title.selectable = false;
			world.addChild(text_title);
			
			
			//START BUTTON
			var buttonFormat_start:TextFormat = new TextFormat();
			buttonFormat_start.size = 60;
			buttonFormat_start.bold;
			buttonFormat_start.color = 0xDEFF00;
			
			text_button_start = new TextField();
			text_button_start.defaultTextFormat = buttonFormat_start;
			text_button_start.width = 200;
			text_button_start.x = -100;
			text_button_start.y = -20;
			text_button_start.selectable = false;
			text_button_start.text = "START";
			
			
			button_start = new Sprite();
			button_start.x = Global.WIDTH/2;
			button_start.y = Global.HEIGHT /2;
			button_start.addChild(text_button_start);
			
			world.addChild(button_start);
			
			button_start.width = 70;
			button_start.height = 30;
			
			
			
			button_start.addEventListener(MouseEvent.CLICK, mouseClicked_start);
			button_start.addEventListener(MouseEvent.MOUSE_OVER, mouseOver_start);
			button_start.addEventListener(MouseEvent.MOUSE_OUT, mouseOut_start);
			
			//SOUND BUTTON
			var buttonFormat_sound:TextFormat = new TextFormat();
			buttonFormat_sound.size = 50;
			buttonFormat_sound.bold;
			buttonFormat_sound.color = 0xDEFF00;
			
			text_button_sound = new TextField();
			text_button_sound.defaultTextFormat = buttonFormat_sound;
			text_button_sound.width = 240;
			text_button_sound.x = -120;
			text_button_sound.y = -20;
			text_button_sound.selectable = false;
			text_button_sound.text = "SOUND ON";
			
			
			button_sound = new Sprite();
			button_sound.x = Global.WIDTH*0.9;
			button_sound.y = Global.HEIGHT*0.03;
			button_sound.addChild(text_button_sound);
			
			world.addChild(button_sound);
			
			button_sound.width = 90;
			button_sound.height = 30;
			
			
			
			button_sound.addEventListener(MouseEvent.CLICK, mouseClicked_sound);
			button_sound.addEventListener(MouseEvent.MOUSE_OVER, mouseOver_sound);
			button_sound.addEventListener(MouseEvent.MOUSE_OUT, mouseOut_sound);
			
			var authorFormat:TextFormat = new TextFormat();
			authorFormat.size = 11;
			authorFormat.color = 0xDEFF00;
			
			text_author = new TextField();
			text_author.x = Global.WIDTH * 0.41;
			text_author.y = Global.HEIGHT*0.95;
			text_author.defaultTextFormat = authorFormat;
			text_author.width = 400;
			text_author.text = "MADE BY KEBABS";
			text_author.selectable = false;
			world.addChild(text_author);
			
			
			var controlsFormat:TextFormat = new TextFormat();
			controlsFormat.size = 20;
			controlsFormat.bold;
			controlsFormat.color = 0xFF1200;
			
			text_controls = new TextField();
			text_controls.rotationZ = 18;
			text_controls.x = Global.WIDTH * 0.25;
			text_controls.y = Global.HEIGHT * 0.53;
			text_controls.alpha = 0.6;
			text_controls.defaultTextFormat = controlsFormat;
			text_controls.width = 400;
			
			text_controls.text = "CONTROLS: ARROW KEYS AND SPACE";
			text_controls.selectable = false;
			world.addChild(text_controls);
			
		}
		
		private function onEnterFrame(e:Event):void
		{
			timer ++;
			
			if (timer > clickTime)
			{
				sparkSound.play();
				timer = 0;
				clickTime = Math.random() * 30+20;
				whitePlane.alpha = Math.random() / 2+0.2;
			}
		}
		
		private function mouseClicked_sound(e:Event):void
		{
			if (Global.IS_SOUND == true)
			{
				Global.IS_SOUND = false;
				buttonSound.play();
				text_button_sound.text = "SOUND OFF";
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
		
		private function mouseClicked_start(e:Event):void
		{
			buttonSound.play();
			startGame();
		}
		
		private function mouseOver_start(e:Event):void
		{
			if (text_button_start.scaleX == 1 ) overSound.play();
			text_button_start.scaleX = 1.2;
			text_button_start.scaleY=1.2;
		}
		
		private function mouseOut_start(e:Event):void
		{
			text_button_start.scaleX = 1;
			text_button_start.scaleY= 1;
		}
		
		private function startGame():void
		{
			world.stage.focus = world.stage;
			
			button_start.removeChild(text_button_start);
			text_button_start = null;
			world.removeChild(button_start);
			button_start.removeEventListener(MouseEvent.CLICK, mouseClicked_start);
			button_start.removeEventListener(MouseEvent.MOUSE_OVER, mouseOver_start);
			button_start.removeEventListener(MouseEvent.MOUSE_OUT, mouseOut_start);
			button_start = null;
			
			button_sound.removeChild(text_button_sound);
			text_button_sound = null;
			world.removeChild(button_sound);
			button_sound.removeEventListener(MouseEvent.CLICK, mouseClicked_sound);
			button_sound.removeEventListener(MouseEvent.MOUSE_OVER, mouseOver_sound);
			button_sound.removeEventListener(MouseEvent.MOUSE_OUT, mouseOut_sound);
			button_sound = null;
			
			world.removeChild(text_title);
			text_title = null;
			
			world.removeChild(whitePlane);
			whitePlane = null;
			
			world.removeChild(text_author);
			text_author = null;
			
			world.removeChild(text_controls);
			text_controls = null;
			
			world.removeChild(light);
			light = null;
			
			
			
			world.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			sparkSound.stop();
			sparkSound = null;
			
			var w:MyWorld = new MyWorld(world);
		}
		
	}

}