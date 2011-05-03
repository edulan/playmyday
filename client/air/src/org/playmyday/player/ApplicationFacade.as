package org.playmyday.player
{
	import org.playmyday.player.controller.AddNewPlaylistCommand;
	import org.playmyday.player.controller.ApplicationStartupCommand;
	import org.playmyday.player.controller.GetAllPlaylistsCommand;
	import org.playmyday.player.controller.GetAllTracksCommand;
	import org.playmyday.player.controller.RemovePlaylistCommand;
	import org.puremvc.as3.patterns.facade.Facade;

    public class ApplicationFacade extends Facade
    {
		/* Application */
        public static const STARTUP:String = "startup";
		/* Notifications */
		public static const TRACK_SELECTED:String = "trackSelected";
		public static const PLAYLIST_SELECTED:String = "playlistSelected";
		public static const PLAYBACK_COMPLETED:String = "playbackCompleted";
		// playlists
		public static const GET_ALL_PLAYLISTS_SUCCEED:String = "getAllPlaylistsSucceed";
		public static const GET_ALL_PLAYLISTS_FAILED:String = "getAllPlaylistsFailed";
		public static const ADD_NEW_PLAYLIST_SUCCEED:String = "addNewPlaylistSucceed";
		public static const ADD_NEW_PLAYLIST_FAILED:String = "addNewPlaylistFailed";
		public static const REMOVE_PLAYLIST_SUCCEED:String = "removePlaylistSucceed";
		public static const REMOVE_PLAYLIST_FAILED:String = "removePlaylistFailed";
		// tracks
		public static const GET_ALL_TRACKS_SUCCEED:String = "getAllTracksSucceed";
		public static const GET_ALL_TRACKS_FAILED:String = "getAllTracksFailed";
		/* Commands */
		public static const COMMAND_GET_ALL_PLAYLISTS:String = "commandGetAllPlaylists";
		public static const COMMAND_ADD_NEW_PLAYLIST:String = "commandAddNewPlaylist";
		public static const COMMAND_REMOVE_PLAYLIST:String = "commandRemovePlaylist";
		public static const COMMAND_GET_ALL_TRACKS:String = "commandGetAllTracks";

        /**
         * Singleton ApplicationFacade Factory Method
         */
        public static function getInstance():ApplicationFacade {
            if (instance == null) {
				instance = new ApplicationFacade();
			}
            return instance as ApplicationFacade;
        }

        /**
         * Register Commands with the Controller 
         */
        override protected function initializeController():void {
            super.initializeController();
            registerCommand(STARTUP, ApplicationStartupCommand);
			registerCommand(COMMAND_GET_ALL_PLAYLISTS, GetAllPlaylistsCommand);
			registerCommand(COMMAND_ADD_NEW_PLAYLIST, AddNewPlaylistCommand);
			registerCommand(COMMAND_REMOVE_PLAYLIST, RemovePlaylistCommand);
			registerCommand(COMMAND_GET_ALL_TRACKS, GetAllTracksCommand);
        }
		
		/**
		 * Overrided method for debugging purposes only
		 */
		override public function sendNotification(notificationName:String, body:Object=null, type:String=null):void {
			trace("NOTIFICATION: " + notificationName);
			super.sendNotification(notificationName, body, type);
		}
		
		/**
		 * Start the application
		 */
		public function startup(app:PlayMyDay):void {
			sendNotification(STARTUP, app);
		}
    }
}