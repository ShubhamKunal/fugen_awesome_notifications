import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:fugen/controllers/notifications.dart';

void main() {
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Colors.amber,
        ledColor: Colors.amber,
        importance: NotificationImportance.High,
      ),
    ],
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: 'basic_channel_group',
        channelGroupName: 'Basic group',
      ),
    ],
    debug: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: MyApp.navigatorKey,
      title: 'Flutter Demo',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
   AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod:
          NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
          NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod:
          NotificationController.onDismissActionReceivedMethod,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Example app',
            style: TextStyle(
              color: Colors.black,
        ),),),
      body: Column(
        children: [
          SizedBox(height: 30),
          const Center(child: Text("Here's a button receive awesome notification"),),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber

            ),
            onPressed: () async {
              await NotificationController.requestUserPermissions(
                context,
                channelKey: "basic_channel",
                permissionList: [
                  NotificationPermission.Alert,
                  NotificationPermission.Sound,
                ],
              );

              await AwesomeNotifications().createNotification(
                content: NotificationContent(
                  id: 1,
                  backgroundColor: Colors.amber,
                  channelKey: 'basic_channel',
                  title: 'Hi there!',
                  body: 'Hello from the awesome_notifications',
                  notificationLayout: NotificationLayout.Default,
                  displayOnBackground: true,
                  displayOnForeground: true,
                ),
                actionButtons: [
                  NotificationActionButton(
                    key: "Don't dismiss",
                    label: "Don't dismiss",
                    actionType: ActionType.Default,
                    autoDismissible: false,
                  ),
                  NotificationActionButton(
                    key: 'dismiss',
                    label: 'Dismiss',
                    actionType: ActionType.Default,
                    autoDismissible: true,
                  ),
                ],
              );
            },
            child: const Text("Send notification"),
          ),
        ],
      ),
    );
  }
}
