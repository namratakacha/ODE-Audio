import 'package:flutter/material.dart';
import 'package:music_player/models/library_model.dart';
import 'package:music_player/screens/search_screen.dart';
import 'package:music_player/screens/see_all_recent_songs_screen.dart';
import 'package:music_player/utils/songs_player.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LIBRARY',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.lightBlue),
        ),
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: MySearchDelegate(),
                );
              },
              icon: Icon(
                Icons.search,
                color: Colors.lightBlue,
                size: 40,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(11),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'RECENTLY PLAYED',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SeeAllSongs()));
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 185,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => recentSongCard(items[index]),
                  itemCount: items.length),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15, left: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'ALL SONGS',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => allSongsCard(items[index]),
                  itemCount: items.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  recentSongCard(LibraryModel item) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, bottom: 9),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => BottomSheetPage(
                          songImg: item.recentImg,
                          songTitle: item.resentSongTitle,
                        ));
              },
              child: SizedBox(
                width: 149,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(9),
                  child: Image.asset(
                    item.recentImg,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
              width: 149,
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(item.resentSongTitle,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start),
              ),
            ),
          ],
        ),
      ),
    );
  }

  allSongsCard(LibraryModel item) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 1, 15, 15),
      child: Container(
        height: 99,
        child: InkWell(
          onTap: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => BottomSheetPage(
                      songImg: item.songImg,
                      songTitle: item.songTitle,
                      songSubtitle: item.subtitle,
                    ));
          },
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.lightBlue, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 79,
                    width: 79,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        item.songImg,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          item.songTitle,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          item.subtitle,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
