import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  const Badge({Key? key, required this.label}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: Colors.grey.shade200,
      ),
      child: Text(label),
    );
  }
}
