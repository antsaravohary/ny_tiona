import 'package:flutter/material.dart';
import 'package:ny_tiona/components/player.dart';
import 'package:ny_tiona/components/tab_parole.dart';
import 'package:ny_tiona/components/tab_solfege.dart';
import 'package:ny_tiona/config/config.dart';
import 'package:ny_tiona/models/music.dart';
import 'package:ny_tiona/models/push_to_item_data.dart';
import 'package:ny_tiona/services/listing_service.dart';

class Item extends StatefulWidget {
  const Item({Key? key, required this.music}) : super(key: key);

  static const route = '/item';
  final Music music;

  @override
  State<StatefulWidget> createState() => _ItemState();
}

class _ItemState extends State<Item> with SingleTickerProviderStateMixin {
  late Music music;
  bool isUpdated = false;
  double playerBottom = Player.hidePositionFromBottom;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    music = widget.music;
    _tabController = TabController(length: 2, vsync: this);
  }

  void toggleFavoris() {
    ListingService.toggleFavorite(music.id, music.favoris == 0 ? 1 : 0)
        .then((value) {
      setState(() {
        music = value;
        isUpdated = true;
      });
    });
  }

  void togglePlayer() {
    double newPosition = Player.hidePositionFromBottom;
    if (playerBottom == Player.hidePositionFromBottom) {
      newPosition = Player.showPositionFromBottom;
    }
    setState(() {
      playerBottom = newPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(music.title),
        actions: <Widget>[
          IconButton(
            onPressed: toggleFavoris,
            icon: Icon(
              music.favoris == 1 ? Icons.favorite : Icons.favorite_border,
            ),
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(
            context,
            PushToItemData(isUpdated: isUpdated, music: music),
          );
          return false;
        },
        child: Stack(
          children: [
            Column(
              children: [
                TabBar(
                  unselectedLabelColor: Colors.black,
                  labelColor: Theme.of(context).colorScheme.secondary,
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 1.0,
                  indicatorColor: Theme.of(context).colorScheme.secondary,
                  tabs: const [
                    Tab(
                      text: 'Solfege',
                    ),
                    Tab(
                      text: 'Tononkira',
                    )
                  ],
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: playerBottom == Player.hidePositionFromBottom
                          ? 0
                          : 120,
                    ),
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        TabSolfege(pdf: music.pdf),
                        TabParole(parole: music.lyrics)
                      ],
                    ),
                  ),
                )
              ],
            ),
            AnimatedPositioned(
              child: Player(audio: '$audioPath/${music.audio}'),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutCirc,
              bottom: playerBottom,
              left: 0,
              right: 0,
            )
          ],
        ),
      ),
      floatingActionButtonLocation:
          playerBottom == Player.hidePositionFromBottom
              ? FloatingActionButtonLocation.endFloat
              : FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: togglePlayer,
        child: const Icon(Icons.music_note),
      ),
    );
  }
}
