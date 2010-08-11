package org.playmyday.player.model.events
{
	import flash.events.Event;
	
	import org.playmyday.player.model.vo.PlaylistVO;
	import org.playmyday.player.model.vo.TrackVO;
	
	public class PlaylistEvent extends Event
	{
		public static const ADD:String 		= "add";
		public static const SELECT:String 	= "select";
		public static const REMOVE:String 	= "remove";
		public static const DRAGDROP:String = "dragdrop"
		
		private var playlistVO:PlaylistVO;
		private var trackVO:TrackVO;
		
		public function PlaylistEvent(type:String, playlist:PlaylistVO, track:TrackVO=null, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			playlistVO = playlist;
			trackVO = track;
		}
		
		public function get playlist():PlaylistVO {
			return playlistVO;
		}
		
		public function get track():TrackVO {
			return trackVO;
		}
	}
}