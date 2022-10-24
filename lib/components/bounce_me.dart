import 'package:flutter/material.dart';

class BounceMe extends StatefulWidget {
  final Widget child;
  const BounceMe({Key? key, required this.child}) : super(key: key);

  @override
  State<BounceMe> createState() => _BounceMeState();
}

class _BounceMeState extends State<BounceMe>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 100,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return Listener(
      onPointerDown: (PointerDownEvent event) {
        _controller.forward();
      },
      onPointerUp: (PointerUpEvent event) {
        _controller.reverse();
      },
      child: Transform.scale(scale: _scale, child: widget.child),
    );
  }
}