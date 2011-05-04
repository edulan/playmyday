package org.playmyday.player.controller
{
	import org.playmyday.player.model.LoginProxy;
	import org.playmyday.player.model.PlaylistProxy;
	import org.playmyday.player.model.TrackProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

    public class ModelPrepCommand extends SimpleCommand
    {
        override public function execute(note:INotification):void {
			facade.registerProxy(new LoginProxy());
			facade.registerProxy(new PlaylistProxy());
			facade.registerProxy(new TrackProxy());
        }
    }
}