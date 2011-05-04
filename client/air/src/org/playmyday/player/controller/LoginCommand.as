package org.playmyday.player.controller
{
	import org.playmyday.player.model.LoginProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class LoginCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void {
			var loginProxy:LoginProxy = facade.retrieveProxy(LoginProxy.NAME) as LoginProxy;
			
			loginProxy.login();
		}
	}
}