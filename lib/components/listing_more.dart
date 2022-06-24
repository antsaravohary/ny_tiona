import 'package:flutter/material.dart';

class ListingMore extends StatelessWidget {
  const ListingMore({Key? key, required this.onSelected}) : super(key: key);

  final Function onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (item) => onSelected(onSelected),
      itemBuilder: (context) => const [
        PopupMenuItem(
          value: 1,
          child: Text('À propos'),
        ),
      ],
    );
  }
}
