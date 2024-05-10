import 'package:flutter/material.dart';

class StoryWidget extends StatefulWidget {
  @override
  _StoryWidgetState createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    if (_controller.isDismissed) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        // Check the drag details to decide whether to expand or contract the story widget
        if (details.primaryDelta! < 0) {
          _controller.forward();
        } else if (details.primaryDelta! > 0) {
          _controller.reverse();
        }
      },
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              // Adjust the height according to the _animation value
              height: 100 + 200 * _animation.value,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  // Use Positioned to move your story circles
                  ...List.generate(5, (index) {
                    double start = (index * 60).toDouble();
                    double end = (index * 120).toDouble();
                    double left = Tween(begin: start, end: end).evaluate(_animation);

                    return Positioned(
                      left: left,
                      bottom: 0,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage('your_image_url'),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          // ... other slivers
        ],
      ),
    );
  }
}
