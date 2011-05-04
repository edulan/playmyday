package org.playmyday.player.controller
{
	import org.playmyday.player.model.TrackProxy;
	import org.playmyday.player.model.vo.PlaylistVO;
	import org.playmyday.player.model.vo.TrackVO;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class AddTrackCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void {
			var trackProxy:TrackProxy = facade.retrieveProxy(TrackProxy.NAME) as TrackProxy;
			var playlist:PlaylistVO = notification.getBody().playlist;
			var track:TrackVO = notification.getBody().track;
			
			trackProxy.addTrackToPlaylist(playlist, track);
		}
	}
}