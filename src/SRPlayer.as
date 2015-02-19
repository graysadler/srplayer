﻿package {	import flash.display.MovieClip;	import flash.events.MouseEvent;	import flash.events.Event;	import com.greensock.loading.display.*;	import com.greensock.loading.*;	import com.greensock.events.LoaderEvent;	import flash.media.SoundTransform;	import flash.events.TimerEvent;	import flash.utils.Timer;	import flash.display.Loader;	import flash.external.ExternalInterface;	//import com.demonsters.debugger.//MonsterDebugger;			public class SRPlayer extends MovieClip	{		public var strLoader:String;		public var obj:Object;		public var swf:ContentDisplay;		public var swfLoader:SWFLoader;		var initTimer:Timer = new Timer(500,20);		var arrangeTimer:Timer = new Timer(3000);		var adTimer:Timer = new Timer(1000, 60);		var streamConfig:StreamConfig;		public var blnShowCtls:Boolean;		public var currentQuality:String;		public var playerNum:Number;		public var isScaled:Boolean = false;		public var hasLoader:Boolean = false;		public var api:*;		public var dWidth:Number = 620;		public var dHeight:Number = 378;		public var currentVolume:Number = 1;				public var mcLoader:SRLoader = new SRLoader(false);						public function getLoader():ContentDisplay		{			return swf;		}				public function changeQuality(strQuality:String = "low"):Boolean {			return true;		}				public function SRPlayer(strName:String, nNum:Number, blnCtls:Boolean = false, objStream:Object = null)		{				arrangeTimer.addEventListener(TimerEvent.TIMER, timerArrange);			adTimer.addEventListener(TimerEvent.TIMER, onAdTimer);						addEventListener(Event.REMOVED_FROM_STAGE, dealloc);						if (nNum == 1) {				blnCtls = true;			}						blnShowCtls = blnCtls;			this.addEventListener(MouseEvent.ROLL_OVER, function(e:MouseEvent):void{showCtls()});			this.addEventListener(MouseEvent.ROLL_OUT, function(e:MouseEvent):void{hideCtls()});			this.addEventListener("closeConfig", onCloseConfig);			this.addEventListener("updateChat", onUpdateChat);			this.overlay.visible = false;			streamConfig = new StreamConfig();						this.name = strName;			playerNum = nNum;			strLoader = strName;			obj = objStream;			gotoAndStop(1);			addChild(streamConfig);			streamConfig.x = 550;			streamConfig.y = 45;						currentQuality = "low";			this.overlay.visible = false;			streamConfig.visible = false;			updateStats();			arrangePlayer();			initControls();		}				function dealloc(e:Event):void {				}				public function checkFrozen():Boolean {			return false;		}				public function onResize(scale:Number):void {					}				public function loaderProgress(pct:Number) {			mcLoader.showProgress(pct);		}		public function scalePlayer():void {					}		public function initStream(blnAddTimer:Boolean = false):void		{			//try initializing volume and play the stream			//if it fails, set a timer event every second for 10 seconds			//add listener for load complete			var hasError:Boolean = false;			var scale:Number;			trace('STREAMRIOT: initializing stream with dimensions: ' + this.width + 'x' + this.height);			hasError = setApi();			hasLoader = true;			if (changeQuality(currentQuality) == false)			{				if (blnAddTimer)				{					initTimer.addEventListener(TimerEvent.TIMER,timerInit);					this.addEventListener("loadComplete", loadComplete);					trace('STREAMRIOT: error initStream for loader ' + strLoader);					initTimer.start();					trace('STREAMRIOT: init timer start for loader ' + strLoader);				}				return;			}						initVolume();			updateStats();						arrangePlayer();						adTimer.start();			trace('SR: initStream complete');						this.dispatchEvent(new Event("loadComplete", true, true));					}		function onUpdateChat(e:Event):void		{			if(ExternalInterface.available) {				//ExternalInterface.call("updateChat", obj);				//trace('STREAMRIOT: updating chat');			}		}		function updateStats():void		{			//#viewers			try {				this.overlay.player_num.text = String(playerNum);				if (obj != null)				{					//#channel_name					this.overlay.channel_name.text = obj.channel_name;									}				else				{					//this.overlay.num_viewers.text = "";					this.overlay.channel_name.text = "";				}			} catch(e:Error) {							}		}		function loadComplete(e:Event):void		{			trace('STREAMRIOT: init timer stopped for loader ' + strLoader);			initTimer.stop();			scalePlayer();		}		function timerInit(e:TimerEvent):void		{			trace('STREAMRIOT: init timer event for loader ' + strLoader);			initStream();		}		function timerArrange(e:TimerEvent):void		{			trace('STREAMRIOT: timerArrange');			arrangePlayer();		}				public function onAdTimer(e:TimerEvent):void {			if (checkFrozen() == true) {				refreshStream();			}		}		function refreshStream():void {			playStream(currentQuality);		}				public function arrangePlayer():void		{			setChildIndex(this.overlay, this.numChildren - 1);			setChildIndex(this.streamConfig, this.numChildren - 1);			setChildIndex(this.playerBG, 0);			streamConfig.setNum(playerNum, strLoader);		}				function initControls():void {		}		function showCtls():void		{			this.overlay.visible = true;			this.overlay.visible = true;			this.streamConfig.visible = true;		}		function hideCtls():void		{			this.overlay.visible = false;			this.overlay.visible = false;			this.streamConfig.visible = false;		}				function onCloseConfig(e:Event):void {			this.streamConfig.visible = false;		}			public function muteVolume() {			setVolume(0, false);			trace('SR: muting ' + this.playerNum);		}		public function unmuteVolume() {			//setVolume(currentVolume);			setVolume(1);			trace('SR: unmuting ' + this.playerNum + ' ' + currentVolume);					}		public function setVolume(pct:Number, blnSave:Boolean = true):Boolean		{			trace('SR: setting volume ' + pct + ' ' + this.playerNum);			if (blnSave == true) {				currentVolume = pct;			}			return true;		}		public function playStream(strQuality:String = ""):Boolean		{			if(strQuality == '') {				strQuality = currentQuality;			}						trace('STREAMRIOT: attempting to play stream');			try			{				return true;			}			catch (e:Error)			{				trace('STREAMRIOT: error playing stream: ' + e.message);				return false;			}			return true;		}		public function stopStream():void		{				if(obj == null || api == null) {			   return;			}					}		function removeStream():void		{			stopStream();						try			{				var loader:SWFLoader = LoaderMax.getLoader(strLoader);				loader.dispose(true);				trace('STREAMRIOT: removed stream');			}			catch (e:Error)			{				trace('STREAMRIOT: error removing stream. ' + e.message);			}			hasLoader = false;			isScaled = false;			swf = null;			api = null;			obj = null;			this.overlay.visible = false;			this.overlay.channel_name.text = '';		}		public function pauseStream():Boolean		{						return true;		}		function initVolume():Boolean		{			trace('STREAMRIOT: attempting to initialize volume');			if (blnShowCtls)			{				unmuteVolume();			}			else			{				muteVolume();							}			return true;		}		function updatePlayer(n:Number):void		{			playerNum = n;			this.streamConfig.setNum(n, strLoader);						updateStats();			blnShowCtls = false;						if (playerNum == 1)			{				blnShowCtls = true;				unmuteVolume();			}			else			{				muteVolume();			}		}		function setLoader(s:String, o:Object, n:Number):void		{			trace('STREAMRIOT: updating loader');			//if strLoader != to current loader, remove it			strLoader = s;			obj = o;						swf = (LoaderMax.getContent(strLoader) as ContentDisplay);			setApi();		}		public function showLoader():void {							mcLoader.visible = true;			addChild(mcLoader);						mcLoader.showLoader();			bringToFront(mcLoader)					}				public function hideLoader():void {						mcLoader.hideLoader();			removeChild(mcLoader);		}				public function validateSwf():Boolean {			try {							} catch (e:Error) {							}						return true;		}		function progressHandler(event:LoaderEvent):void		{			trace("STREAMRIOT: Queue progress: " + event.target.progress);			mcLoader.showProgress(event.target.progress);		}		private function bringToFront(mcl:MovieClip) {			mcl.parent.setChildIndex(mcl,mcl.parent.numChildren - 1);		}						public function addLoader(objStream:Object, blnShowLoading:Boolean = true):SWFLoader {			var loader:SWFLoader;			trace('STREAMRIOT: adding loader to player');			////MonsterDebugger.trace('adding loader to player', null);			if(blnShowLoading == true) {				showLoader();			////MonsterDebugger.trace('show loading', null);							}						loader = new SWFLoader(objStream.src, { 				name:this.name, 				container:this, 				x:0, 				y:0, 				autoPlay:true, 				hAlign:"center", 				vAlign:"middle", 				allowMalformedURL:true, 				onComplete:onLoaderComplete, 				onProgress:progressHandler,				onInit:initHandler } 			); 				//loader.content.visible = false;								obj = objStream;						//swfLoader = loader;						return loader;			}				function initHandler(event:LoaderEvent):void {			trace("STREAMRIOT: player loader completed ");			var strLoader:String = event.target.name;			swf = (LoaderMax.getContent(strLoader) as ContentDisplay);			swfLoader = LoaderMax.getLoader(strLoader);			if (validateSwf() == false) {				trace('SR: Loader failed');				var loader:SWFLoader = LoaderMax.getLoader(strLoader);				loader.load(true);				return;			}						arrangePlayer();									initStream(true);		}				public function onLoaderComplete(event:LoaderEvent):void		{									hideLoader();			dispatchEvent(new Event("updateLayout", true, true));			//swfLoader.rawContent.visible = true;		}					public function setApi():Boolean		{						try			{				if (swf.getChildAt(0) is Loader)				{					trace("STREAMRIOT: Loader found as content");					api = swf.rawContent.getChildAt(0);				}				else				{					api = swf.rawContent;					trace("STREAMRIOT: No security errors api wxh:" + api.width + 'x' + api.height);				}									trace('STREAMRIOT: Loader API var saved');			}			catch (e:Error)			{				trace('STREAMRIOT: error saving api ' + e.message); 			}						if(api == null || api.width == 0 || api.height == 0) {				return false;			}						return true;					}	}}