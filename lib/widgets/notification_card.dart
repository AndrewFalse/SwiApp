import 'package:design_test/assets/color_palette.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final String text;
  final String title;

  const NotificationCard({super.key, required this.text, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1.5,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(12.0),
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800, color: iOrange),
          ),
          SizedBox(width: 8.0),
          Text(
            text,
            style: TextStyle(fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}
