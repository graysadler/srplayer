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
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	public class PlayerSm extends MovieClip
	{
		var strLoader:String;
		//var swfContent:ContentDisplay;
		var obj:Object;
		var swf:ContentDisplay;
		//var api:DisplayObject;
		var moveTimer:Timer = new Timer(10000, 1);
		
		public function PlayerSm(strName:String, strNum:String)
		{
			
			moveTimer.addEventListener(TimerEvent.TIMER,onTimerInit);
			
			
			// constructor code
			mcStreamConfig.visible = false;
			this.overlay.chat.gotoAndStop(2);
			this.overlay.visible = false;
			this.name = strName;
			this.overlay.player_num.text = strNum;
			this.addEventListener(MouseEvent.MOUSE_OVER,  function(e:MouseEvent):void{showOverlay()});
			this.addEventListener(MouseEvent.MOUSE_OUT, function(e:MouseEvent):void{hideOverlay()});
			arrangePlayer();
			
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
			//swfContent.rawContent.scaleX = swfContent.rawContent.scaleY = scale;
		}
		
		function setLoader(s:String, o:Object):void {
			trace('STREAMRIOT: Setting loader on player ' + this.name);
			strLoader = s;
			//swfContent = LoaderMax.getContent(strLoader);
			obj = o;
			swf = (LoaderMax.getContent(strLoader) as ContentDisplay);
			//api = (swf.rawContent.getChildAt(0) as DisplayObject);
			moveTimer.start();
		}
		
		function getLoader():String {
			return strLoader;
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
			//var swfContent:ContentDisplay = (LoaderMax.getContent(strLoader) as ContentDisplay);
			trace('STREAMRIOT: playStream ' +obj.provider);
			//MonsterDebugger.trace('swf.rawContent.getChildAt(0)', swf.rawContent.getChildAt(0));
			try {
				
				if(obj.provider == 'justin.tv') {
					swf.rawContent.api.play_live(obj.channel_name, '240p');
				} else if(obj.provider == 'own3d.tv') {
					swf.rawContent.getChildAt(0).playStream(1);
				}
					
			} catch(e:Error) {
				trace('STREAMRIOT: error playing stream: ' + e.message);
			}
		}
		
		function initVolume():void {
			trace('STREAMRIOT: Initializing volume on player ' + this.name);
			setVolume(0);
		}
		
		function arrangePlayer():void {
			setChildIndex(this.mcStreamConfig, this.numChildren - 1);
			setChildIndex(this.overlay, this.numChildren - 1);
			setChildIndex(this.placeHolder, 0);
		}
		
		function showOverlay():void
		{
			overlay.visible = true;
		}

		function hideOverlay():void
		{
			overlay.visible = false;
		}
		
	}

}