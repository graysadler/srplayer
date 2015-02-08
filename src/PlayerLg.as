package 
{

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.greensock.loading.display.*;
	import com.greensock.loading.*;
	import flash.media.SoundTransform;
	import com.demonsters.debugger.MonsterDebugger;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class PlayerLg extends MovieClip
	{
		var strLoader:String;
		//var swfContent:ContentDisplay;
		var obj:Object;
		var swf:ContentDisplay;
		var moveTimer:Timer = new Timer(10000, 1);
		
		public function PlayerLg(strName:String)
		{
			
			moveTimer.addEventListener(TimerEvent.TIMER,onTimerInit);
			moveTimer.start();
			
			// constructor code
			this.addEventListener(MouseEvent.MOUSE_OVER, function(e:MouseEvent):void{showCtls()});
			this.addEventListener(MouseEvent.MOUSE_OUT, function(e:MouseEvent):void{hideCtls()});
			
			this.overlay.visible = false;
			this.mcStreamConfig.visible = false;
			
			this.name = strName;
			this.overlay.chat.gotoAndStop(0);
			gotoAndStop(1);
			arrangePlayer();
			
			//obj = new Object();
		}
		
		function onTimerInit(e:TimerEvent):void {
			initVolume();
			playStream();
			trace('STREAMRIOT: timer event');
		}		
			
		function resizeMe(maxW, maxH):void {
			//var scale:Number = Math.min( this.width / swfContent.rawContent.width,
              //              this.height / swfContent.rawContent.height );
			//this.width = maxW;
			//this.height = maxH;
			trace('STREAMRIOT: resizeMe player ' + this.name + ' ' + this.width + 'x' + this.height);
			//swfContent.rawContent.scaleX = swfContent.rawContent.scaleY = scale;
			//trace('STREAMRIOT: resizeMe swfContent ' + swfContent.name + ' ' + this.width + 'x' + this.height);
		}
		function arrangePlayer():void {
			setChildIndex(this.mcStreamConfig, this.numChildren - 1);
			setChildIndex(this.overlay, this.numChildren - 1);
			setChildIndex(this.placeHolder, 0);
		}
		function showCtls():void
		{
			this.overlay.visible = true;
			this.overlay.visible = true;
		}

		function hideCtls():void
		{
			this.overlay.visible = false;
			this.overlay.visible = false;
		}
		
		function setVolume(pct:Number):void {
			
			
			try {
				if(obj.provider == 'justin.tv') {
					swf.rawContent.api.change_volume(pct);
				} else if(obj.provider == 'own3d.tv') {
					trace('STREAMRIOT: Attempting to change volume for own3d.tv player');
					pct = pct * 100;
					swf.rawContent.getChildAt(0).mediaPlayer.volume = pct;
					trace('STREAMRIOT: Change volume for own3d.tv player');
				}
					
			} catch(e:Error) {
				trace('STREAMRIOT: error changing volume: ' + e.message);
			}
		}
		
		function playStream():void {
			var swfContent:ContentDisplay = LoaderMax.getContent(strLoader) as ContentDisplay;
			//trace('STREAMRIOT: ' +obj.provider);
			try {
				
				if(obj.provider == 'justin.tv') {
					swfContent.rawContent.api.play_live(obj.channel_name, '240p');
				} else if(obj.provider == 'own3d.tv') {
					swf.rawContent.getChildAt(0).playStream(1);
				}
					
			} catch(e:Error) {
				trace('STREAMRIOT: error playing stream: ' + e.message);
			}
		}
		
		function initVolume():void {
			setVolume(.75);
		}
		
		function setLoader(s:String, o:Object):void {
			strLoader = s;
			//trace(o.provider);
			obj = o;
			swf = (LoaderMax.getContent(strLoader) as ContentDisplay);
			moveTimer.start();
		}
		
		function getLoader():String {
			return strLoader;
		}
	}

}