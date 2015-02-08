package com.streamriot
{

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import com.greensock.loading.display.*;
	import com.greensock.loading.*;
	import flash.media.SoundTransform;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.display.Loader;
	import flash.external.ExternalInterface;
		
	public class SRPlayerTwitch extends SRPlayer
	{
		// This will hold the API player instance once it is initialized.
		var player:Object;

		public function SRPlayerTwitch(strName:String, nNum:Number, blnCtls:Boolean = false) {
			super(strName, nNum, blnCtls);
		}

		function onLoaderInit(event:Event):void {
			addChild(loader);
			loader.content.addEventListener("onReady", onPlayerReady);
			loader.content.addEventListener("onError", onPlayerError);
			loader.content.addEventListener("onStateChange", onPlayerStateChange);
			loader.content.addEventListener("onPlaybackQualityChange", 
				onVideoPlaybackQualityChange);
		}

		function onPlayerReady(event:Event):void {
			// Event.data contains the event parameter, which is the Player API ID 
			trace("player ready:", Object(event).data);

			// Once this event has been dispatched by the player, we can use
			// cueVideoById, loadVideoById, cueVideoByUrl and loadVideoByUrl
			// to load a particular YouTube video.
			player = loader.content;
			// Set appropriate player dimensions for your application
			player.setSize(480, 360);
		}

		function onPlayerError(event:Event):void {
			// Event.data contains the event parameter, which is the error code
			trace("player error:", Object(event).data);
		}

		function onPlayerStateChange(event:Event):void {
			// Event.data contains the event parameter, which is the new player state
			trace("player state:", Object(event).data);
		}

		function onVideoPlaybackQualityChange(event:Event):void {
			// Event.data contains the event parameter, which is the new video quality
			trace("video quality:", Object(event).data);
		}	

		public override function initStream(blnAddTimer:Boolean = false):void {
			super.initStream(blnAddTimer);
		}
		
		public override function setVolume(pct:Number, blnSave:Boolean = true):Boolean
		{
			try
			{
				trace('STREAMRIOT: changing twitch volume: ' + pct);
				pct = pct * 100;
				api.api.change_volume(pct);
				super.setVolume(pct / 100, blnSave);
				return true;
			}
			catch (e:Error)
			{
				trace('STREAMRIOT: error changing twitch volume: ' + e.message);
				return false;
			}

			return true;
		}
		
		public override function stopStream():void
		{	
			
			if(obj == null || api == null) {
			   return;
			}
			
			try {
				api.api.play_live(0);
			} catch (e:Error) {
				trace('STREAMRIOT: error stopping stream');
			}
		}
		
		public override function pauseStream():Boolean
		{
			trace('STREAMRIOT: attempting to pause twitch stream');
			try
			{
				api.api.pause_video();

				return true;

			}
			catch (e:Error)
			{
				trace('STREAMRIOT: error pausing twitch stream: ' + e.message);
				return false;
			}
			return true;
		}		
		
		public override function playStream(strQuality:String = "low"):Boolean
		{
			trace('STREAMRIOT: attempting to play twitch stream');
			try
			{

				if (strQuality == "high")
				{
					api.api.play_live(obj.channel_name, '360p');
				}
				else
				{
					api.api.play_live(obj.channel_name, '240p');
				}
					
				return true;

			}
			catch (e:Error)
			{
				trace('STREAMRIOT: error playing twitch stream: ' + e.message);
				return false;
			}
			return true;
		}
	}

}