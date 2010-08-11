package org.playmyday.player.view
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	import org.playmyday.player.ApplicationFacade;
	import org.playmyday.player.model.events.ControlEvent;
	import org.playmyday.player.model.vo.TrackVO;
	import org.playmyday.player.view.components.ControlsComponent;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class ControlsMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "ControlsMediator";
		
		private static const INITIAL_VOLUME:Number = 0.30;
		private static const UPDATE_INTERVAL:Number = 500;	// ms

		private var sound:Sound;						// Mp3 File
		private var soundChannel:SoundChannel;			// Reference to playing channel
		private var soundTransform:SoundTransform;
		private var currentPosition:Number;				// Current play position (time)
		private var percent:Number;						// Current played percentage
		private var isPlaying:Boolean;					// Is the mp3 playing?
		private var isLoaded:Boolean;					// Is the mp3 loaded?
		private var updateSeek:Timer;					// Timer for updating the seek bar
		private var trackVO:TrackVO;
		
		public function ControlsMediator(viewComponent:ControlsComponent) {
			super(NAME, viewComponent);
			isPlaying = false;
			isLoaded = false;
			updateSeek = new Timer(UPDATE_INTERVAL);
		}
		
		override public function onRegister():void {
			// listeners
			controlsComponent.addEventListener(ControlEvent.PLAY, onPlay);
			controlsComponent.addEventListener(ControlEvent.SEEK, onSeek);
			controlsComponent.addEventListener(ControlEvent.CHANGE_VOLUME, onChangeVolume);
			// view initialization
			controlsComponent.volume = INITIAL_VOLUME;
			// Add event listener for seek bar updater & start timer							
			//updateSeek.addEventListener(TimerEvent.TIMER, onUpdate);
			//updateSeek.start();
		}

		override public function listNotificationInterests():Array {
			return [ApplicationFacade.PLAY];
		}
		
		override public function handleNotification(note:INotification):void {
			switch(note.getName()) {
				case ApplicationFacade.PLAY:
					var vo:TrackVO = note.getBody() as TrackVO;

					if(isPlaying) {
						soundChannel.stop();
					}

					// data initialization
					trackVO = vo;
					isPlaying = false;
					currentPosition = 0;
					// gui update
					controlsComponent.isSongLoaded = true;
					
					playPause();
					break;
			}
		}

		public function enableSeek():void {
			controlsComponent.seekBar.enabled = true;
			controlsComponent.seekBar.visible = true;
		}

		private function playPause():void  {
			if(isPlaying) {
				currentPosition = soundChannel.position;
				soundChannel.stop();
			} else {
				sound = new Sound();
				soundTransform = new SoundTransform(controlsComponent.volume, 0);

				sound.addEventListener(ProgressEvent.PROGRESS, onSongProgress);
				sound.addEventListener(Event.COMPLETE, onSongLoaded);
				sound.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
				sound.load(new URLRequest(trackVO.url));

				soundChannel = sound.play(currentPosition);
				soundChannel.soundTransform = soundTransform;
			}
			isPlaying = !isPlaying;
		}
		
		private function onPlay(evt:ControlEvent):void {
			if(isPlaying) {
				currentPosition = soundChannel.position;
				soundChannel.stop();
			} else {
				soundChannel = sound.play(currentPosition);
				soundChannel.soundTransform = soundTransform;
			}
			isPlaying = !isPlaying;
		}

		private function onSongLoaded(evt:Event):void {
			sound.removeEventListener(Event.COMPLETE, onSongLoaded);

			enableSeek();
			isLoaded = true;
		}
		
		private function onChangeVolume(evt:ControlEvent):void {
			soundTransform = new SoundTransform(controlsComponent.volume, 0);
			if(soundChannel)
				soundChannel.soundTransform = soundTransform;
		}
		
		private function onSongProgress(evt:ProgressEvent):void {

		}
		
		private function onIOError(evt:IOErrorEvent):void {
			
		}

		private function onUpdate(e:Event):void {
			// Is a song playing?
			//if(isPlaying && isLoaded) {
			if(isPlaying) {
				// If the position is beyond the song start, calculate & set the percentage
				percent = soundChannel.position > 0 ? (soundChannel.position/sound.length)*100 : 0;
				controlsComponent.seekBar.setProgress(percent,100);
				
				// Tell the seekbar to redraw itself
				controlsComponent.seekBar.validateNow();
			}
		}

		private function onSeek(evt:MouseEvent):void {
			// Is the song playing AND is the seekbar enabled and visible?
			if(isPlaying) { 
				// Stop playing at current position, change to new location, continue playing
				soundChannel.stop();
				currentPosition = (controlsComponent.seekBar.contentMouseX/controlsComponent.seekBar.width)*sound.length;
				soundChannel = sound.play(currentPosition);
			}
		}
		
		protected function get controlsComponent():ControlsComponent {
			return viewComponent as ControlsComponent;
		}
	}
}