import 'package:flutter/material.dart';
import 'package:ny_tiona/models/music.dart';

class ListItem extends StatefulWidget {
  const ListItem({
    Key? key,
    required this.music,
    required this.toggleFavoris,
    required this.pushTo,
  }) : super(key: key);

  final Music music;
  final Function toggleFavoris;
  final Function pushTo;

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.music.title),
      leading: Text(widget.music.numero.toString()),
      trailing: Icon(
        widget.music.favoris == 1 ? Icons.favorite : Icons.favorite_border,
      ),
      onTap: () async {
        await widget.pushTo(widget.music);
      },
      onLongPress: () {
        widget.toggleFavoris(widget.music.id);
      },
    );
  }
}
