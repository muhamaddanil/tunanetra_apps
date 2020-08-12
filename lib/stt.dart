import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
// import 'package:flutter_tts/flutter_tts_web.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

// void main() => runApp(SpeechtoText());

class SpeechtoText extends StatefulWidget {
  @override
  _SpeechtoTextState createState() => _SpeechtoTextState();
}
enum TtsState { playing, stopped, paused, continued }
class _SpeechtoTextState extends State<SpeechtoText> {
  bool _hasSpeech = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = "";
  String lastError = "";
  String lastStatus = "";
  String _currentLocaleId = "in_ID";
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();
  String image = '';

  @override
  void initState() {
    super.initState();
    
  }

  Future<void> initSpeechState() async {
    print(speech.isListening);
    bool hasSpeech = await speech.initialize(
        onError: errorListener, onStatus: statusListener);
    if (hasSpeech) {
      _localeNames = await speech.locales();

      var systemLocale = await speech.systemLocale();
      _currentLocaleId = systemLocale.localeId;
    }

    if (!mounted) return;

    setState(() {
      _hasSpeech = hasSpeech;
    });
    
    startListening();
  }

  ///tts
  ///
  FlutterTts flutterTts;
  dynamic languages;
  String language;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;

  String _newVoiceText;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;

  get isStopped => ttsState == TtsState.stopped;

  get isPaused => ttsState == TtsState.paused;

  get isContinued => ttsState == TtsState.continued;

   initTts() {
    flutterTts = FlutterTts();

    // _getLanguages();

    if (!kIsWeb) {
      if (Platform.isAndroid) {
        _getEngines();
      }
    }

    flutterTts.setStartHandler(() {
      setState(() {
        print("Playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        print("Cancel");
        ttsState = TtsState.stopped;
      });
    });

    if (kIsWeb || Platform.isIOS) {
      flutterTts.setPauseHandler(() {
        setState(() {
          print("Paused");
          ttsState = TtsState.paused;
        });
      });

      flutterTts.setContinueHandler(() {
        setState(() {
          print("Continued");
          ttsState = TtsState.continued;
        });
      });
    }

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }
  Future _getEngines() async {
    var engines = await flutterTts.getEngines;
    if (engines != null) {
      for (dynamic engine in engines) {
        print(engine);
      }
    }
  }
  Future _speak() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (_newVoiceText != null) {
      if (_newVoiceText.isNotEmpty) {
        var result = await flutterTts.speak(_newVoiceText);
        if (result == 1) setState(() => ttsState = TtsState.playing);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Asisten Wisata'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Column(children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            color: Theme.of(context).backgroundColor,
            child: Center(
              child: speech.isListening
                  ? Text(
                      "I'm listening...",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  : Text(
                      'Not listening',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
            ),
          ),
          // Center(
          //   child: Text(
          //     'Speech recognition available',
          //     style: TextStyle(fontSize: 22.0),
          //   ),
          // ),
          // Container(
          //   child: Column(
          //     children: <Widget>[
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
          //         children: <Widget>[
          //           FlatButton(
          //             child: Text('Initialize'),
          //             onPressed: _hasSpeech ? null : initSpeechState,
          //           ),
          //         ],
          //       ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
          //         children: <Widget>[
          //           FlatButton(
          //             child: Text('Start'),
          //             onPressed: !_hasSpeech || speech.isListening
          //                 ? null
          //                 : startListening,
          //           ),
          //           FlatButton(
          //             child: Text('Stop'),
          //             onPressed: speech.isListening ? stopListening : null,
          //           ),
          //           FlatButton(
          //             child: Text('Cancel'),
          //             onPressed: speech.isListening ? cancelListening : null,
          //           ),
          //         ],
          //       ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
          //         children: <Widget>[
          //           DropdownButton(
          //             onChanged: (selectedVal) => _switchLang(selectedVal),
          //             value: _currentLocaleId,
          //             items: _localeNames
          //                 .map(
          //                   (localeName) => DropdownMenuItem(
          //                     value: localeName.localeId,
          //                     child: Text(localeName.name),
          //                   ),
          //                 )
          //                 .toList(),
          //           ),
          //         ],
          //       )
          //     ],
          //   ),
          // ),
          Expanded(
            flex: 4,
            child: Column(
              children: <Widget>[
                // Center(
                //   child: Text(
                //     'Recognized Words',
                //     style: TextStyle(fontSize: 22.0),
                //   ),
                // ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      // Container(
                      //   color: Theme.of(context).selectedRowColor,
                      //   child: Center(
                      //     child: Text(
                      //       lastWords,
                      //       textAlign: TextAlign.center,
                      //     ),
                      //   ),
                      // ),
                      Container(
                          child: Center(
                              child: image == ''
                                  ? Container()
                                  : Image.asset(image))),
                      Positioned.fill(
                        bottom: 10,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: 40,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: .26,
                                    spreadRadius: level * 1.5,
                                    color: Colors.black.withOpacity(.05))
                              ],
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            child: IconButton(
                                icon: Icon(Icons.mic), onPressed: () {}),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Expanded(
          //   flex: 1,
          //   child: Column(
          //     children: <Widget>[
          //       Center(
          //         child: Text(
          //           'Error Status',
          //           style: TextStyle(fontSize: 22.0),
          //         ),
          //       ),
          //       Center(
          //         child: Text(lastError),
          //       ),
          //     ],
          //   ),
          // ),

          FlatButton(
            child: Text('Tanyakan Sesuatu'),
            onPressed: () {
              initSpeechState();
              print('ahahhaha');
            },
            color: Theme.of(context).backgroundColor,
          ),
        ]),
      ),
    );
  }

  void startListening() {
    lastWords = "";
    lastError = "";
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 10),
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        partialResults: true,
        onDevice: true,
        listenMode: ListenMode.confirmation);
    setState(() {});
  }

  void stopListening() {
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    setState(() {
      lastWords = "${result.recognizedWords}";
      print(lastWords);
      if (lastWords.toLowerCase() == 'daniel')
        image = 'assets/images/danil.jpg';
      else if (lastWords.toLowerCase() == 'iqbal')
        image = 'assets/images/iqbal.jpg';
      else if (lastWords.toLowerCase() == 'elco')
        image = 'assets/images/elko.jpg';
      else if (lastWords.toLowerCase() == 'ice')
        image = 'assets/images/ice.jpg';
      else if (lastWords.toLowerCase() == 'abu')
        image = 'assets/images/abu.jpg';
      else if (lastWords.toLowerCase() == 'madan')
        image = 'assets/images/madan.jpg';
      else if (lastWords.toLowerCase() == 'elbin')
        image = 'assets/images/elbin.jpg';
      else if (lastWords.toLowerCase() == 'fadel')
        image = 'assets/images/fadel.jpg';
      else if (lastWords.toLowerCase() == 'primus')
        image = 'assets/images/primus.jpg';
      // lastWords = "${result.recognizedWords} - ${result.finalResult}";
      _newVoiceText = 'Ini adalah Foto';
      _speak();
    });
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // print("sound level $level: $minSoundLevel - $maxSoundLevel ");
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    // print("Received error status: $error, listening: ${speech.isListening}");
    setState(() {
      lastError = "${error.errorMsg} - ${error.permanent}";
    });
  }

  void statusListener(String status) {
    // print(
    // "Received listener status: $status, listening: ${speech.isListening}");
    setState(() {
      lastStatus = "$status";
    });
  }

  _switchLang(selectedVal) {
    setState(() {
      _currentLocaleId = selectedVal;
    });
    print(selectedVal);
  }
}
