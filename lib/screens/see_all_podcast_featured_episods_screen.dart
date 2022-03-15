import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_player/Pages/podcast.dart';
import 'package:music_player/models/all_podcast_model.dart';
import 'package:music_player/models/podcast_model.dart';
import 'package:music_player/screens/search_screen.dart';
import 'package:music_player/utils/songs_player.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class AllPodcastFeaturedEpisods extends StatefulWidget {
  const AllPodcastFeaturedEpisods({Key? key}) : super(key: key);

  @override
  _AllPodcastFeaturedEpisodsState createState() => _AllPodcastFeaturedEpisodsState();
}

class _AllPodcastFeaturedEpisodsState extends State<AllPodcastFeaturedEpisods> {

  final List<Podcasts>? allPodcasts = [];

  Future getAllPodcast() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token") ?? "";

    var url = Uri.parse(
        'https://php71.indianic.com/odemusicapp/public/api/v1/allpodcast');
    final page = jsonEncode({
      "is_featured": 1,
      "limit": 10,
    });
    final response = await http.post(url,
        body: page,
        headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      print(response.body);
      allPodcasts?.clear();
      List<Podcasts>? resultFeatured =
          AllPodcastModel.fromJson(json.decode(response.body)).data?.podcasts;
      allPodcasts?.addAll(resultFeatured ?? []);
      setState(() {});
    } else {
      print(response.statusCode);
      print('No data');
    }
  }


  @override
  void initState() {
    getAllPodcast();
    super.initState();
  }
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
            itemBuilder: (context, index) => allFeaturedPodcastCard(allPodcasts![index]),
            itemCount: allPodcasts?.length,
          ),
        ),
      ),
    );
  }

  allFeaturedPodcastCard(Podcasts item) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 1, 15, 15),
      child: Container(
        height: 99,
        child: InkWell(
          onTap: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => SongsPlayer(
                  songImg: item.profileimageUrl,
                  songTitle: item.name,
                  songSubtitle: item.shortDescription,
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
                      child: Image.network(
                        item.profileimageThumbUrl.toString(),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item.name.toString(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item.shortDescription.toString(),
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
                          ),
                        ),
                      ],
                    ),
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
