package org.playmyday.player.view
{
	import org.playmyday.player.ApplicationFacade;
	import org.playmyday.player.model.events.LoginEvent;
	import org.playmyday.player.view.screens.LoginScreen;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

    public class LoginMediator extends Mediator implements IMediator
    {
        // Cannonical name of the Mediator
        public static const NAME:String = "LoginMediator";

        public function LoginMediator(viewComponent:LoginScreen) {
            super(NAME, viewComponent);
		}

        override public function onRegister():void {
			loginScreen.addEventListener(LoginEvent.LOGIN, onLogin);
        }

        override public function listNotificationInterests():Array {
            return [
						ApplicationFacade.LOGIN_SUCCEED,
						ApplicationFacade.LOGIN_FAILED
					];
        }

        override public function handleNotification(note:INotification):void {
            switch(note.getName()) {
				case ApplicationFacade.LOGIN_SUCCEED:
					handleLoginSucceed();
					break;
				case ApplicationFacade.LOGIN_FAILED:
					handleLoginFailed();
					break;
            }
        }
		
		/* Notification handlers */
		
		private function handleLoginSucceed():void {
			sendNotification(ApplicationFacade.VIEW_HOME_SCREEN);
		}
		
		private function handleLoginFailed():void {
			// TODO: Implement
		}

		/* View listeners */
		
		private function onLogin(evt:LoginEvent):void {
			sendNotification(ApplicationFacade.COMMAND_LOGIN);
		}

        protected function get loginScreen():LoginScreen {
            return viewComponent as LoginScreen;
        }
    }
}