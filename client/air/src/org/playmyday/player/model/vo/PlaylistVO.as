package org.playmyday.player.model.vo
{
	[Bindable]
	public class PlaylistVO
	{
		public var name:String;
		public var tracks:Array;
		
		public function PlaylistVO(name:String=null, tracks:Array=null) {
			this.name = name;
			this.tracks = tracks;
		}
	}
}