package org.playmyday.player.model.events
{
	import flash.events.Event;
	
	import org.playmyday.player.model.vo.PlaylistVO;
	import org.playmyday.player.model.vo.TrackVO;
	
	public class PlaylistEvent extends Event
	{
		public static const ADD_PLAYLIST:String 	= "addPlaylist";
		public static const SELECT_PLAYLIST:String 	= "selectPlaylist";
		public static const REMOVE_PLAYLIST:String 	= "removePlaylist";
		public static const ADD_TRACK:String 		= "addTrack"
		
		private var _playlist:PlaylistVO;
		private var _track:TrackVO;
		
		public function PlaylistEvent(type:String, playlist:PlaylistVO, track:TrackVO=null) {
			_playlist = playlist;
			_track = track;
			super(type, true, false);
		}
		
		public function get playlist():PlaylistVO {
			return _playlist;
		}
		
		public function get track():TrackVO {
			return _track;
		}
	}
}