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
			return [ApplicationFacade.PLAY];
		}
		
		override public function handleNotification(note:INotification):void {
			switch(note.getName()) {
				case ApplicationFacade.PLAY:
					var trackVO:TrackVO = note.getBody() as TrackVO;
					
					trackInfoComponent.track = trackVO;
					break;
			}
		}
		
		protected function get trackInfoComponent():TrackInfoComponent {
			return viewComponent as TrackInfoComponent;
		}
	}
}