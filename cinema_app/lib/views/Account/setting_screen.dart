// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({Key? key}) : super(key: key);

//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }

// class _SettingsScreenState extends State<SettingsScreen> {
//   List<String> languages = ['Tiếng Việt', 'Tiếng Anh'];
//   String _appVersion = '1.0.0';
//   String _latestVersion =
//       '1.0.1'; // Dữ liệu cứng đại diện cho phiên bản mới nhất

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         title: const Text("Cấu hình"),
//       ),
//       body: Column(
//         children: [
//           ElevatedButton(
//             onPressed: () {
//               _checkAndShowUpdateNotification();
//             },
//             child: const Text("Kiểm tra cập nhật"),
//           ),
//         ],
//       ),
//     );
//   }

//   void _checkAndShowUpdateNotification() {
//     if (_latestVersion.compareTo(_appVersion) > 0) {
//       // Nếu phiên bản mới hơn, hiển thị thông báo cập nhật
//       _showUpdateNotification();
//     }
//   }

//   Future<void> _showUpdateNotification() async {
//     var android = const AndroidNotificationDetails(
//         'update_channel', 'Update Channel', 'Channel for update notifications',
//         priority: Priority.high, importance: Importance.max);
//     var platform = NotificationDetails(android: android);

//     await FlutterLocalNotificationsPlugin().show(
//       0,
//       'Có cập nhật mới!',
//       'Phiên bản mới của ứng dụng đã sẵn sàng. Vui lòng cập nhật ngay!',
//       platform,
//       payload: 'Update Notification',
//     );
//   }
// }
