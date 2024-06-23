import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companioneyes/locator.dart';
import 'package:companioneyes/src/local/user_status_database.dart';
import 'package:companioneyes/src/model/user_status/user_status.dart';
import 'package:companioneyes/src/model/video_call/video_call_model.dart';
import 'package:companioneyes/src/service/video_call/video_call_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:uuid/uuid.dart';

class ImpairedDashboardViewModel extends ChangeNotifier {
  final VideoCallService _videoCallService = locator.get<VideoCallService>();
  ImpairedDashboardViewModel() {
    _getUserType().then((value) => setIsPageLoaded = true);
    _initSpeech();
  }

// Setters
  late bool _isVolunteer;
  bool _isPageLoaded = false;
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  bool _speakButtonPressed = false;
  bool _isLastWordsChanged = false;
  String _lastWords = 'Tap below button to start speaking...';

// Getters
  bool get isVolunteer => _isVolunteer;
  bool get isPageLoaded => _isPageLoaded;
  SpeechToText get speechToText => _speechToText;
  bool get speechEnabled => _speechEnabled;
  bool get speakButtonPressed => _speakButtonPressed;
  bool get isLastWordsChanged => _isLastWordsChanged;
  String get lastWords => _lastWords;
// Other methods
  set setIsVolunteer(bool value) {
    _isVolunteer = value;
    notifyListeners();
  }

  set setIsPageLoaded(bool value) {
    _isPageLoaded = value;
    notifyListeners();
  }

  set setSpeechEnabled(bool value) {
    _speechEnabled = value;
    notifyListeners();
  }

  set setSpeakButtonPressed(bool value) {
    _speakButtonPressed = value;
    notifyListeners();
  }

  set setIsLastWordsChanged(bool value) {
    _isLastWordsChanged = value;
    notifyListeners();
  }

  set setLastWords(String value) {
    _lastWords = value;
    notifyListeners();
  }

  Future<void> _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    notifyListeners();
  }

  Future<void> startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setIsLastWordsChanged = true;
    notifyListeners();
  }

  Future<void> stopListening() async {
    await _speechToText.stop();
    notifyListeners();
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setLastWords = result.recognizedWords;
  }

  Future<void> startVideoCall() async {
    String uuid = const Uuid().v4();
    final VideoCallModel videoCallModel = VideoCallModel(
      callStatus: CallStatus.WAITING,
      callerId: 'callerId',
      id: uuid,
      recieverId: 'recieverId',
      callTime: DateTime.now(),
    );
    await _videoCallService.createVideoCall(videoCallModel: videoCallModel);
  }

  Future<void> getAllVolunteers() async {
    List<QueryDocumentSnapshot> aa = await _videoCallService.getAllVolunteers();
  }

  Future<void> updateVideoCall() async {
    String uuid = const Uuid().v4();
    final VideoCallModel videoCallModel = VideoCallModel(
      callStatus: CallStatus.ACCEPTED,
      callerId: 'updated callerId',
      id: uuid,
      recieverId: 'recieverId',
      callTime: DateTime.now(),
    );
    await _videoCallService.updateVideoCall(videoCallModel: videoCallModel);
  }

  Future<String> readJson() async {
    final String response = await rootBundle.loadString('assets/json/ce.json');
    final data = await json.decode(response);
    return data['private_key'].toString().substring(27);
  }

  Future<void> _getUserType() async {
    UserStatus user = await UserStatusDatabase().getUserStatus();
    user.isVolunteer ? setIsVolunteer = true : setIsVolunteer = false;
  }
}
