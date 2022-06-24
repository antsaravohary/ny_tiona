import 'package:flutter/material.dart';
import 'package:ny_tiona/components/about_dialog.dart';
import 'package:ny_tiona/components/badge.dart';
import 'package:ny_tiona/components/list_item.dart';
import 'package:ny_tiona/components/loading.dart';
import 'package:ny_tiona/models/music.dart';
import 'package:ny_tiona/models/push_to_item_data.dart';
import 'package:ny_tiona/screens/item.dart';
import 'package:ny_tiona/services/listing_service.dart';
import 'package:package_info/package_info.dart';

class Listing extends StatefulWidget {
  const Listing({Key? key}) : super(key: key);

  static const route = '/';

  @override
  State<Listing> createState() => _ListingState();
}

class _ListingState extends State<Listing> {
  List<Music> musics = [];
  bool loading = false;
  String appName = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });
    ListingService.get().then((data) {
      setState(() {
        musics = data;
      });
    }).whenComplete(() {
      setState(() {
        loading = false;
      });
    });
    PackageInfo.fromPlatform().then((packageInfo) {
      setState(() {
        appName = packageInfo.appName;
      });
    });
  }

  void toggleFavoris(int id) {
    int index = musics.indexWhere((element) => element.id == id);
    if (index != -1) {
      ListingService.toggleFavorite(id, musics[index].favoris == 0 ? 1 : 0)
          .then((value) {
        setState(() {
          musics[index] = value;
        });
      });
    }
  }

  void updateMusic(Music musicUpdate) {
    int index = musics.indexWhere((element) => element.id == musicUpdate.id);
    if (index != -1) {
      setState(() {
        musics[index] = musicUpdate;
      });
    }
  }

  void pushTo(Music music) async {
    final PushToItemData data = await Navigator.of(context)
        .pushNamed(Item.route, arguments: music) as PushToItemData;
    if (data.isUpdated) {
      updateMusic(data.music);
    }
  }

  void onMoreSelected(int button) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appName),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showAboutAppDialog(context);
            },
            icon: const Icon(Icons.info_outline_rounded),
          ),
          //// IconButton(
          //   onPressed: () {},
          //   icon: const Icon(Icons.search),
          // ),
          // ListingMore(onSelected: onMoreSelected)
        ],
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: loading
            ? const Loading()
            : Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Lisitr'ireo hira: ",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Badge(label: musics.length.toString()),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: musics.length,
                      itemBuilder: (context, i) {
                        return Column(
                          children: [
                            if (i != 0) const Divider(),
                            ListItem(
                              music: musics[i],
                              toggleFavoris: toggleFavoris,
                              pushTo: pushTo,
                            ),
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
