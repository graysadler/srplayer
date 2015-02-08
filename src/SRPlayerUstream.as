package  {
	
	import flash.display.MovieClip;
	//import tv.ustream.tools.Debug;
	//import tv.ustream.viewer.logic.Logic;
import flash.events.MouseEvent;
	import flash.events.Event;
	import com.greensock.loading.display.*;
	import com.greensock.loading.*;
	import flash.media.SoundTransform;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.display.Loader;
	import flash.external.ExternalInterface;
	import com.demonsters.debugger.MonsterDebugger;
	import flash.utils.getDefinitionByName;
	
	public class SRPlayerUStream extends SRPlayer {
		
		
		//private var viewer:Logic
		var Viewer:Class = getDefinitionByName('tv.ustream.viewer.logic.Logic') as Class
     	 var viewer:* = new Viewer()

		public function SRPlayerUStream(strName:String = '', nNum:Number = 0, blnCtls:Boolean = false) 
		{
			//if (stage) onAddedToStage()
			//else addEventListener('addedToStage', onAddedToStage)
		}
		
		
		
		private function InitStream(blnAddTimer:Boolean = false):void
		{
			//var Viewer:Class = loader.contentLoaderInfo.applicationDomain.getDefinition(
        //'tv.ustream.viewer.logic.Logic') as Class
					//viewer = new Logic()
			//Debug.enabled = false

			addChild(viewer.display)
			viewer.createChannel('444204')
		
			stage.align = 'TL'
			stage.scaleMode = 'noScale'
			stage.addEventListener('resize', onStageResize)
			stage.addEventListener('mouseDown',onMouseDown)
			onStageResize()
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			if (e.shiftKey) // reload
			{
				var id:String = viewer.channel.mediaId
				viewer.destroy()
				viewer.createChannel(id)
			}
		}
		
		private function onStageResize(...e):void 
		{
			viewer.display.width = stage.stageWidth
			viewer.display.height = stage.stageHeight
		}
		
		public function setLoader(s:String, o:Object, n:Number):void
		{
			return;
			trace('STREAMRIOT: updating loader');
			//if strLoader != to current loader, remove it
			strLoader = s;
			obj = o;
			//swf = (LoaderMax.getLoader(strLoader) as SWFLoader);
			
			swf = (LoaderMax.getContent(strLoader) as ContentDisplay);
			//swf = (LoaderMax.getLoader(strLoader) as SWFLoader);
			//arrangePlayer();
			//updateStats();
			setApi();


		}

	}
	
}