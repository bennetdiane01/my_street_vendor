import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:gap/gap.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:my_street_vendor/models/sound_player.dart';
import 'package:my_street_vendor/models/sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart' show DateFormat;

import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';

typedef _Fn = void Function();

const theSource = AudioSource.microphone;
const pathToSaveAudio = 'audio_file.aac';

class SimpleRecorder extends StatefulWidget {
  SimpleRecorder({Key? key}) : super(key: key);

  @override
  _SimpleRecorderState createState() => _SimpleRecorderState();
}

class _SimpleRecorderState extends State<SimpleRecorder> {
  final recorder = SoundRecorder();
  final mPlayer = SoundPlayer();
  StreamSubscription? _recorderSubscription;
  StreamSubscription? _playerSubscription;
  double maxDuration = 1.0;
  double sliderCurrentPosition = 0.0;
  double? _duration;

  String _recorderTxt = '00:00:00';
  String _playerTxt = '00:00:00';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeDateFormatting();

    recorder.init();
    mPlayer.init();
  }

  void cancelRecorderSubscriptions() {
    if (_recorderSubscription != null) {
      _recorderSubscription!.cancel();
      _recorderSubscription = null;
    }
  }

  void cancelPlayerSubscriptions() {
    if (_playerSubscription != null) {
      _playerSubscription!.cancel();
      _playerSubscription = null;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    recorder.dispose();
    cancelRecorderSubscriptions();
    cancelPlayerSubscriptions();
  }

  void play() {
    /*assert(_mPlayerIsInited &&
        _mplaybackReady &&
        _mRecorder!.isStopped &&
        _mPlayer!.isStopped);*/

    mPlayer.playerModule!
        .startPlayer(
            fromURI: pathToSaveAudio,
            whenFinished: () {
              setState(() {});
            })
        .then((value) {
      setState(() {});
      _playerSubscription = mPlayer.playerModule!.onProgress!.listen((e) {
        maxDuration = e.duration.inMilliseconds.toDouble();
        if (maxDuration <= 0) maxDuration = 0.0;

        sliderCurrentPosition =
            min(e.position.inMilliseconds.toDouble(), maxDuration);
        if (sliderCurrentPosition < 0.0) {
          sliderCurrentPosition = 0.0;
        }

        var date = DateTime.fromMillisecondsSinceEpoch(
            e.position.inMilliseconds,
            isUtc: true);
        var txt = DateFormat('mm:ss:SS', 'en_GB').format(date);
        setState(() {
          _playerTxt = txt.substring(0, 8);
        });

        debugPrint(_playerTxt);
      });
    });
  }

  Future<void> seekToPlayer(int milliSecs) async {
    //playerModule.logger.d('-->seekToPlayer');
    try {
      if (mPlayer.playerModule!.isPlaying) {
        await mPlayer.playerModule!
            .seekToPlayer(Duration(milliseconds: milliSecs));
      }
    } on Exception catch (err) {
      mPlayer.playerModule!.logger.e('error: $err');
    }
    setState(() {});
    //playerModule.logger.d('<--seekToPlayer');
  }

  @override
  Widget build(BuildContext context) {
    bool _isRecording = recorder.isRecording;
    bool _isPlaying = mPlayer.isPlaying;
    Widget makeBody() {
      return Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 12.0, bottom: 16.0),
              child: Text(
                _isPlaying ? _playerTxt : _recorderTxt,
                style: TextStyle(
                  fontSize: 35.0,
                  color: Colors.black,
                ),
              ),
            ),
            Gap(10),
            !_isRecording
                ? Container(
                    height: 30.0,
                    child: Slider(
                        value: min(sliderCurrentPosition, maxDuration),
                        min: 0.0,
                        max: maxDuration,
                        onChanged: (value) async {
                          await seekToPlayer(value.toInt());
                        },
                        divisions:
                            maxDuration == 0.0 ? 1 : maxDuration.toInt()))
                : SizedBox.shrink(),
            Gap(30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                onPrimary: _isRecording ? Colors.white : Colors.black,
                primary: _isRecording ? Colors.red : Colors.white,
              ),
              child: SizedBox(
                width: 80,
                child: Row(
                  children: [
                    Icon(_isRecording ? Icons.stop : Icons.mic),
                    const Gap(10),
                    Text(_isRecording ? 'STOP' : 'START'),
                  ],
                ),
              ),
              onPressed: () async {

                if (_isPlaying) {
                  return;

                }
                await recorder.toggleRecording();
                setState(() {});
                if (recorder.isRecording) {
                  recorder.audioRecorder!
                      .setSubscriptionDuration(Duration(milliseconds: 10));
                  _recorderSubscription =
                      recorder.audioRecorder!.onProgress?.listen((e) {
                    var date = DateTime.fromMillisecondsSinceEpoch(
                        e.duration.inMilliseconds,
                        isUtc: true);

                    var txt = DateFormat('mm:ss:SS', 'en_GB').format(date);

                    setState(() {
                      _recorderTxt = txt.substring(0, 8);
                      //_dbLevel = e.decibels;
                    });
                  });
                }
              },
            ),
            Gap(10),
            ElevatedButton(
                onPressed: () async {
                  //mPlayer.togglePlayer();
                  if (!recorder.ismPlayerReady) {
                    return;
                  }

                  play();
                  mPlayer.playerModule!
                      .setSubscriptionDuration(Duration(milliseconds: 10));
                },
                child: SizedBox(
                  width: 80,
                  child: Row(
                    children: [
                      Icon(_isPlaying ? Icons.stop : Icons.play_arrow),
                      const Gap(10),
                      Text(_isPlaying ? 'STOP' : 'PLAY'),
                    ],
                  ),
                ))


          ],
        ),
      );
    }

    return  makeBody();

  }
}
