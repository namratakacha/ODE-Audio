import 'package:flutter/material.dart';
import 'package:music_player/Pages/podcast.dart';
import 'package:music_player/models/podcast_model.dart';
import 'package:music_player/screens/search_screen.dart';
import 'package:music_player/utils/songs_player.dart';

class AllPodcastFeaturedEpisods extends StatefulWidget {
  const AllPodcastFeaturedEpisods({Key? key}) : super(key: key);

  @override
  _AllPodcastFeaturedEpisodsState createState() => _AllPodcastFeaturedEpisodsState();
}

class _AllPodcastFeaturedEpisodsState extends State<AllPodcastFeaturedEpisods> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FEATURED EPISODS',
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context,
                MaterialPageRoute(builder: (context) => PodcastPage()));
          },
          icon: Padding(
            padding: const EdgeInsets.only(left: 11),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
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
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) => allSongsCard(items[index]),
            itemCount: items.length,
          ),
        ),
      ),
    );
  }

  allSongsCard(PodcastModel item) {
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
                  songImg: item.podcastFeaturedImg,
                  songTitle: item.podcastFeaturedTitle,
                  songSubtitle: item.podcastFeaturedSubtitle,
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
                        item.podcastFeaturedImg,
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
                          item.podcastFeaturedTitle,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          item.podcastFeaturedSubtitle,
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
