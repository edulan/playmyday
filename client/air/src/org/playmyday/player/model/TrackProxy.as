package org.playmyday.player.model
{
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import org.playmyday.player.ApplicationFacade;
	import org.playmyday.player.model.utils.Storage;
	import org.playmyday.player.model.vo.PlaylistVO;
	import org.playmyday.player.model.vo.TrackVO;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class TrackProxy extends Proxy
	{
		public static const NAME:String = "TrackProxy";
		private static const TRACKER_URL:String = "http://www.goear.com/tracker758.php?f=";
		
		public function TrackProxy(data:Object=null) {
			super(NAME, data);
		}
		
		public function getAllTracks(playlist:PlaylistVO):void {
			data = new ArrayCollection(Storage.instance.getPlaylistTracks(playlist.name));
			sendNotification(ApplicationFacade.GET_ALL_TRACKS_SUCCEED, tracks);
		}
		
		public function getTrackUrl(track:TrackVO):void {
			var service:HTTPService =  new HTTPService();
			
			service.url = TRACKER_URL + track.goearId;
			service.requestTimeout = 10;
			service.addEventListener(ResultEvent.RESULT,
				function (evt:ResultEvent):void {
					sendNotification(ApplicationFacade.GET_TRACK_URL_SUCCEED, evt.result);
				}
			);
			service.addEventListener(FaultEvent.FAULT,
				function (evt:FaultEvent):void {
					sendNotification(ApplicationFacade.GET_TRACK_URL_FAILED);
				}
			);
			service.send();
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