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
			playlistsComponent.addEventListener(PlaylistEvent.ADD, onAdd);
			playlistsComponent.addEventListener(PlaylistEvent.SELECT, onSelect);
			//playlistsComponent.addEventListener(PlaylistEvent.REMOVE, onRemove);
			playlistsComponent.addEventListener(PlaylistEvent.DRAGDROP, onDragDrop);

			var proxy:PlaylistProxy = facade.retrieveProxy(PlaylistProxy.NAME) as PlaylistProxy
			playlistsComponent.playlists = proxy.getPlaylists();
		}
		
		override public function listNotificationInterests():Array {
			return [];
		}
		
		override public function handleNotification(note:INotification):void {
			switch(note.getName()) {
				
			}
		}
		
		private function onAdd(evt:PlaylistEvent):void {
			playlistsComponent.playlists.addItem(evt.playlist);
			sendNotification(ApplicationFacade.PLAYLIST_ADDED, evt.playlist);
		}

		private function onSelect(evt:PlaylistEvent):void {
			sendNotification(ApplicationFacade.PLAYLIST_SELECTED, evt.playlist);
		}

		//private function onRemove(evt:ListEvent):void {
			
		//}
		
		private function onDragDrop(evt:PlaylistEvent):void {
			evt.playlist.tracks.push(evt.track);
		}

		protected function get playlistsComponent():PlaylistsComponent {
			return viewComponent as PlaylistsComponent;
		}
	}
}