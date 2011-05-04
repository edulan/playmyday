package org.playmyday.player.view
{
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
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

		private var _sound:Sound;						// Mp3 File
		private var _soundChannel:SoundChannel;			// Reference to playing channel
		private var _soundTransform:SoundTransform;		// Sound transformation to manage volume
		private var _currentPosition:Number;			// Current play position (time)
		private var _percent:Number;					// Current played percentage
		private var _isPlaying:Boolean;					// Is the mp3 playing?
		private var _isLoaded:Boolean;					// Is the mp3 loaded?
		private var _updateTimer:Timer;					// Timer for updating the seek bar
		private var _currentTrack:TrackVO;				// Reference to the current track
		private var _isCurrentSelected:Boolean;
		
		public function ControlsMediator(viewComponent:ControlsComponent) {
			_isLoaded = false;
			_isPlaying = false;
			_isCurrentSelected = false;
			_currentPosition = 0;
			_currentTrack = new TrackVO();
			_updateTimer = new Timer(UPDATE_INTERVAL);
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void {
			// Setup listeners
			controlsComponent.addEventListener(ControlEvent.PLAY, onPlay);
			controlsComponent.addEventListener(ControlEvent.SEEK, onSeek);
			controlsComponent.addEventListener(ControlEvent.CHANGE_VOLUME, onChangeVolume);
			_updateTimer.addEventListener(TimerEvent.TIMER, onTimer);
			// View initialization
			controlsComponent.volume = INITIAL_VOLUME;
			controlsComponent.isSongLoaded = true;
		}

		override public function listNotificationInterests():Array {
			return [
						ApplicationFacade.TRACK_SELECTED,
						ApplicationFacade.GET_TRACK_URL_SUCCEED,
						ApplicationFacade.GET_TRACK_URL_FAILED
					];
		}
		
		override public function handleNotification(note:INotification):void {
			switch(note.getName()) {
				case ApplicationFacade.TRACK_SELECTED:
					handleTrackSelected(note.getBody() as TrackVO);
					break;
				case ApplicationFacade.GET_TRACK_URL_SUCCEED:
					handleGetTrackUrlSucceed(note.getBody() as Object);
					break;
				case ApplicationFacade.GET_TRACK_URL_FAILED:
					handleGetTrackUrlFailed();
					break;
			}
		}
		
		/* Notification handlers */
		
		private function handleTrackSelected(track:TrackVO):void {
			_isCurrentSelected = (_currentTrack.id == track.id);
			_currentTrack = track;
			sendNotification(ApplicationFacade.COMMAND_GET_TRACK_URL, track);
		}
		
		private function handleGetTrackUrlSucceed(data:Object):void {
			if(_isPlaying) {
				_isPlaying = false;
				_currentPosition = 0;
				_soundChannel.stop();
				_updateTimer.stop();
				_soundChannel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			}
			
			// TODO: Revise
			if (!_isCurrentSelected) {
				if (_sound) {
					try {
						_sound.removeEventListener(Event.OPEN, onOpen);
						_sound.removeEventListener(Event.COMPLETE, onComplete);
						_sound.removeEventListener(ProgressEvent.PROGRESS, onProgress);
						_sound.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
						_sound.close();
					} catch (ioError:IOError) {
						trace("Exception");
					}
				}
			
				_sound = new Sound();
				_sound.addEventListener(Event.OPEN, onOpen);
				_sound.addEventListener(Event.COMPLETE, onComplete);
				_sound.addEventListener(ProgressEvent.PROGRESS, onProgress);
				_sound.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
				_sound.load(new URLRequest(data.songs.song.path));
				_soundTransform = new SoundTransform(controlsComponent.volume, 0);
			} else {
				playPause();
			}
		}
		
		private function handleGetTrackUrlFailed():void {
			// TODO: Implement
		}
		
		/* View listeners */
		
		private function onPlay(evt:ControlEvent):void {
			playPause();
		}
		
		private function onSeek(evt:ControlEvent):void {
			_currentPosition = (controlsComponent.seekBar.contentMouseX/controlsComponent.seekBar.width)*_sound.length;
			
			if (_isPlaying) {
				_soundChannel.stop();
				_soundChannel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
				_soundChannel = _sound.play(_currentPosition);
				_soundChannel.soundTransform = _soundTransform;
				_soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			}
		}
		
		private function onChangeVolume(evt:ControlEvent):void {
			_soundTransform = new SoundTransform(controlsComponent.volume, 0);
			if(_soundChannel)
				_soundChannel.soundTransform = _soundTransform;
		}
		
		private function onSoundComplete(evt:Event):void {
			_updateTimer.stop();
			sendNotification(ApplicationFacade.PLAYBACK_COMPLETED, _currentTrack);
		}
		
		private function onOpen(evt:Event):void {
			playPause();
		}
		
		private function onComplete(evt:Event):void {
			enableSeek();
			_isLoaded = true;
		}
		
		private function onProgress(evt:ProgressEvent):void {
			// TODO: Implement
			trace("PROGRESS: " + evt.bytesLoaded);
		}
		
		private function onIOError(evt:IOErrorEvent):void {
			var invalidSound:Sound = evt.currentTarget as Sound;
			// Remove invalid sound object listeners
			invalidSound.removeEventListener(Event.OPEN, onOpen);
			invalidSound.removeEventListener(Event.COMPLETE, onComplete);
			invalidSound.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			invalidSound.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
		}

		private function onTimer(e:Event):void {
			if(_isPlaying) {
				// If the position is beyond the song start, calculate & set the percentage
				_percent = _soundChannel.position > 0 ? (_soundChannel.position/_sound.length)*100 : 0;
				controlsComponent.seekBar.setProgress(_percent,100);
				
				// Tell the seekbar to redraw itself
				controlsComponent.seekBar.validateNow();
			}
		}
		
		/* Helpers */

		public function enableSeek():void {
			controlsComponent.seekBar.enabled = true;
			controlsComponent.seekBar.visible = true;
		}

		private function playPause():void  {
			if(_isPlaying) {
				_currentPosition = _soundChannel.position;
				_soundChannel.stop();
				_updateTimer.stop();
				_soundChannel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			} else {
				_soundChannel = _sound.play(_currentPosition);
				_soundChannel.soundTransform = _soundTransform;
				_soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
				_updateTimer.start();
			}
			_isPlaying = !_isPlaying;
		}
		
		protected function get controlsComponent():ControlsComponent {
			return viewComponent as ControlsComponent;
		}
	}
}