import 'package:flutter/material.dart';

class AnimIcon extends StatefulWidget {
  final VoidCallback? onPressed;
  final Color? color;
  final IconData icon;

  const AnimIcon({super.key, this.onPressed, required this.icon, this.color});

  @override
  _AnimIconState createState() => _AnimIconState();
}

class _AnimIconState extends State<AnimIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 0.9).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
    if (widget.onPressed != null) {
      widget.onPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: () {
        _controller.reverse();
      },
      child: Transform.scale(
        scale: _animation.value,
        child: Icon(
          widget.icon,
          color: widget.color != null ? widget.color! : Colors.grey,
          size: 26,
        ),
      ),
    );
  }
}
