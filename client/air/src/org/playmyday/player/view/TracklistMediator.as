package org.playmyday.player.view
{
	import mx.collections.ArrayCollection;
	
	import org.playmyday.player.ApplicationFacade;
	import org.playmyday.player.model.events.TracklistEvent;
	import org.playmyday.player.model.vo.PlaylistVO;
	import org.playmyday.player.model.vo.TrackVO;
	import org.playmyday.player.view.components.TracklistComponent;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class TracklistMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "TracklistMediator";
		
		public function TracklistMediator(viewComponent:TracklistComponent) {
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void {
			tracklistComponent.addEventListener(TracklistEvent.SELECT, onSelect);
		}
		
		override public function listNotificationInterests():Array {
			return [
						ApplicationFacade.PLAYLIST_SELECTED,
						ApplicationFacade.PLAYBACK_COMPLETED,
						ApplicationFacade.GET_ALL_TRACKS_SUCCEED,
						ApplicationFacade.GET_ALL_TRACKS_FAILED
					];
		}
		
		override public function handleNotification(note:INotification):void {
			switch(note.getName()) {
				case ApplicationFacade.PLAYLIST_SELECTED:
					handlePlaylistSelected(note.getBody() as PlaylistVO);
					break;
				case ApplicationFacade.PLAYBACK_COMPLETED:
					handlePlaybackCompleted(note.getBody() as TrackVO);
					break;
				case ApplicationFacade.GET_ALL_TRACKS_SUCCEED:
					handleGetAllTracksSucceed(note.getBody() as ArrayCollection);
					break;
				case ApplicationFacade.GET_ALL_TRACKS_FAILED:
					handleGetAllTracksFailed();
					break;
			}
		}
		
		/* Notification handlers */
		
		private function handlePlaylistSelected(playlist:PlaylistVO):void {
			sendNotification(ApplicationFacade.COMMAND_GET_ALL_TRACKS, playlist.id);
		}
		
		private function handlePlaybackCompleted(track:TrackVO):void {
			var currentIndex:int = tracklistComponent.tracks.getItemIndex(track);
			var nextTrack:TrackVO = tracklistComponent.tracks.getItemAt(currentIndex + 1) as TrackVO;
			
			sendNotification(ApplicationFacade.TRACK_SELECTED, nextTrack);
		}
		
		private function handleGetAllTracksSucceed(tracks:ArrayCollection):void {
			tracklistComponent.tracks = tracks;
		}
		
		private function handleGetAllTracksFailed():void {
			// TODO: Implement
		}
		
		/* View listeners */
		
		private function onSelect(evt:TracklistEvent):void {
			sendNotification(ApplicationFacade.TRACK_SELECTED, evt.track);
		}
		
		protected function get tracklistComponent():TracklistComponent {
			return viewComponent as TracklistComponent;
		}
	}
}