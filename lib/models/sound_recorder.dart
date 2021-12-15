 import 'dart:async';

import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';
 import 'package:intl/intl.dart' show DateFormat;



const  pathToSaveAudio = 'audio_file.aac';
class SoundRecorder{

   FlutterSoundRecorder? audioRecorder;
   bool _isRecorderInitialized = false;
   bool ismPlayerReady = false;
   StreamSubscription? _recordSubcription;

   bool get isRecording => audioRecorder!.isRecording;

  Future init() async{
   audioRecorder = FlutterSoundRecorder();
   var status = await Permission.microphone.request();
   if (status != PermissionStatus.granted) {
    throw RecordingPermissionException('Microphone permission not granted');
   }

   await audioRecorder!.openAudioSession();

   _isRecorderInitialized = true;

  }

  void dispose(){
   if (!_isRecorderInitialized) return;


   audioRecorder!.closeAudioSession();
   audioRecorder = null;
   _isRecorderInitialized = false;
  }


  Future _record() async{
   if (!_isRecorderInitialized) return;
   await audioRecorder!.startRecorder(toFile: pathToSaveAudio);


  }


  Future _stop() async{
   if (!_isRecorderInitialized) return;
   await audioRecorder!.stopRecorder();
   ismPlayerReady = true;

  }

  Future toggleRecording() async{
   if (audioRecorder!.isStopped) {
    await _record();
   }else{
    await _stop();
   }
  }

  Stream<String> recordProgress() {
    var txt;

    _recordSubcription = audioRecorder!.onProgress!.listen((e) {
      var date = DateTime.fromMillisecondsSinceEpoch(
          e.duration.inMilliseconds,
          isUtc: true);

       txt = DateFormat('mm:ss:SS', 'en_GB').format(date);



    });

    return txt;





  }


 }