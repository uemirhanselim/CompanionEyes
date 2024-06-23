import 'package:auto_route/auto_route.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:companioneyes/main.dart';
import 'package:companioneyes/src/local/user_status_database.dart';
import 'package:companioneyes/src/routes/app_router.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(BuildContext context) {
// Add your initialization code here
    print("Accept button clicked ${navigatorKey.currentState}");
    getUserStatus();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onmessage message received: ${message.data}");
      String? title = message.notification!.title!;
      String? body = message.notification!.body!;
      String? roomId = message.data['room_id'];
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: int.tryParse(roomId ?? "10") ?? 10,
          channelKey: "video_call_channel",
          title: title,
          body: body,
          color: Colors.tealAccent,
          category: NotificationCategory.Call,
          wakeUpScreen: true,
          fullScreenIntent: true,
          autoDismissible: false,
          backgroundColor: Colors.amber,
        ),
        actionButtons: [
          NotificationActionButton(
            key: "ACCEPT",
            label: "Accept Call",
            color: Colors.green,
            autoDismissible: true,
          ),
          NotificationActionButton(
            key: "DECLINE",
            label: "Decline Call in app",
            color: Colors.red,
            autoDismissible: true,
          ),
        ],
      );

      AwesomeNotifications().setListeners(
        onActionReceivedMethod: (receivedAction) async {
          print(
              "--------------------- action date ${receivedAction.actionDate}");
          if (CallState.instance._callId != null &&
              CallState.instance.callId == 10) {
            return;
          }

          CallState.instance.setState(10);
          if (receivedAction.buttonKeyPressed == "ACCEPT") {
            print("Accept button clicked $roomId");
            print("on foreground");
            //   CallState.instance.setState(null);
            await context.router.push(VideoCallRoute(pRoomId: roomId!));

            // TODO: aramaya giererse status ü değiştir aramadan çıkınca da değiştir.
          } else if (receivedAction.buttonKeyPressed == "DECLINE") {
            print("Decline button clicked");
          } else {
            print("clicked on notificaiton");
          }
        },
      );
    });
  }
// Setters
  late final bool _isVolunteer;
  bool _isPageLoading = true;
  int _pageIndex = 0;

// Getters
  bool get isVolunteer => _isVolunteer;
  bool get isPageLoading => _isPageLoading;
  int get pageIndex => _pageIndex;
// Other methods

  set setIsVolunteer(bool value) {
    _isVolunteer = value;
    notifyListeners();
  }

  set setIsPageLoading(bool value) {
    _isPageLoading = value;
    notifyListeners();
  }

  set setPageIndex(int value) {
    _pageIndex = value;
    notifyListeners();
  }

  Future<void> getUserStatus() async {
    await UserStatusDatabase()
        .getUserStatus() //TODO: delete ünlem here
        .then((value) => setIsVolunteer = value.isVolunteer)
        .then((value) => setIsPageLoading = false);
  }
}

class CallState {
  CallState._internal();

  static final instance = CallState._internal();

  int? _callId;
  int? get callId => _callId;

  void setState(int? callId) {
    if (_callId != callId) _callId = callId;
  }
}
