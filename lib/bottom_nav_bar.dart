import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<GlobalKey<_NavigationIconState>> iconKeys = [];

  @override
  void initState() {
    super.initState();
    // Инициализация ключей для каждой иконки
    iconKeys = List.generate(4, (index) => GlobalKey<_NavigationIconState>());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Bottom Navigation Bar'),
      ),
      body: Center(
        child: Text('Selected index: $_selectedIndex'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: NavigationIcon(
              key: iconKeys[0],
              icon: Icons.home,
              onPressed: () => _onItemTapped(0),
              isSelected: _selectedIndex == 0,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: NavigationIcon(
              key: iconKeys[1],
              icon: Icons.business,
              onPressed: () => _onItemTapped(1),
              isSelected: _selectedIndex == 1,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: NavigationIcon(
              key: iconKeys[2],
              icon: Icons.school,
              onPressed: () => _onItemTapped(2),
              isSelected: _selectedIndex == 2,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: NavigationIcon(
              key: iconKeys[3],
              icon: Icons.person,
              onPressed: () => _onItemTapped(3),
              isSelected: _selectedIndex == 3,
            ),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Активация анимации на выбранной иконке
    iconKeys[index].currentState?.animate();
  }
}

class NavigationIcon extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool isSelected;

  const NavigationIcon({
    Key? key,
    required this.icon,
    required this.onPressed,
    required this.isSelected,
  }) : super(key: key);

  @override
  _NavigationIconState createState() => _NavigationIconState();
}

class _NavigationIconState extends State<NavigationIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 150),
      vsync: this,
      lowerBound: 0.0,
      upperBound: 0.4,
    );
    _animation = Tween(begin: 1.0, end: 0.7).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  void animate() {
    _controller.forward().then((_) {
      _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          // Ваши декорации, если они вам нужны
        ),
        child: Transform.scale(
          scale: _animation.value,
          child: Icon(
            widget.icon,
            color: widget.isSelected ? Colors.black : Colors.grey,
            size: 28,
          ),
        ),
      ),
    );
  }
}