import 'package:flutter/material.dart';
import 'package:ny_tiona/components/pdf_viewer.dart';
import 'package:ny_tiona/config/config.dart';

class TabSolfege extends StatelessWidget {
  const TabSolfege({Key? key, required this.pdf}) : super(key: key);

  final String pdf;

  @override
  Widget build(BuildContext context) {
    return PDFViewer(filename: '$parolePath/$pdf');
  }
}
