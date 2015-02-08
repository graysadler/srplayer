package 
{

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.StageDisplayState;

	public class PlayerControls extends MovieClip
	{

		var blnMute:Boolean = false;
		var nVol:Number;
		var currentQuality:String;
		var isFullscreen:Boolean = false;
		
		public function PlayerControls()
		{

			currentQuality = "low";
			
			initControls();

			playPause.buttonMode = true;
			volumeIcon.buttonMode = true;
			fullScreen.buttonMode = true;
			toggleHD.buttonMode = true;

			playPause.addEventListener(MouseEvent.CLICK, togglePlay);
			fullScreen.addEventListener(MouseEvent.CLICK, onFullscreen);
			toggleHD.addEventListener(MouseEvent.CLICK, toggleQuality);
			volumeIcon.addEventListener(MouseEvent.CLICK, muteHandler);
			
			this.addEventListener("changeVolume", onChangeVolume);
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
		function onAddedToStage(e:Event):void {
			stage.addEventListener(Event.FULLSCREEN, onFullscreenHandler);
		}
		
		function initControls() {
			if(currentQuality == "low") {
				toggleHD.gotoAndStop(1);
			} else {
				toggleHD.gotoAndStop(2);				
			}
			playPause.gotoAndStop(0);
			fullScreen.gotoAndStop(0);
			volumeIcon.gotoAndStop(4);
			volumeSlider.setVolume(.75, true);
		}
		
		function setVolume(pct:Number):void {
			if(pct != 0) {
				blnMute = false;
			}
			
			if (pct >= 0 && pct <= .1)
			{
				volumeIcon.gotoAndStop(1);
			}
			else if (pct >= .1 && pct < .5)
			{
				volumeIcon.gotoAndStop(2);
			}
			else if (pct >= .5 && pct < .75)
			{
				volumeIcon.gotoAndStop(3);
			}
			else if (pct >= .75 && pct <= 1)
			{
				volumeIcon.gotoAndStop(4);
			}
			else
			{
				volumeIcon.gotoAndStop(1);
			}
			
		}
		
		function onChangeVolume(e:Event):void {
			var pct:Number = e.target.currentVolume;
			
			setVolume(pct);
			
			
		}
		
		function togglePlay(event:MouseEvent):void
		{
			if (playPause.currentFrame == 1)
			{
				dispatchEvent(new Event("streamPaused", true, true));
				playPause.gotoAndStop(2);
			}
			else
			{
				dispatchEvent(new Event("streamPlayed", true, true));
				playPause.gotoAndStop(1);
			}
		}
		
		function onFullscreen(e:MouseEvent):void {
			toggleFullscreen();
		}
		
		function onFullscreenHandler(e:Event):void {
			toggleFullscreen();
		}
		
		function toggleFullscreen():void
		{
			if (isFullscreen == true)
			{
				//stage.align = flash.display.StageAlign.TOP_LEFT;
				stage.displayState = StageDisplayState.NORMAL;
				fullScreen.gotoAndStop(0);
				isFullscreen = false;
			}
			else
			{
				stage.displayState = StageDisplayState.FULL_SCREEN;
				stage.align = "";
				fullScreen.gotoAndStop(2);
				isFullscreen = true;
			}
			stage.align = "";
		}

		function toggleQuality(e:MouseEvent):void
		{
			if (toggleHD.currentFrame == 2)
			{
				toggleHD.gotoAndStop(1);
				setQuality("low");

			}
			else
			{
				toggleHD.gotoAndStop(2);
				setQuality("high");
			}
		}
		
		function getQuality():String {
			return currentQuality;
		}
		
		function setQuality(strQuality:String):void
		{
			currentQuality = strQuality;
			dispatchEvent(new Event("qualityChanged", true, true));
		}

		function muteHandler(e:MouseEvent):void
		{
			if (blnMute == true)
			{
				//unmute
				volumeSlider.setVolume(nVol);
				blnMute = false;
			}
			else
			{
				//mute
				blnMute = true;
				nVol = volumeSlider.getVolume();
				volumeSlider.setVolume(0);
			}
		}
	}

}