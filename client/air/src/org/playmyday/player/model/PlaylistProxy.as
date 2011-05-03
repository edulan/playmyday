package org.playmyday.player.model
{
	import mx.collections.ArrayCollection;
	
	import org.playmyday.player.ApplicationFacade;
	import org.playmyday.player.model.vo.PlaylistVO;
	import org.playmyday.player.model.vo.TrackVO;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class PlaylistProxy extends Proxy
	{
		public static const NAME:String = "PlaylistProxy";
		
		public function PlaylistProxy(data:Object=null) {
			// Mock data
			var p1:PlaylistVO =  new PlaylistVO();
			
			p1.id = 1;
			p1.name = "Los Planetas";
			
			data = new ArrayCollection([p1]);
			super(NAME, data);
		}
		
		public function getAllPlaylists():void {
			sendNotification(ApplicationFacade.GET_ALL_PLAYLISTS_SUCCEED, playlists);
		}
		
		public function addNewPlaylist(playlist:PlaylistVO):void {
			playlists.addItem(playlist);
			sendNotification(ApplicationFacade.ADD_NEW_PLAYLIST_SUCCEED);
		}
		
		public function removePlaylist(playlist:PlaylistVO):void {
			playlists.removeItemAt(playlists.getItemIndex(playlist));
			sendNotification(ApplicationFacade.REMOVE_PLAYLIST_SUCCEED);
		}
		
		protected function get playlists():ArrayCollection {
			return data as ArrayCollection;
		}
	}
}