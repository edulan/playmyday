package org.playmyday.player.model
{
	import mx.collections.ArrayCollection;
	
	import org.playmyday.player.model.vo.PlaylistVO;
	import org.playmyday.player.model.vo.TrackVO;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class PlaylistProxy extends Proxy
	{
		public static const NAME:String = "PlaylistProxy";
		
		public function PlaylistProxy(data:Object=null) {
			super(NAME, data);
		}
		
		public function getPlaylists():ArrayCollection {
			var t1:TrackVO = new TrackVO();
			var t2:TrackVO = new TrackVO();
			var t3:TrackVO = new TrackVO();
			var t4:TrackVO = new TrackVO();

			t1.title =  "No ardieras";
			t1.artist = "Los Planetas";
			t1.album =  "Los Planetas contra la ley de la gravedad";
			t1.time =   "3:17";
			t1.url =    "http://www.goear.com/files/sst5/mp3files/05112008/41ea98d7896f6942f1f90687c6cf6fbd.mp3";
			t1.image =	"http://ec1.images-amazon.com/images/P/B0002Z61B0.01.MZZZZZZZ.jpg";
			t2.title =  "Anuncio para coches";
			t2.artist = "Los Planetas";
			t2.album =  "Unidad de desplazamiento";
			t2.time =   "3:25";
			t2.url =    "http://www.goear.com/files/sst5/mp3files/05112008/65b4f39b23a202db7d369c1736a59f34.mp3";
			t2.image =	null;
			t3.title =  "Un buen día";
			t3.artist = "Los Planetas";
			t3.album =  "Unidad de desplazamiento";
			t3.time =   "3:50";
			t3.url =    "http://www.goear.com/files/sst4/mp3files/04072007/6e92d8e370761187d300600ee4834ce4.mp3";
			t3.image =	null;
			t4.title =	"Memories";
			t4.artist = "David Guetta";
			t4.album = 	"Memories";
			t4.time =	"3:31";
			t4.url =	"http://www.goear.com/files/sst5/mp3files/24082009/64cf48af0539a91e70f53748b00c7602.mp3";
			t4.image =	null;
			
			return new ArrayCollection([new PlaylistVO("Los Planetas", [t1, t2, t3, t4])]);
		}
	}
}