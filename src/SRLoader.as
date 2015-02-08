package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	public class SRLoader extends MovieClip {
		
		var isSmall:Boolean = false;
		
		public function SRLoader(showLogo:Boolean) {
			// constructor code
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			if(showLogo == false) {
				//logo.visible = false;
				loadingStreams.visible = false;
				isSmall = true;
			} else {
				
			}
			
			
		}
		
		function onAddedToStage(e:Event):void {
			//hideLoader();
		}
		
		function showLoader(scale:Number = 1):void {
			//this.x = this.parent.width / 2 * this.parent.scaleX;
			//this.y = this.parent.height / 2 * this.parent.scaleY;
			
			addChild(loaderSlider);
			if(isSmall) {
				this.x = 310;
				this.y = 179;
				//scale = this.parent.scaleX;
			}
			
			this.scaleX = this.scaleY = scale;
			this.scrollRect = new Rectangle(-(this.width / 2) - 5, -(this.height / 2) - 5, this.width + 5, this.height + 5);
			this.visible = true;
		}
		
		function hideLoader():void {
			
			
			try {
				showProgress(0);
				this.removeChild(loaderSlider);
				//showProgress(0);
				//this.visible = false;
				//this.scaleX = this.scaleY = 0;
			} catch (e:Error) {
				trace('SR: error ' + e.message);
			}
		}
		
		function showProgress(pct:Number) {
			loaderSlider.sliderFill.x = -(this.width) + (pct * this.width);
		}
	}
	
}
