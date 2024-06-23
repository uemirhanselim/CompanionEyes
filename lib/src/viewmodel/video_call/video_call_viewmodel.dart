import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companioneyes/locator.dart';
import 'package:companioneyes/src/local/local_storage.dart';
import 'package:companioneyes/src/model/auth/new_user.dart';
import 'package:companioneyes/src/service/notification/push_notification_service.dart';
import 'package:companioneyes/src/service/user/user_service.dart';
import 'package:companioneyes/src/service/video_call/video_call_service.dart';
import 'package:companioneyes/src/utils/constants.dart';
import 'package:companioneyes/src/utils/local_storage_keys.dart';
import 'package:companioneyes/src/view/widgets/snackbar_message.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

class VideoCallViewModel extends ChangeNotifier {
  final UserService _userService = locator.get<UserService>();
  final PushNotificationsService _pushNotificationsService =
      locator.get<PushNotificationsService>();
  final VideoCallService _videoCallService = locator.get<VideoCallService>();
  VideoCallViewModel(BuildContext context, String? pRoomId, String helpDefinition) {
// Add your initialization code here
    _getRoomId(pRoomId);
    _createEngine().then(
      (value) async {
        await Future.delayed(const Duration(seconds: 1));
        await _getReceieverFCMToken(pRoomId);
        await _getCurrentUser();
        await _sendFCMMessage(pRoomId, helpDefinition);
        startListenEvent(context);
        await loginRoom(getUserId(), _currentUser!.firstName, context);
        setIsPageLoaded = true;
        print(
            "-------------------------is volunterr: ${_currentUser!.isVolunteer}");
      },
    );
  }
// Setters
  Widget? _localView;
  Widget? _remoteView;
  int? _localViewID;
  int? _remoteViewID;
  NewUser? _currentUser;
  String _roomID = const Uuid().v4();
  String _recieverFCMToken = '';
  bool _isPageLoaded = false;

// Getters
  Widget? get localView => _localView;
  Widget? get remoteView => _remoteView;
  int? get localViewID => _localViewID;
  int? get remoteViewID => _remoteViewID;
  NewUser? get currentUser => _currentUser;
  String get roomID => _roomID;
  String get recieverFCMToken => _recieverFCMToken;
  bool get isPageLoaded => _isPageLoaded;

// Other methods
  void _getRoomId(String? pRoomId) {
    if (pRoomId == null) {
      //! Creating a new meeting
      final id = const Uuid().v4();
      print(id);
      setRoomId = id;
    } else {
      setRoomId = pRoomId;
    }
    print(
        "------------------------------------------------- room id: $_roomID");
  }

  Future<void> _getReceieverFCMToken(String? pRoomId) async {
    if (pRoomId == null) {
      List<QueryDocumentSnapshot<Object?>> list =
          await _videoCallService.getAllVolunteers();
      print("list all volunteers: $list");
      print("list first: ${list.first}");
      setRecieverFCMToken = list.first['fcmToken'];
    }
  }

  Future<void> _sendFCMMessage(String? pRoomId, String helpDefinition) async {
    if (pRoomId == null) {
      await _pushNotificationsService.sendFCMMessage(
          receieverFCMToken: _recieverFCMToken, roomId: _roomID, definition: helpDefinition);
    }
  }

  set setRoomId(String value) {
    _roomID = value;
    notifyListeners();
  }

  set setLocalView(Widget? value) {
    _localView = value;
    notifyListeners();
  }

  set setRemoteView(Widget? value) {
    _remoteView = value;
    notifyListeners();
  }

  set setLocalViewID(int? value) {
    _localViewID = value;
    notifyListeners();
  }

  set setRemoteViewID(int? value) {
    _remoteViewID = value;
    notifyListeners();
  }

  set setCurrentUser(NewUser? value) {
    _currentUser = value;
    notifyListeners();
  }

  set setRecieverFCMToken(String value) {
    _recieverFCMToken = value;
    notifyListeners();
  }

  set setIsPageLoaded(bool value) {
    _isPageLoaded = value;
    notifyListeners();
  }

  Future<void> _getCurrentUser() async {
    setCurrentUser = await _userService.getCurrentUser();
    print(
        "------------------------------------------------------- ${_currentUser!.firstName}");
  }

  Future<void> _createEngine() async {
    await ZegoExpressEngine.createEngineWithProfile(ZegoEngineProfile(
      Constants.appId,
      ZegoScenario.Default,
      appSign: Constants.appSignId,
    ));
    await ZegoExpressEngine.instance.useFrontCamera(false);
  }

