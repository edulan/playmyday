package org.playmyday.player.model
{
	import org.playmyday.player.ApplicationFacade;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class LoginProxy extends Proxy
	{
		public static const NAME:String = "LoginProxy";
		
		public function LoginProxy(data:Object=null) {
			super(NAME, data);
		}
		
		public function login():void {
			sendNotification(ApplicationFacade.LOGIN_SUCCEED);
		}
		
		public function logout():void {
			sendNotification(ApplicationFacade.LOGOUT_SUCCEED);
		}
	}
}