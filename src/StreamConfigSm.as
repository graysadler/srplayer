package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class StreamConfigSm extends MovieClip {
		
		
		public function StreamConfigSm() {
			// constructor code
			btnClosePlayer.addEventListener(MouseEvent.CLICK, ClosePlayer);
			btnRemoveStream.addEventListener(MouseEvent.CLICK, RemoveStream);


		}
				
		function ClosePlayer(e:MouseEvent) {
			trace("STREAMRIOT: closing player " + e.target.parent.parent.name);
			MovieClip(root).ClosePlayer(e.target.parent.parent.name);
		}
		
		function RemoveStream(e:MouseEvent) {
			trace("STREAMRIOT: closing player " + e.target.parent.parent.name);
			MovieClip(root).RemoveStream(e.target.parent.parent.name);
		}
	}
	
}
