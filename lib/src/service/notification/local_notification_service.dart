import 'package:auto_route/auto_route.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:companioneyes/main.dart';
import 'package:companioneyes/src/local/local_storage.dart';
import 'package:companioneyes/src/routes/app_router.dart';
import 'package:companioneyes/src/utils/local_storage_keys.dart';
import 'package:companioneyes/src/view/video_call/video_call_view.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LocalNotificationService {
  Future<void> requestPermission() async {
    PermissionStatus status = await Permission.notification.request();
    if (status != PermissionStatus.granted) {
      throw Exception('Permission not granted');
    }
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  Future<String?> getFcmToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      await LocalStorageService.instance
          .setString(LocalStorageKeys.fcmToken, token!);
      return token;
    } catch (e) {
      print(e.toString());
      return "null geldi";
    }
  }

  Future<void> initialize() async {
    //TODO: add logo
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: "video_call_channel",
          channelName: "Video Call Channel",
          channelDescription: "An impaired user needs your help!",
          defaultColor: Colors.red,
          ledColor: Colors.yellow,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          locked: true,
          defaultRingtoneType: DefaultRingtoneType.Ringtone,
          vibrationPattern: highVibrationPattern,
          enableVibration: true,
          criticalAlerts: true,
        ),
      ],
    );

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print("onmessage message received: ${message.data}");
    //   String? title = message.notification!.title!;
    //   String? body = message.notification!.body!;
    //   String? roomId = message.data['room_id'];
    //   AwesomeNotifications().createNotification(
    //     content: NotificationContent(
    //       id: int.tryParse(roomId ?? "10") ?? 10,
    //       channelKey: "video_call_channel",
    //       title: title,
    //       body: body,
    //       color: Colors.tealAccent,
    //       category: NotificationCategory.Call,
    //       wakeUpScreen: true,
    //       fullScreenIntent: true,
    //       autoDismissible: false,
    //       backgroundColor: Colors.amber,
    //     ),
    //     actionButtons: [
    //       NotificationActionButton(
    //         key: "ACCEPT",
    //         label: "Accept Call",
    //         color: Colors.green,
    //         autoDismissible: true,
    //       ),
    //       NotificationActionButton(
    //         key: "DECLINE",
    //         label: "Decline Call in app",
    //         color: Colors.red,
    //         autoDismissible: true,
    //       ),
    //     ],
    //   );
    //   AwesomeNotifications().setListeners(
    //     onActionReceivedMethod: (receivedAction) async {
    //       if (receivedAction.buttonKeyPressed == "ACCEPT") {
    //         print("Accept button clicked ${navigatorKey.currentState}");
    //         print("on foreground");
    //         // await navigatorKey.currentState?.push(MaterialPageRoute(
    //         //   builder: (context) =>
    //         //       VideoCallView(pRoomId: receivedAction.payload?['room_id']),
    //         // ));
    //         await navigatorKey.currentState?.context.router
    //             .push(VideoCallRoute(pRoomId: roomId!));
    //         // TODO: aramaya giererse status ü değiştir aramadan çıkınca da değiştir.
    //       } else if (receivedAction.buttonKeyPressed == "DECLINE") {
    //         print("Decline button clicked");
    //       } else {
    //         print("clicked on notificaiton");
    //       }
    //     },
    //   );
    // });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
      print('A new onMessageOpenedApp event was published!');
      print('Message data: ${message?.data}');
    });
  }
}

Future<void> backgroundHandler(RemoteMessage? message) async {
  String? title = message?.notification?.title ?? "";
  String? body = message?.notification?.body ?? "";
  String? roomId = message?.data['room_id'];
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
        label: "Decline Call",
        color: Colors.red,
        autoDismissible: true,
      ),
    ],
  );
  AwesomeNotifications().setListeners(
    onActionReceivedMethod: (receivedAction) async {
      if (receivedAction.buttonKeyPressed == "ACCEPT") {
        print("Accept button clicked");
        print("on background");
        // await navigatorKey.currentState?.context.router
        //     .push(VideoCallRoute(pRoomId: roomId!));
        // TODO: aramaya giererse status ü değiştir aramadan çıkınca da değiştir.
      } else if (receivedAction.buttonKeyPressed == "DECLINE") {
        print("Decline button clicked");
      } else {
        print("clicked on notificaiton");
      }
    },
  );
}
