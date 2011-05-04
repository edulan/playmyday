package org.playmyday.player.controller
{
	import org.playmyday.player.model.TrackProxy;
	import org.playmyday.player.model.vo.PlaylistVO;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class GetAllTracksCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void {
			var trackProxy:TrackProxy = facade.retrieveProxy(TrackProxy.NAME) as TrackProxy;
			
			trackProxy.getAllTracks(notification.getBody() as PlaylistVO);
		}
	}
}