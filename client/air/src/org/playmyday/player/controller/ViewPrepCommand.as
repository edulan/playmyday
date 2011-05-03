package org.playmyday.player.controller
{
	import org.playmyday.player.view.ApplicationMediator;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

    public class ViewPrepCommand extends SimpleCommand
    {
        override public function execute(note:INotification):void {
            facade.registerMediator(new ApplicationMediator(note.getBody() as PlayMyDay));
        }
    }
}
