package org.playmyday.player.model.events
{
	import flash.events.Event;
	
	import org.playmyday.player.model.vo.TrackVO;
	
	public class TracklistEvent extends Event
	{
		public static const PLAY:String = "play";
		
		private var _track:TrackVO;
		
		public function TracklistEvent(type:String, track:TrackVO, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			_track = track;
		}
		
		public function get track():TrackVO {
			return _track;
		}
	}
}