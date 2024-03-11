import 'package:flutter/material.dart';

// Класс для обработки навигации
class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;
  final List<GlobalKey<NavigationIconState>> iconKeys;

  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.iconKeys,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade200,
            width: 0.4,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          NavigationIcon(
            key: iconKeys[0],
            icon: Icons.home,
            onPressed: () => onItemSelected(0),
            isSelected: selectedIndex == 0,
          ),
          NavigationIcon(
            key: iconKeys[1],
            icon: Icons.search,
            onPressed: () => onItemSelected(1),
            isSelected: selectedIndex == 1,
          ),
          NavigationIcon(
            key: iconKeys[2],
            icon: Icons.notifications,
            onPressed: () => onItemSelected(2),
            isSelected: selectedIndex == 2,
          ),
          NavigationIcon(
            key: iconKeys[3],
            icon: Icons.account_circle,
            onPressed: () => onItemSelected(3),
            isSelected: selectedIndex == 3,
          ),
        ],
      ),
    );
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
  NavigationIconState createState() => NavigationIconState();
}

class NavigationIconState extends State<NavigationIcon>
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
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: widget.onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4),
        child: Transform.scale(
          scale: _animation.value,
          child: Icon(
            widget.icon,
            color: widget.isSelected ? Colors.black : Colors.grey,
            size: 32,
          ),
        ),
      ),
    );
  }
}
