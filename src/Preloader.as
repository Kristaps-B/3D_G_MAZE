package  
{
	/**
	 * ...
	 * @author Kristaps
	 */
	import com.newgrounds.components.*;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	import flash.display.DisplayObject;
	import com.newgrounds.*;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.text.TextFormat;
	import flash.events.MouseEvent;
	
	 
	public class Preloader extends MovieClip
	{
		private var text:TextField = new TextField();
		private var isLoaded:Boolean = false;
		private var flashAd:FlashAd;
		
		private var text_button_start:TextField;
		private var button_start:Sprite;
		
		private var loadingProgr:int = 0;
		
		private var buttonSound:Soundy;
		private var overSound:Soundy;
		
		public function Preloader() 
		{			
			API.connect(root, "38460:9nFQrZ3V", "XBz5V0gQrklFL4r33aiZ0yZoFIL1QXBc");
			
			flashAd = new FlashAd();
			
			flashAd.x = (stage.stageWidth - flashAd.width) / 2;
			flashAd.y = (stage.stageHeight - flashAd.height) / 2 -20;
			flashAd.showBorder = false;
					
			addChild(flashAd);
			
			overSound = new Soundy(Global.SFX_OVER, 0.5);
			buttonSound = new Soundy(Global.SFX_SPARK, 0.06);
			
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			
			addChild(text);
			text.x = (stage.stageWidth-text.width)/2-16;
			text.y = (stage.stageHeight-text.height)/2+150;
			text.scaleX = text.scaleY = 1;
			text.text =  "Loading: " + Math.ceil((loaderInfo.bytesLoaded/loaderInfo.bytesTotal)*100) + "%";
			text.textColor = 0xDEFF00;
			text.selectable = false;
			
			
		}
		
		public function onEnterFrame(e:Event):void
		{
			//Loading
			if (isLoaded == false)
			{
				loadingProgress();
			}
			else
			{
				//Gaida kad nospiedis Z pogu
				
			}
			
			
		}
		
		private function loadingProgress():void
		{
			if (loaderInfo.bytesLoaded >= loaderInfo.bytesTotal)
			{
				if (loadingProgr== 100)
				{
					//text.text =  "LOADING: " + Math.ceil((loaderInfo.bytesLoaded / loaderInfo.bytesTotal) * 100) + "%";
					isLoaded = true;
					//stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
					
					//Uzliek textu
					/*
					addChild(pressText);
					pressText.x = stage.width-pressText.width-25;
					pressText.y = stage.height - pressText.height - 25;
					pressText.scaleX = pressText.scaleY = 1.5;
					pressText.text =  "PRESS [Z]";
					pressText.textColor = 0xFFFFFF;
					pressText.selectable = false;
					text.text = "";
					*/
					removeChild(text);
					text = null;
					startStart();
				}
				else 
				{
					loadingProgr ++;
					text.text =  "LOADING: " + loadingProgr;
				}	
				
			}
			
			
			
		}
		
		private function startStart():void
		{
			//START BUTTON
			var buttonFormat_start:TextFormat = new TextFormat();
			buttonFormat_start.size = 60;
			buttonFormat_start.bold;
			buttonFormat_start.color = 0xDEFF00;
			
			text_button_start = new TextField();
			text_button_start.defaultTextFormat = buttonFormat_start;
			text_button_start.width = 200;
			text_button_start.x = -100;
			text_button_start.y = 317;
			text_button_start.selectable = false;
			text_button_start.text = "GO";
			
			
			button_start = new Sprite();
			button_start.x = Global.WIDTH/2;
			button_start.y = Global.HEIGHT /2;
			button_start.addChild(text_button_start);
			
			addChild(button_start);
			
			button_start.width = 70;
			button_start.height = 30;
			
			//Events
			button_start.addEventListener(MouseEvent.CLICK, mouseClicked_start);
			button_start.addEventListener(MouseEvent.MOUSE_OVER, mouseOver_start);
			button_start.addEventListener(MouseEvent.MOUSE_OUT, mouseOut_start);
		}
		
		private function mouseClicked_start(e:Event):void
		{
			buttonSound.play();
			startup();
		}
		
		private function mouseOver_start(e:Event):void
		{
			if (text_button_start.scaleX == 1 ) overSound.play();
			text_button_start.scaleX = 1.2;
			text_button_start.scaleY = 1.2;
			
			
		}
		
		private function mouseOut_start(e:Event):void
		{
			text_button_start.scaleX = 1;
			text_button_start.scaleY= 1;
		}
		
		
		private function startup():void
		{
		
			stop();
			
			removeChild(flashAd);
			button_start.removeChild(text_button_start);
			text_button_start = null;
			removeChild(button_start);
			button_start = null;
			
			Global.stage = stage;
			
			var mainClass:Class = getDefinitionByName("Main") as Class;
			
			addChild(new mainClass as DisplayObject);
			
			
			
		}
		
	}

}