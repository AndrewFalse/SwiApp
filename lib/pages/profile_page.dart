import 'package:design_test/pages/notification_page.dart';
import 'package:design_test/widgets/animated_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.of(context).padding.top),
        Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 16.0, top: 8),
          child: Row(
            children: [
              const Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'профиль',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                        textAlign: TextAlign.center
                    ),
                  ],
                ),
              ),
              AnimIcon(icon: Icons.notifications, onPressed: () => Get.to(NotificationPage()))
            ],
          ),
        ),
      ],
    );
  }
}
