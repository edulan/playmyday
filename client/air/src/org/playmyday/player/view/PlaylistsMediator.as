package org.playmyday.player.view
{
	import mx.collections.ArrayCollection;
	
	import org.playmyday.player.ApplicationFacade;
	import org.playmyday.player.model.PlaylistProxy;
	import org.playmyday.player.model.events.PlaylistEvent;
	import org.playmyday.player.view.components.PlaylistsComponent;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class PlaylistsMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "PlaylistsMediator";
		
		public function PlaylistsMediator(viewComponent:PlaylistsComponent) {
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void {
			playlistsComponent.addEventListener(PlaylistEvent.ADD, onAddPlaylist);
			playlistsComponent.addEventListener(PlaylistEvent.SELECT, onSelectPlaylist);
			playlistsComponent.addEventListener(PlaylistEvent.REMOVE, onRemovePlaylist);
			playlistsComponent.addEventListener(PlaylistEvent.DROP, onDragDrop);
			// Retrieve playlists
			sendNotification(ApplicationFacade.COMMAND_GET_ALL_PLAYLISTS);
		}
		
		override public function listNotificationInterests():Array {
			return [
						ApplicationFacade.GET_ALL_PLAYLISTS_SUCCEED,
						ApplicationFacade.GET_ALL_PLAYLISTS_FAILED,
						ApplicationFacade.ADD_NEW_PLAYLIST_SUCCEED,
						ApplicationFacade.ADD_NEW_PLAYLIST_FAILED,
						ApplicationFacade.REMOVE_PLAYLIST_SUCCEED,
						ApplicationFacade.REMOVE_PLAYLIST_FAILED
					];
		}
		
		override public function handleNotification(note:INotification):void {
			switch(note.getName()) {
				case ApplicationFacade.GET_ALL_PLAYLISTS_SUCCEED:
					handleGetAllPlaylistsSucceed(note.getBody() as ArrayCollection);
					break;
				case ApplicationFacade.GET_ALL_PLAYLISTS_FAILED:
					handleGetAllPlaylistsFailed();
					break;
				case ApplicationFacade.ADD_NEW_PLAYLIST_SUCCEED:
					handleAddNewPlaylistSucceed();
					break;
				case ApplicationFacade.ADD_NEW_PLAYLIST_FAILED:
					handleAddNewPlaylistFailed();
					break;
				case ApplicationFacade.REMOVE_PLAYLIST_SUCCEED:
					handleRemovePlaylistSucceed();
					break;
				case ApplicationFacade.REMOVE_PLAYLIST_FAILED:
					handleRemovePlaylistFailed();
					break;
			}
		}
		
		/* Notification handlers */
		
		private function handleGetAllPlaylistsSucceed(playlists:ArrayCollection):void {
			playlistsComponent.playlists = playlists;
		}
		
		private function handleGetAllPlaylistsFailed():void {
			// TODO: Implement
		}
		
		private function handleAddNewPlaylistSucceed():void {
			// TODO: Implement
		}
		
		private function handleAddNewPlaylistFailed():void {
			// TODO: Implement
		}
		
		private function handleRemovePlaylistSucceed():void {
			// TODO: Implement
		}
		
		private function handleRemovePlaylistFailed():void {
			// TODO: Implement
		}
		
		/* View listeners */
		
		private function onAddPlaylist(evt:PlaylistEvent):void {
			sendNotification(ApplicationFacade.COMMAND_ADD_NEW_PLAYLIST, evt.playlist);
		}

		private function onSelectPlaylist(evt:PlaylistEvent):void {
			sendNotification(ApplicationFacade.PLAYLIST_SELECTED, evt.playlist);
		}

		private function onRemovePlaylist(evt:PlaylistEvent):void {
			sendNotification(ApplicationFacade.COMMAND_REMOVE_PLAYLIST, evt.playlist);
		}
		
		private function onDragDrop(evt:PlaylistEvent):void {
			//evt.playlist.tracks.push(evt.track);
		}

		protected function get playlistsComponent():PlaylistsComponent {
			return viewComponent as PlaylistsComponent;
		}
	}
}