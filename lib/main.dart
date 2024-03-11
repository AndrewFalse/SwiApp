import 'package:design_test/custom_card.dart';
import 'package:design_test/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'nav_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SwiperExamplePage(),
    );
  }
}

class SwiperExamplePage extends StatefulWidget {
  @override
  _SwiperExamplePageState createState() => _SwiperExamplePageState();
}

class _SwiperExamplePageState extends State<SwiperExamplePage> with TickerProviderStateMixin {
  late final AppinioSwiperController swiperController;
  late AnimationController animationController;
  late Animation<double> animation;
  late AnimationController animationController2;
  late Animation<double> animation2;
  int _selectedIndex = 0;
  List<GlobalKey<NavigationIconState>> iconKeys = [];

  @override
  void initState() {
    super.initState();
    swiperController = AppinioSwiperController();
    iconKeys = List.generate(4, (index) => GlobalKey<NavigationIconState>());
    animationController = AnimationController(
      duration: const Duration(milliseconds: 300), // Более быстрая анимация
      vsync: this,
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

    animationController2 = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    animation2 = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );

  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('ru_RU', null); // Initialize date formatting for Russian locale
    String currentDate = DateFormat.yMMMMd('ru_RU').format(DateTime.now());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
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
                      Text(
                        'Привет, Пупсик!', // Your greeting text here
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                      ),
                      Text(
                        currentDate, // Current date in Russian
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
                        duration: Duration(milliseconds: 500),
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
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
                        duration: Duration(milliseconds: 500),
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
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
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            elevation: 0,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
          ),
        ),
        child: CustomBottomNavigationBar(
          selectedIndex: _selectedIndex,
          onItemSelected: _onItemTapped,
          iconKeys: iconKeys,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    iconKeys[index].currentState?.animate();
  }

  void _showAsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.25, // Минимальный размер листа - 25% от высоты экрана
        maxChildSize: 0.9, // Максимальный размер листа - 80% от высоты экрана
        builder: (_, controller) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(height: 8),
                Center(
                  child: Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(2.5)),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: controller,
                    itemCount: 30,
                    itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    swiperController.dispose();
    super.dispose();
  }
}

class DetailsPage extends StatelessWidget {
  final String tag;

  DetailsPage({required this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Information"),
      ),
      body: Hero(
          tag: tag,
          child: Text("Delulu")
      ),
    );
  }
}
