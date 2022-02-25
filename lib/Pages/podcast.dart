import 'package:flutter/material.dart';
import 'package:music_player/models/podcast_model.dart';
import 'package:music_player/screens/dashboard_screen.dart';
import 'package:music_player/screens/search_screen.dart';
import 'package:music_player/screens/see_all_podcast_featured_episods_screen.dart';
import 'package:music_player/screens/see_all_podcast_trending_screen.dart';
import 'package:music_player/utils/songs_player.dart';

class PodcastPage extends StatefulWidget {
  const PodcastPage({Key? key}) : super(key: key);

  @override
  _PodcastPageState createState() => _PodcastPageState();
}

class _PodcastPageState extends State<PodcastPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PODCAST',
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
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'WHATS TRENDING',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SeeAllPodcastTrending()));
                    },
                    child: Text(
                      'See All',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 249,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                      podcastTrendingListCard(items[index], context),
                  itemCount: items.length),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'FEATURED EPISODS',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllPodcastFeaturedEpisods()));

                    },
                    child: Text(
                      'All Podcasts',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 249,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                      podcastFeaturedListCard(items[index], context),
                  itemCount: items.length),
            ),
            Container(
              child: podcastAllGenres(),
            ),
          ],
        ),
      ),
    );
  }

  Padding podcastAllGenres() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 1, 15, 15),
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 99,
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
                    color: Colors.grey.shade900,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.mic_sharp,
                        size: 55,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DashboardScreen()));
                    },
                    child: Container(
                      color: Colors.white,
                      width: 150,
                      child: Text(
                        'ALL GENRES',
                        textAlign: TextAlign.left,
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DashboardScreen()));
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 28,
                        color: Colors.lightBlue,
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

podcastFeaturedListCard(PodcastModel item, BuildContext context) {
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
                        songImg: item.podcastFeaturedImg,
                        songTitle: item.podcastFeaturedTitle,
                        songSubtitle: item.podcastFeaturedSubtitle,
                      ));
            },
            child: SizedBox(
              width: 179,
              height: 179,
              child: Padding(
                padding: const EdgeInsets.only(right: 9),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(9),
                  child: Image.asset(
                    item.podcastFeaturedImg,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Container(
            width: 179,
            child: Text(item.podcastFeaturedTitle,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left),
          ),
          SizedBox(height: 5),
          Container(
            width: 179,
            child: Text(item.podcastFeaturedSubtitle,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700),
                textAlign: TextAlign.left),
          ),
        ],
      ),
    ),
  );
}

podcastTrendingListCard(PodcastModel item, BuildContext context) {
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
                        songImg: item.podcastTrendingImg,
                        songTitle: item.podcastTrendingTitle,
                        songSubtitle: item.podcastTrendingSubtitle,
                      ));
            },
            child: SizedBox(
              width: 179,
              height: 179,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(9),
                child: Image.asset(
                  item.podcastTrendingImg,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Container(
            width: 179,
            child: Text(item.podcastTrendingTitle,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left),
          ),
          SizedBox(height: 5),
          Container(
            width: 179,
            child: Text(
              item.podcastTrendingSubtitle,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
              textAlign: TextAlign.left,
              softWrap: false,
            ),
          ),
        ],
      ),
    ),
  );
}
