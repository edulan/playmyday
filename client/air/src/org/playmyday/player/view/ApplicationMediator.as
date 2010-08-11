package org.playmyday.player.view
{
	import org.playmyday.player.ApplicationFacade;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

    public class ApplicationMediator extends Mediator implements IMediator
    {
        // Cannonical name of the Mediator
        public static const NAME:String = "ApplicationMediator";
        
		// available values for the main viewstack
		// defined as contants to help uncover errors at compile time instead of run time
		public static const SPLASH_SCREEN : Number 	=	1;
		public static const MAIN_SCREEN : Number 	=	2;

        public function ApplicationMediator(viewComponent:PlayMyDay) {
            super(NAME, viewComponent);
		}

        override public function onRegister():void { 
			facade.registerMediator(new ControlsMediator(app.controls));
			facade.registerMediator(new TracklistMediator(app.tracklist));
			facade.registerMediator(new PlaylistsMediator(app.playlists));
			facade.registerMediator(new TrackInfoMediator(app.info));
        }

        override public function listNotificationInterests():Array {
            return [];
        }

        override public function handleNotification(note:INotification):void {
            switch(note.getName()) {

            }
        }

        protected function get app():PlayMyDay {
            return viewComponent as PlayMyDay;
        }
    }
}