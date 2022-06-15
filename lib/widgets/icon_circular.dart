import 'package:flutter/material.dart';

class IconCircular extends StatelessWidget {
  final Color color;
  final Icon icon;
  const IconCircular({Key? key, required this.color, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(
            color: this.color,
          ),
          shape: BoxShape.circle),
      child: Container(
          padding: EdgeInsets.all(10),
          decoration:
              BoxDecoration(color: this.color, shape: BoxShape.circle),
          child: this.icon),
    );
  }
}
