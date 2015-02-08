package 
{

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.text.Font;
	import flash.text.TextFormat;
	
	public class PlayerLgHeader extends MovieClip
	{
		

		public function PlayerLgHeader()
		{
			
			
		}

		

		function mcConfigStreamClickHandler(e:MouseEvent):void
		{
			
			e.target.parent.parent.setChildIndex(e.target.parent.parent.mcStreamConfig, e.target.parent.parent.numChildren - 1);
			
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