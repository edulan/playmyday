package org.playmyday.player.model.events
{
	import flash.events.Event;
	
	import org.playmyday.player.model.vo.TrackVO;
	
	public class TracklistEvent extends Event
	{
		public static const SELECT:String = "selectTrack";
		
		private var _track:TrackVO;
		
		public function TracklistEvent(type:String, track:TrackVO) {
			_track = track;
			super(type, true, false);
		}
		
		public function get track():TrackVO {
			return _track;
		}
	}
}