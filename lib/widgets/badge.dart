import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  const Badge(
      {super.key,
      required this.child,
      required this.value,
      this.color = Colors.deepOrange});
  final Widget child;
  final String value;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
            right: 8,
            top: 8,
            child: Container(
              constraints: const BoxConstraints(minHeight: 16, minWidth: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: color,
              ),
              padding: const EdgeInsets.all(2),
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 10),
              ),
            )),
      ],
    );
  }
}
