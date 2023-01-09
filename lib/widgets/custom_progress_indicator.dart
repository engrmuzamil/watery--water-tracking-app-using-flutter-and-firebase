import 'package:flutter/material.dart';

class CustomProgressIndicatior extends StatefulWidget {
  @override
  _CustomProgressIndicatiorState createState() =>
      _CustomProgressIndicatiorState();
}

class _CustomProgressIndicatiorState extends State<CustomProgressIndicatior>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: (3 * 0.5 * 2222).toInt()));

    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      strokeWidth: 8,
      valueColor: TweenSequence(
        <TweenSequenceItem<Color>>[
          TweenSequenceItem<Color>(
            tween: ConstantTween<Color>(Color(0xFF323062)),
            weight: 33.33,
          ),
          TweenSequenceItem<Color>(
              tween: ConstantTween<Color>(Color.fromARGB(195, 50, 48, 98)),
              weight: 33.33),
          TweenSequenceItem<Color>(
              tween: ConstantTween<Color>(Color.fromARGB(123, 50, 48, 98)),
              weight: 33.33),
        ],
      ).animate(_animationController),
    );
  }
}
