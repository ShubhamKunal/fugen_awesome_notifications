import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:fugen/controllers/notifications.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            )),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          const Center(
            child: Text("Here's a button receive awesome notification"),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
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
