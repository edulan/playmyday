package org.playmyday.player.model
{
	import mx.collections.ArrayCollection;
	
	import org.playmyday.player.model.vo.TrackVO;

	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class TrackProxy extends Proxy
	{
		public static const NAME:String = "TrackProxy";
		
		public function TrackProxy(data:Object=null) {
			super(NAME, data);
		}
	}
}