package org.playmyday.player.model
{
	import mx.collections.ArrayCollection;
	
	import org.playmyday.player.ApplicationFacade;
	import org.playmyday.player.model.vo.TrackVO;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class TrackProxy extends Proxy
	{
		public static const NAME:String = "TrackProxy";
		
		public function TrackProxy(data:Object=null) {
			// Mock data
			var t1:TrackVO = new TrackVO();
			var t2:TrackVO = new TrackVO();
			var t3:TrackVO = new TrackVO();
			var t4:TrackVO = new TrackVO();
			
			t1.title =  "Pogo";
			t1.artist = "Digitalism";
			t1.album =  "Idealism";
			t1.time =   "3:46";
			t1.url =    "http://live1.goear.com/listen/d33f778e1e95a868e7ef0a6d7d98cb97/4dbf43fc/sst4/mp3files/20082007/c0526dd6e8c4c779332b59d9b9a683e4.mp3";
			t1.thumbnail =	null;//"http://ec1.images-amazon.com/images/P/B0002Z61B0.01.MZZZZZZZ.jpg";
			t2.title =  "Undercover Martyn";
			t2.artist = "Two Door Cinema Club";
			t2.album =  "Tourist History";
			t2.time =   "2:47";
			t2.url =    "http://live3.goear.com/listen/337dfee699d0790fa3d35f329dd49048/4dbf43e2/sst5/mp3files/15032010/848c3928146b803974c366ee8fa2f70f.mp3";
			t2.thumbnail =	null;//"http://ec1.images-amazon.com/images/P/B0030W1LDA.09.MZZZZZZZ.jpg";
			t3.title =  "Un buen día";
			t3.artist = "Los Planetas";
			t3.album =  "Unidad de desplazamiento";
			t3.time =   "3:50";
			t3.url =    "http://www.goear.com/files/sst4/mp3files/04072007/6e92d8e370761187d300600ee4834ce4.mp3";
			t3.thumbnail =	null;
			t4.title =	"Memories";
			t4.artist = "David Guetta";
			t4.album = 	"Memories";
			t4.time =	"3:31";
			t4.url =	"http://www.goear.com/files/sst5/mp3files/24082009/64cf48af0539a91e70f53748b00c7602.mp3";
			t4.thumbnail =	null;
			
			data = new ArrayCollection([t1, t2, t3, t4]);
			super(NAME, data);
		}
		
		public function getAllTracks(playlistId:uint):void {
			// Mock logic
			if (playlistId == 1) {
				sendNotification(ApplicationFacade.GET_ALL_TRACKS_SUCCEED, tracks);
			} else {
				sendNotification(ApplicationFacade.GET_ALL_TRACKS_SUCCEED, new ArrayCollection());
			}
		}
		
		protected function get tracks():ArrayCollection {
			return data as ArrayCollection;
		}
	}
}