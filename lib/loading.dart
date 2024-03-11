import 'package:flutter/material.dart';
import 'dart:math' as math;

class LoadingWidget extends StatefulWidget {
  final String imageUrl;

  LoadingWidget({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _bounceAnimation;
  late final Animation<double> _loadingAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(begin: 0.0, end: 20.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _loadingAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _bounceAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, -_bounceAnimation.value),
              child: child,
            );
          },
          child: Image.network(widget.imageUrl), // Загружаем изображение
        ),
        SizedBox(height: 10),
        LoadingDotsIndicator(numberOfDots: 4, activeColor: Color(0xff9392f8),)
      ],
    );
  }
}

class LoadingDotsIndicator extends StatefulWidget {
  final double dotRadius;
  final double spaceBetween;
  final int numberOfDots;
  final Color activeColor;
  final Color inactiveColor;

  const LoadingDotsIndicator({
    Key? key,
    this.dotRadius = 5.0,
    this.spaceBetween = 5.0,
    this.numberOfDots = 8,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
  }) : super(key: key);

  @override
  _LoadingDotsIndicatorState createState() => _LoadingDotsIndicatorState();
}

class _LoadingDotsIndicatorState extends State<LoadingDotsIndicator> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _animation = StepTween(begin: 0, end: widget.numberOfDots - 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 1.0, curve: Curves.linear),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: _DotIndicatorPainter(
            dotCount: widget.numberOfDots,
            activeDot: _animation.value,
            dotRadius: widget.dotRadius,
            spaceBetween: widget.spaceBetween,
            activeColor: widget.activeColor,
            inactiveColor: widget.inactiveColor,
          ),
          child: SizedBox(
            width: widget.dotRadius * 2 * widget.numberOfDots + widget.spaceBetween * (widget.numberOfDots - 1),
            height: widget.dotRadius * 2,
          ),
        );
      },
    );
  }
}

class _DotIndicatorPainter extends CustomPainter {
  final int dotCount;
  final int activeDot;
  final double dotRadius;
  final double spaceBetween;
  final Color activeColor;
  final Color inactiveColor;

  _DotIndicatorPainter({
    required this.dotCount,
    required this.activeDot,
    required this.dotRadius,
    required this.spaceBetween,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill;

    for (int i = 0; i < dotCount; i++) {
      paint.color = i == activeDot ? activeColor : inactiveColor;
      canvas.drawCircle(
        Offset(i * (2 * dotRadius + spaceBetween) + dotRadius, dotRadius),
        dotRadius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
