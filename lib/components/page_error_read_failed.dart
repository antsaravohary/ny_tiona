import 'package:flutter/widgets.dart';
import 'package:ny_tiona/components/page_error.dart';

class PageErrorReadFailed extends StatelessWidget {
  const PageErrorReadFailed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PageError(label: "Echec de lecture");
  }
}
