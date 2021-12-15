import 'package:flutter_sound/public/flutter_sound_player.dart';
const  pathToSaveAudio = 'audio_file.aac';
class SoundPlayer{
  FlutterSoundPlayer? playerModule;
  bool _isPlayerInitialized = false;
  bool isPlaybackReady = false;

  bool get isPlaying => playerModule!.isPlaying;

  Future init() async{
    playerModule = FlutterSoundPlayer();
    await playerModule!.openAudioSession();
    //await playerModule!.setSubscriptionDuration(Duration(milliseconds: 100));

    _isPlayerInitialized = true;

  }

  void play() {
    if (!_isPlayerInitialized) return;
    /*assert(_mPlayerIsInited &&
        _mplaybackReady &&
        _mRecorder!.isStopped &&
        _mPlayer!.isStopped);*/
    playerModule!
        .startPlayer(
        fromURI: pathToSaveAudio,);


  }

  void stopPlayer() {
    if (!_isPlayerInitialized) return;
    playerModule!.stopPlayer();
  }

 void togglePlayer() {
    if (playerModule!.isStopped) {
       play();
    }else{
      stopPlayer();
    }
  }

}