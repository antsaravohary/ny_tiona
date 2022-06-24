import 'package:flutter/material.dart';

class TabParole extends StatelessWidget {
  const TabParole({Key? key, required this.parole}) : super(key: key);

  final String parole;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Text(parole.replaceAll('\\n', '\n')),
      ),
    );
  }
}
