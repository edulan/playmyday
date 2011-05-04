package org.playmyday.player.model
{
	import mx.collections.ArrayCollection;
	
	import org.playmyday.player.ApplicationFacade;
	import org.playmyday.player.model.utils.Storage;
	import org.playmyday.player.model.vo.PlaylistVO;
	import org.playmyday.player.model.vo.TrackVO;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class PlaylistProxy extends Proxy
	{
		public static const NAME:String = "PlaylistProxy";
		
		public function PlaylistProxy(data:Object=null) {
			super(NAME, data);
		}
		
		public function getAllPlaylists():void {
			data = new ArrayCollection(Storage.instance.getAllPlaylists());
			sendNotification(ApplicationFacade.GET_ALL_PLAYLISTS_SUCCEED, playlists);
		}
		
		public function addNewPlaylist(playlist:PlaylistVO):void {
			Storage.instance.createPlaylist(playlist.name, playlist);
			playlists.addItem(playlist);
			sendNotification(ApplicationFacade.ADD_NEW_PLAYLIST_SUCCEED);
		}
		
		public function removePlaylist(playlist:PlaylistVO):void {
			Storage.instance.removePlaylist(playlist.name);
			playlists.removeItemAt(playlists.getItemIndex(playlist));
			sendNotification(ApplicationFacade.REMOVE_PLAYLIST_SUCCEED);
		}
		
		protected function get playlists():ArrayCollection {
			return data as ArrayCollection;
		}
	}
}