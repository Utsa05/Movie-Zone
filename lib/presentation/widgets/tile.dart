import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final int index;
  final double extent;
  final Widget widget;

  const Tile({
    super.key,
    required this.index,
    required this.extent,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: extent,
      color: Colors.primaries[index % Colors.primaries.length],
      child: Center(
        child: widget,
      ),
    );
  }
}
