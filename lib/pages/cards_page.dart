import 'dart:async';

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../custom_card.dart';

class CardsPage extends StatefulWidget {
  const CardsPage({super.key});

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> with TickerProviderStateMixin {
  late final AppinioSwiperController swiperController;
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    swiperController = AppinioSwiperController();

    animationController = AnimationController(
      duration: const Duration(milliseconds: 300), vsync: this
    )..drive(CurveTween(curve: Curves.easeOut));

    final curvedAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );

    animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Timer(Duration(seconds: 2), () {
            animationController.reverse();
          });
        }
      });

    swiperController.addListener(() {
      double? progress = swiperController.swipeProgress?.dx;
      if (progress != null && progress >= 1) {
        animationController.forward(from: 0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('ru_RU', null);
    String currentDate = DateFormat.yMMMMd('ru_RU').format(DateTime.now());
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top),
            Padding(
              padding: const EdgeInsets.only(right: 16.0, left: 16.0, top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'главная страница',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                      ),
                      Text(
                        currentDate,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: AppinioSwiper(
                        cardCount: 5,
                        cardBuilder: (context, index) {
                          return CustomCard(imagePath: 'https://i.ibb.co/R7R84y3/basic.png', tag: "КУЛИНАРИЯ", title: "ГОТОВИМ ВКУСНЕЙШИЕ ПИРОГИ", subtitle: "Готовим самые вкусные пироги на свете. Просто пальчики оближешь. Этот текст является проверкой и подлежит изменению в будущем", author: "Андрюшечка", date: "01.01.01", readTime: "2 мин", authorImage: 'https://i.ibb.co/HqKdyfK/image.jpg',);
                        },
                        controller: swiperController,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        AnimatedBuilder(
          animation: swiperController,
          builder: (context, _) {
            double? progress = swiperController.swipeProgress?.dx;
            double startOpacity = 0.0;
            double endOpacity = 0.0;
            if (progress != null) {
              if (progress > 0.2) {
                endOpacity = (progress * 0.9).clamp(0.0, 0.7);
              } else if (progress < -0.2) {
                startOpacity = (-progress * 0.9).clamp(0.0, 0.7);
              }
            }
            return Stack(
              children: [
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AnimatedOpacity(
                      opacity: startOpacity,
                      duration: const Duration(milliseconds: 500),
                      child: Container(
                        width: 100,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xfff75304),
                              Colors.transparent
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: AnimatedOpacity(
                      opacity: endOpacity,
                      duration: const Duration(milliseconds: 500),
                      child: Container(
                        width: 100,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xffd9df7b),
                              Colors.transparent
                            ],
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: animationController,
                  builder: (context, child) {
                    return Positioned(
                      bottom: (50 * animation.value) - 30,
                      left: 0,
                      right: 0,
                      child: Opacity(
                        opacity: animation.value,
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: Color(0xff9392f8),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Text(
                              'Swipe right!',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}