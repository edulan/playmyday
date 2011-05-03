package org.playmyday.player.model.events
{
	import flash.events.Event;
	
	import org.playmyday.player.model.vo.PlaylistVO;
	
	public class PlaylistEvent extends Event
	{
		public static const ADD:String 		= "addPlaylist";
		public static const SELECT:String 	= "selectPlaylist";
		public static const REMOVE:String 	= "removePlaylist";
		public static const DROP:String 	= "dropTrack"
		
		private var _playlist:PlaylistVO;
		
		public function PlaylistEvent(type:String, playlist:PlaylistVO) {
			_playlist = playlist;
			super(type, true, false);
		}
		
		public function get playlist():PlaylistVO {
			return _playlist;
		}
	}
}