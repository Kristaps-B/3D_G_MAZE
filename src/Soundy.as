package  
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import net.flashpunk.Sfx;
	/**
	 * ...
	 * @author Kristaps
	 */
	public class Soundy 
	{
		private var sound:Sound;
		private var isSoundPlaying:Boolean = false;
		private var soundChannel:SoundChannel;
		private var volume:Number = 1;
		
		private var canPlayStep:Boolean = false;
		
		private var soundSFX:Sfx;
		
		public function Soundy(sound:Class, vol:Number) 
		{
			volume = vol;
			
			soundSFX = new Sfx(sound);
			soundSFX.volume = volume;
			
		}
		
		private function setVolume(v:Number):void
		{
			soundSFX.volume = volume;
		}
		
		public function play():void
		{
			if (soundSFX.playing == false)
			{
				if (Global.IS_SOUND == true)
				{
					soundSFX.play(volume);
				}
				
			}
			
		}
		
		public function stop():void
		{
			soundSFX.stop();
		}
		
	}

}