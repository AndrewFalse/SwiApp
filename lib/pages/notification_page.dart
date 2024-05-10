import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';

import '../widgets/animated_icon.dart';
import '../widgets/notification_card.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<Map<String, dynamic>> notifications = [
    {'icon': Icons.notifications, 'text': 'Уведомление 1'},
    {'icon': Icons.notifications, 'text': 'Уведомление 2'},
    {'icon': Icons.notifications, 'text': 'Уведомление 3'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top),
            Padding(
              padding: EdgeInsets.only(right: 16.0, left: 16.0, top: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  AnimIcon(icon: CupertinoIcons.back, onPressed: () => Get.back(), color: Colors.black),
                  Expanded(child: SizedBox()),
                  const Text(
                      'уведомления',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, textBaseline: TextBaseline.alphabetic),
                      textAlign: TextAlign.center
                  ),
                  Expanded(child: SizedBox()),
                  AnimIcon(icon: Icons.delete)
                ],
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.85,
              width: MediaQuery.of(context).size.width * 0.95,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return NotificationCard(
                    icon: notifications[0]['icon'],
                    text: notifications[0]['text'],
                  );
                },
              ),
            ),
          ],
        ));
  }
}
