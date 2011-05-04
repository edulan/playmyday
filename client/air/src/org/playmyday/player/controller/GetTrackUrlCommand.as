package org.playmyday.player.controller
{
	import org.playmyday.player.model.TrackProxy;
	import org.playmyday.player.model.vo.TrackVO;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class GetTrackUrlCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void {
			var trackProxy:TrackProxy = facade.retrieveProxy(TrackProxy.NAME) as TrackProxy;
			
			trackProxy.getTrackUrl(notification.getBody() as TrackVO);
		}
	}
}