package org.playmyday.player.view
{
	import org.playmyday.player.view.screens.HomeScreen;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class HomeMediator extends Mediator implements IMediator
	{
		// Cannonical name of the Mediator
		public static const NAME:String = "HomeMediator";

		public function HomeMediator(viewComponent:HomeScreen) {
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void {
			facade.registerMediator(new ControlsMediator(homeScreen.controls));
			facade.registerMediator(new TracklistMediator(homeScreen.tracklist));
			facade.registerMediator(new PlaylistsMediator(homeScreen.playlists));
			facade.registerMediator(new TrackInfoMediator(homeScreen.info));
		}
		
		override public function listNotificationInterests():Array {
			return [];
		}
		
		override public function handleNotification(note:INotification):void {
			switch(note.getName()) {
				
			}
		}
		
		protected function get homeScreen():HomeScreen {
			return viewComponent as HomeScreen;
		}
	}
}