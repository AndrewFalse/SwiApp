import 'package:design_test/pages/cards_page.dart';
import 'package:design_test/pages/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'nav_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: SwiperExamplePage(),
    );
  }
}

class SwiperExamplePage extends StatefulWidget {
  @override
  _SwiperExamplePageState createState() => _SwiperExamplePageState();
}

class _SwiperExamplePageState extends State<SwiperExamplePage> with TickerProviderStateMixin {
  late AnimationController animationController2;
  late Animation<double> animation2;
  int _selectedIndex = 0;
  List<GlobalKey<NavigationIconState>> iconKeys = [];
  Widget showPage = const CardsPage();

  @override
  void initState() {
    super.initState();
    iconKeys = List.generate(4, (index) => GlobalKey<NavigationIconState>());
    animationController2 = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    animation2 = CurvedAnimation(
      parent: animationController2,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: showPage,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
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
    if (index == 0) {
      showPage = const CardsPage();
    }
    else if (index == 3) {
      showPage = const ProfilePage();
    }
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
    animationController2.dispose();
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
