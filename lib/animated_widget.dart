import 'package:flutter/material.dart';

class CustomAnimatedWidget extends StatefulWidget {
  const CustomAnimatedWidget({Key key}) : super(key: key);

  @override
  _CustomAnimatedWidgetState createState() => _CustomAnimatedWidgetState();
}

class _CustomAnimatedWidgetState extends State<CustomAnimatedWidget>
    with SingleTickerProviderStateMixin {
  final _maxSlide = 255.0;
  AnimationController _controller;
  bool _isAvailable;

  void _onTap() {
    print('TAPP');
    _controller.isDismissed ? _controller.forward() : _controller.reverse();
  }

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDragStart(DragStartDetails details) {
    final bool _availableLeft =
        _controller.isDismissed && details.globalPosition.dx < 100;

    final bool _availableRight =
        _controller.isCompleted && details.globalPosition.dx > 200;
    _isAvailable = (_availableRight || _availableLeft);
    return;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    print('The pointer global position: ${details.globalPosition.dx}');
    if (_isAvailable) {
      final delta = details.primaryDelta / _maxSlide;
      _controller.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (_controller.isCompleted || _controller.isCompleted)
      return;
    else if (details.primaryVelocity.abs() >= 140) {
      final double _visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;
      _controller.fling(velocity: _visualVelocity);
    } else if (_controller.value > 0.5) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (ctx, _) => Stack(
        children: [
          Container(
            color: Colors.blue,
          ),
          GestureDetector(
            onHorizontalDragStart: _onDragStart,
            onHorizontalDragEnd: _onDragEnd,
            onHorizontalDragUpdate: _onDragUpdate,
            onTap: _onTap,
            child: Transform(
              transform: Matrix4.identity()
                ..translate(_maxSlide * (_controller.value))
                ..scale(1 - (_controller.value * 0.3)),
              alignment: Alignment.centerLeft,
              child: Container(
                color: Colors.redAccent,
              ),
            ),
          )
        ],
      ),
    );
  }
}