  void startListenEvent(BuildContext context) {
    // Callback for updates on the status of other users in the room.
    // Users can only receive callbacks when the isUserStatusNotify property of ZegoRoomConfig is set to `true` when logging in to the room (loginRoom).
    ZegoExpressEngine.onRoomUserUpdate =
        (roomID, updateType, List<ZegoUser> userList) {
      message(context,
          'onRoomUserUpdate: roomID: $roomID, updateType: ${updateType.name}, userList: ${userList.map((e) => e.userID)}');
    };
    // Callback for updates on the status of the streams in the room.
    ZegoExpressEngine.onRoomStreamUpdate =
        (roomID, updateType, List<ZegoStream> streamList, extendedData) {
      message(context,
          'onRoomStreamUpdate: roomID: $roomID, updateType: $updateType, streamList: ${streamList.map((e) => e.streamID)}, extendedData: $extendedData');
      if (updateType == ZegoUpdateType.Add) {
        for (final stream in streamList) {
          startPlayStream(stream.streamID);
        }
      } else {
        for (final stream in streamList) {
          stopPlayStream(stream.streamID);
        }
      }
    };
  }

  Future<void> startPlayStream(String streamID) async {
    // Start to play streams. Set the view for rendering the remote streams.
    await ZegoExpressEngine.instance.createCanvasView((viewID) {
      setRemoteViewID = viewID;
      ZegoCanvas canvas = ZegoCanvas(viewID, viewMode: ZegoViewMode.AspectFill);
      ZegoExpressEngine.instance.startPlayingStream(streamID, canvas: canvas);
    }).then((canvasViewWidget) {
      setRemoteView = canvasViewWidget;
    });
  }

  Future<void> stopPlayStream(String streamID) async {
    ZegoExpressEngine.instance.stopPlayingStream(streamID);
    if (_remoteViewID != null) {
      ZegoExpressEngine.instance.destroyCanvasView(remoteViewID!);
      setRemoteView = null;
      setRemoteViewID = null;
    }
  }

  String getUserId() {
    String id =
        LocalStorageService.instance.getString(LocalStorageKeys.userCredential);
    return id;
  }

  Future<ZegoRoomLoginResult> loginRoom(
      String userID, String userNm, BuildContext context) async {
    // The value of `userID` is generated locally and must be globally unique.
    print("------------------------------------------------- userid: $userID");
    final user = ZegoUser(userID, userNm);

    // The value of `roomID` is generated locally and must be globally unique.

    // onRoomUserUpdate callback can be received when "isUserStatusNotify" parameter value is "true".
    ZegoRoomConfig roomConfig = ZegoRoomConfig.defaultConfig()
      ..isUserStatusNotify = true;
    // log in to a room
    // Users must log in to the same room to call each other.
    return ZegoExpressEngine.instance
        .loginRoom(_roomID, user, config: roomConfig)
        .then((ZegoRoomLoginResult loginRoomResult) {
      message(context,
          'loginRoom: errorCode:${loginRoomResult.errorCode}, extendedData:${loginRoomResult.extendedData}');
      //   if (widget.name != "volunteer") {
      if (loginRoomResult.errorCode == 0) {
        startPreview();
        startPublish();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('loginRoom failed: ${loginRoomResult.errorCode}')));
      }
      //    }
      return loginRoomResult;
    });
  }

  Future<void> startPreview() async {
    await ZegoExpressEngine.instance.createCanvasView((viewID) {
      setLocalViewID = viewID;
      ZegoCanvas previewCanvas =
          ZegoCanvas(viewID, viewMode: ZegoViewMode.AspectFill);
      ZegoExpressEngine.instance.startPreview(canvas: previewCanvas);
    }).then((canvasViewWidget) {
      setLocalView = canvasViewWidget;
    });
  }

  Future<void> stopPreview() async {
    ZegoExpressEngine.instance.stopPreview();
    if (localViewID != null) {
      await ZegoExpressEngine.instance.destroyCanvasView(localViewID!);

      setLocalView = null;
      setLocalViewID = null;
    }
  }

  Future<void> startPublish() async {
    // After calling the `loginRoom` method, call this method to publish streams.
    // The StreamID must be unique in the room.
    String streamID = 'rooooooooooooo_${_currentUser!.firstName}';
    return ZegoExpressEngine.instance.startPublishingStream(streamID);
  }

  Future<ZegoRoomLogoutResult> logoutRoom() async {
    stopPreview();
    stopPublish();
    return ZegoExpressEngine.instance.logoutRoom(_roomID);
  }

  Future<void> stopPublish() async {
    return ZegoExpressEngine.instance.stopPublishingStream();
  }

  void stopListenEvent() {
    ZegoExpressEngine.onRoomUserUpdate = null;
    ZegoExpressEngine.onRoomStreamUpdate = null;
    ZegoExpressEngine.onRoomStateUpdate = null;
    ZegoExpressEngine.onPublisherStateUpdate = null;
  }

  @override
  void dispose() {
    stopListenEvent();
    super.dispose();
  }
}
