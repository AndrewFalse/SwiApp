import 'package:design_test/assets/color_palette.dart';
import 'package:flutter/material.dart';

class CarouselCard extends StatelessWidget {
  final Color? backgroundColor;
  final String? text;
  final VoidCallback? onPressed;

  const CarouselCard({
    super.key,
    this.backgroundColor,
    this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (text != null)
            Text(
              text!,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: onPressed,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: backgroundColor ?? Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: EdgeInsets.all(2.0),
                    child: Icon(
                      Icons.add,
                      color: iBlack,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'Добавить',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

