import 'package:speech_recognition/speech_recognition.dart';

class SpeechRecognitionUtil {
  SpeechRecognition _speechRecognition;
  String _locale = 'en';
  bool _isAvaliable = false;

  SpeechRecognitionUtil({ String language = 'English' }){
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler((bool result) {
      print("Av Result... $result");
      _isAvaliable = result;
    });

    _speechRecognition.setCurrentLocaleHandler((String locale) {
      print("Locale Result... $locale");
      _locale = locale;
    });

    _speechRecognition.activate().then((result) {
      print("Activated... $result");
      _isAvaliable = result;
    });

    _speechRecognition.setRecognitionCompleteHandler((){
      print("Recognition Complete...");
    });
  }


  Future listen(){
    return _speechRecognition.listen(locale: _locale);
  }


  Future stop(){
    return _speechRecognition.stop();
  }

  Future cancel(){
    return _speechRecognition.cancel();
  }


  void onResult({ Function onText }){
    _speechRecognition.setRecognitionResultHandler((String result) {
      onText(result);
    });
  }

  bool isAvaliable(){
    return _isAvaliable;
  }
  
}


// void initSpeechRecognition() {
//     _speechRecognitionUtil =
//         SpeechRecognitionUtil(language: _conversation.language);
//     _speechRecognitionUtil.onResult(onText: (String text) {
//       setState(() {
//         _currentMessage.message = text;
//       });
//     });
//   }