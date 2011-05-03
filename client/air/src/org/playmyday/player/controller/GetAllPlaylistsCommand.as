package org.playmyday.player.controller
{
	import org.playmyday.player.model.PlaylistProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class GetAllPlaylistsCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void {
			var playlistProxy:PlaylistProxy = facade.retrieveProxy(PlaylistProxy.NAME) as PlaylistProxy;
			
			playlistProxy.getAllPlaylists();
		}
	}
}