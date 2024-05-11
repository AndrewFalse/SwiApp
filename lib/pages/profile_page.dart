import 'package:carousel_slider/carousel_slider.dart';
import 'package:design_test/assets/color_palette.dart';
import 'package:design_test/pages/notification_page.dart';
import 'package:design_test/widgets/animated_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../widgets/carousel_card.dart';

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
                    Text('профиль',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w800),
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
              Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  padding: EdgeInsets.all(6),
                  child: AnimIcon(
                      icon: Icons.notifications,
                      onPressed: () => Get.to(NotificationPage()))),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(2),
                child: Image.network('https://i.ibb.co/R7R84y3/basic.png'),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        CarouselSlider(
            options: CarouselOptions(
              autoPlayInterval: const Duration(seconds: 10),
              enlargeCenterPage: false,
              autoPlay: true,
              height: 150,
              viewportFraction: 0.85,
            ),
            items: [0].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return CarouselCard(
                    backgroundColor: iBlue,
                    text: 'Пригласи друзей, чтобы посещать события вместе.',
                    onPressed: () {
                      print("pressed");
                    },
                  );
                },
              );
            }).toList()),
      ],
    );
  }
}
