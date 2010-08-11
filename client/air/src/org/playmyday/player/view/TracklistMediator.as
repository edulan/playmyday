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
			tracklistComponent.addEventListener(TracklistEvent.PLAY, onPlay);
		}
		
		override public function listNotificationInterests():Array {
			return [ApplicationFacade.PLAYLIST_SELECTED];
		}
		
		override public function handleNotification(note:INotification):void {
			switch(note.getName()) {
				case ApplicationFacade.PLAYLIST_SELECTED:
					var playlistVO:PlaylistVO = note.getBody() as PlaylistVO;

					tracklistComponent.tracks = new ArrayCollection(playlistVO.tracks); 
					break;
			}
		}
		
		private function onPlay(evt:TracklistEvent):void {
			sendNotification(ApplicationFacade.PLAY, evt.track);
		}
		
		protected function get tracklistComponent():TracklistComponent {
			return viewComponent as TracklistComponent;
		}
	}
}