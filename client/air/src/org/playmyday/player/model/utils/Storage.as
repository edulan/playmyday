package org.playmyday.player.model.utils
{
	import org.playmyday.player.model.vo.PlaylistVO;
	import org.playmyday.player.model.vo.TrackVO;

	public class Storage
	{
		private static var _instance:Storage;
		// Hash storage
		private var _map:Object;
		
		public function Storage() {
			_map = {};
			initialize();
		}
		
		public static function get instance():Storage {
			if (_instance == null) {
				_instance = new Storage();
			}
			return _instance;
		}
		
		public function getAllPlaylists():Array {
			var playlists:Array = [];
			
			for each (var data:Object in _map) {
				playlists.push(data.playlist);
			}
			return playlists;
		}
		
		public function getPlaylist(name:String):Object {
			return _map[name].playlist;
		}
		
		public function createPlaylist(name:String, data:Object):void {
			_map[name] = { playlist:data };
		}
		
		public function removePlaylist(name:String):void {
			_map[name] = undefined;
		}
		
		public function getPlaylistTracks(name:String):Array {
			if (_map[name]) {
				var tracks:Array = [];
				
				for each (var data:Object in _map[name].tracks) {
					tracks.push(data.track);
				}
				return tracks;
			}
			return null;
		}
		
		public function createPlaylistTrack(name:String, data:Object):void {
			if (_map[name]) {
				if (_map[name].tracks) {
					_map[name].tracks.push({ track:data });
				} else {
					_map[name].tracks = [{ track:data }];
				}
			}
		}
		
		private function initialize():void {
			/* Playlists */
			var p1:PlaylistVO =  new PlaylistVO();
			
			p1.id = 1;
			p1.name = "De andar por casa en zapatillas";
			
			createPlaylist(p1.name, p1);
			
			/* Tracks */
			var t1:TrackVO = new TrackVO();
			var t2:TrackVO = new TrackVO();
			var t3:TrackVO = new TrackVO();
			
			t1.id =			1;
			t1.goearId =	"0578a68";
			t1.title =  	"Pogo";
			t1.artist = 	"Digitalism";
			t1.album =  	"Idealism";
			t1.time =   	"3:46";
			t1.url =    	"http://live3.goear.com/listen/7313da4b4faeab4aaf0f568846e385e0/4dc013e1/sst3/mp3files/11052007/9f810e1b8374bb8757d29df4fc7f8d84.mp3";
			t1.thumbnail =	"http://ec1.images-amazon.com/images/P/B0002Z61B0.01.MZZZZZZZ.jpg";
			t2.id =			2;
			t2.goearId =	"9ffd548";
			t2.title =  	"Undercover Martyn";
			t2.artist = 	"Two Door Cinema Club";
			t2.album =  	"Tourist History";
			t2.time =   	"2:47";
			t2.url =    	"http://live3.goear.com/listen/97c434f071c220fe3bf6ec5c1d5a5ff0/4dc0144d/sst5/mp3files/15032010/848c3928146b803974c366ee8fa2f70f.mp3";
			t2.thumbnail =	"http://ec1.images-amazon.com/images/P/B0030W1LDA.09.MZZZZZZZ.jpg";
			t3.id =			3;
			t3.goearId =	"d809f75";
			t3.title =  	"Un buen día";
			t3.artist = 	"Los Planetas";
			t3.album =  	"Unidad de desplazamiento";
			t3.time =   	"3:50";
			t3.url =    	"http://live3.goear.com/listen/5084c89614e29e80106cfb06695bf2f1/4dbfef3f/sst/mp3files/15092006/ed038ead918917c469d03ede0d95e947.mp3";
			t3.thumbnail =	null;
			
			createPlaylistTrack(p1.name, t1);
			createPlaylistTrack(p1.name, t2);
			createPlaylistTrack(p1.name, t3);
		}
	}
}