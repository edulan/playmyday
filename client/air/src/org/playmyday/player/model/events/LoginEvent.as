package org.playmyday.player.model.events
{
	import flash.events.Event;
	
	public class LoginEvent extends Event
	{
		public static const LOGIN:String = "login";
		public static const LOGOUT:String = "logout";
		
		public function LoginEvent(type:String) {
			super(type, true, false);
		}
	}
}