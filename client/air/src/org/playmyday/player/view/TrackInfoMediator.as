package org.playmyday.player.view
{
	import org.playmyday.player.ApplicationFacade;
	import org.playmyday.player.model.vo.TrackVO;
	import org.playmyday.player.view.components.TrackInfoComponent;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class TrackInfoMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "TrackInfoMediator";
		
		public function TrackInfoMediator(viewComponent:TrackInfoComponent) {
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void {

		}
		
		override public function listNotificationInterests():Array {
			return [
						ApplicationFacade.TRACK_SELECTED
					];
		}
		
		override public function handleNotification(note:INotification):void {
			switch(note.getName()) {
				case ApplicationFacade.TRACK_SELECTED:
					handleTrackSelected(note.getBody() as TrackVO);
					break;
			}
		}
		
		/* Notification handlers */
		
		private function handleTrackSelected(track:TrackVO):void {
			trackInfoComponent.track = track;
		}
		
		protected function get trackInfoComponent():TrackInfoComponent {
			return viewComponent as TrackInfoComponent;
		}
	}
}