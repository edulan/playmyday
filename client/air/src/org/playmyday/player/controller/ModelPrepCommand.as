package org.playmyday.player.controller
{
	import org.playmyday.player.model.PlaylistProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

    public class ModelPrepCommand extends SimpleCommand
    {
        override public function execute(note:INotification):void {
			facade.registerProxy(new PlaylistProxy(PlaylistProxy.NAME));
        }
    }
}