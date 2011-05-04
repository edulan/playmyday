package org.playmyday.player.model.events
{
	import flash.events.Event;
	
	public class ControlEvent extends Event
	{
		public static const PLAY:String = "play";
		public static const SEEK:String = "seek";
		public static const CHANGE_VOLUME:String = "changeVolume";
		
		public function ControlEvent(type:String) {
			super(type, true, false);
		}
	}
}