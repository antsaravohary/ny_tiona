import 'package:flutter/material.dart';

class PaginatorIndication extends StatelessWidget {
  const PaginatorIndication({Key? key, required this.label}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(10),
        ),
        color: Colors.grey.shade200,
      ),
      child: Text(label),
    );
  }
}
