package org.playmyday.player.model
{
	import mx.collections.ArrayCollection;
	
	import org.playmyday.player.ApplicationFacade;
	import org.playmyday.player.model.utils.Storage;
	import org.playmyday.player.model.vo.PlaylistVO;
	import org.playmyday.player.model.vo.TrackVO;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class TrackProxy extends Proxy
	{
		public static const NAME:String = "TrackProxy";
		
		public function TrackProxy(data:Object=null) {
			super(NAME, data);
		}
		
		public function getAllTracks(playlist:PlaylistVO):void {
			data = new ArrayCollection(Storage.instance.getPlaylistTracks(playlist.name));
			sendNotification(ApplicationFacade.GET_ALL_TRACKS_SUCCEED, tracks);
		}
		
		public function addTrackToPlaylist(playlist:PlaylistVO, track:TrackVO):void {
			Storage.instance.createPlaylistTrack(playlist.name, track);
			sendNotification(ApplicationFacade.ADD_TRACK_SUCCEED, track);
		}
		
		protected function get tracks():ArrayCollection {
			return data as ArrayCollection;
		}
	}
}