import 'package:flutter/material.dart';
import 'package:ny_tiona/config/config.dart';
import 'package:ny_tiona/models/music.dart';
import 'package:ny_tiona/screens/item.dart';
import 'package:ny_tiona/screens/listing.dart';

void main() {
  runApp(const TionaApp());
}

class TionaApp extends StatelessWidget {
  const TionaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ny Tiona',
      theme: ThemeData(
        fontFamily: fontFamily,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.indigo,
        ).copyWith(
          secondary: Colors.orange,
        ),
        textTheme: const TextTheme(
          headline2: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: Colors.black,
          ),
          bodyText2: TextStyle(fontSize: 14),
          subtitle1: TextStyle(fontSize: 14),
        ),
      ),
      initialRoute: Listing.route,
      routes: {
        Listing.route: (context) => const Listing(),
        Item.route: (context) =>
            Item(music: ModalRoute.of(context)?.settings.arguments as Music),
      },
    );
  }
}
