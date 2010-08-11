package org.playmyday.player
{
	import org.playmyday.player.controller.ApplicationStartupCommand;
	import org.puremvc.as3.patterns.facade.Facade;

    public class ApplicationFacade extends Facade
    {
		/* Application */
        public static const STARTUP:String 					= "startup";
		
		/* View */
		public static const PLAY:String 					= "play";				// dispatched when a track is being played
		public static const PLAYLIST_ADDED:String			= "playlistAdded";
		public static const PLAYLIST_SELECTED:String		= "playlistSelected";

        /**
         * Singleton ApplicationFacade Factory Method
         */
        public static function getInstance():ApplicationFacade {
            if ( instance == null )
				instance = new ApplicationFacade();
            return instance as ApplicationFacade;
        }

        /**
         * Register Commands with the Controller 
         */
        override protected function initializeController():void {
            super.initializeController();
            registerCommand(STARTUP, ApplicationStartupCommand);
        }
		
		/**
		 * Start the application
		 */
		public function startup(app:PlayMyDay):void {
			sendNotification(STARTUP, app);
		}
		
    }
}