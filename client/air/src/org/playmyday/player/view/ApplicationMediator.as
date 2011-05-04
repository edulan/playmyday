package org.playmyday.player.view
{
	import mx.events.StateChangeEvent;
	
	import org.playmyday.player.ApplicationFacade;
	import org.playmyday.player.view.screens.LoginScreen;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

    public class ApplicationMediator extends Mediator implements IMediator
    {
        // Cannonical name of the Mediator
        public static const NAME:String = "ApplicationMediator";

        public function ApplicationMediator(viewComponent:PlayMyDay) {
            super(NAME, viewComponent);
		}

        override public function onRegister():void {
			app.addEventListener(StateChangeEvent.CURRENT_STATE_CHANGE, onStateChange);
        }

        override public function listNotificationInterests():Array {
            return [
						ApplicationFacade.VIEW_LOGIN_SCREEN,
						ApplicationFacade.VIEW_HOME_SCREEN
					];
        }

        override public function handleNotification(note:INotification):void {
            switch(note.getName()) {
				case ApplicationFacade.VIEW_LOGIN_SCREEN:
					app.currentState = app.loginState.name;
					break;
				case ApplicationFacade.VIEW_HOME_SCREEN:
					app.currentState = app.homeState.name;
					break;
            }
        }
		
		/* View listeners */
		
		private function onStateChange(evt:StateChangeEvent):void {
			// Remove previous screen mediator
			switch (evt.oldState) {
				case app.loginState.name:
					facade.removeMediator(LoginMediator.NAME);
					break;
				case app.homeState.name:
					facade.removeMediator(HomeMediator.NAME);
					break;
			}
			// Register a new mediator for new screen
			switch (evt.newState) {
				case app.loginState.name:
					facade.registerMediator(new LoginMediator(app.loginScreen));
					break;
				case app.homeState.name:
					facade.registerMediator(new HomeMediator(app.homeScreen));
					break;
			}
		}

        protected function get app():PlayMyDay {
            return viewComponent as PlayMyDay;
        }
    }
}