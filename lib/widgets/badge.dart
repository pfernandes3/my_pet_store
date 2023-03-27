import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  const Badge(
      {super.key,
      required this.child,
      required this.value,
      this.color = Colors.deepPurple});
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
            right: 6,
            top: 6,
            child: Container(
              constraints: const BoxConstraints(minHeight: 18, minWidth: 18),
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
