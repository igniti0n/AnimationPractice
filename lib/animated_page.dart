import 'package:flutter/material.dart';

import './animated_widget.dart';
import './rotatingScreens/rotating_screen.dart';

class AnimatedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return CustomAnimatedWidget();
    return Scaffold(body: RotatingScreen());
  }
}
