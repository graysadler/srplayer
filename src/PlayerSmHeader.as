package 
{

	import flash.display.MovieClip;
	import com.demonsters.debugger.MonsterDebugger;
	import flash.events.MouseEvent;

	public class PlayerSmHeader extends MovieClip
	{


		public function PlayerSmHeader()
		{
			// constructor code

			chat.buttonMode = true;
			chat.gotoAndStop(2);

			chat.addEventListener(MouseEvent.CLICK, chatClickHandler);

			mcConfigStream.buttonMode = true;
			mcConfigStream.addEventListener(MouseEvent.CLICK, mcConfigStreamClickHandler);

			mcRefreshStream.buttonMode = true;
			mcRefreshStream.addEventListener(MouseEvent.CLICK, mcRefreshStreamClickHandler);
		}
		function chatClickHandler(e:MouseEvent):void
		{
			var strPlayer:String = e.target.parent.parent.parent.name;

			RiotPlayer.instance.clearChats();

			strPlayer = strPlayer.replace("player","");

			if (chat.currentFrame == 2)
			{
				//activate external chat
				//RiotPlayer.instance.updateChat(strPlayer);
				chat.gotoAndStop(1);
			}
			else
			{
				chat.gotoAndStop(2);
			}
		}

		function mcRefreshStreamClickHandler(e:MouseEvent):void
		{
			var strPlayer:String = e.target.parent.parent.name;
			//MonsterDebugger.trace('Refresh Stream', e);
			trace('STREAMRIOT: calling refreshStream(' + strPlayer + ')');
			//MonsterDebugger.trace('root', (root as MovieClip));
			//RiotPlayer.instance.refreshStream(strPlayer);
		}

		function mcConfigStreamClickHandler(e:MouseEvent):void
		{
			if (e.target.parent.parent.mcStreamConfig.visible == true)
			{
				e.target.parent.parent.mcStreamConfig.visible = false;
			}
			else
			{
				e.target.parent.parent.mcStreamConfig.visible = true;
			}
		}

	}

}