import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_player/models/recently_played_model.dart';
import 'package:music_player/screens/search_screen.dart';
import 'package:music_player/utils/songs_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SeeAllSongs extends StatefulWidget {
  const SeeAllSongs({Key? key}) : super(key: key);

  @override
  _SeeAllSongsState createState() => _SeeAllSongsState();
}

class _SeeAllSongsState extends State<SeeAllSongs> {
  List<RecentlyPlayedSongs>? recentSongs = [];
  int currentPage = 1;
  RefreshController refreshController = RefreshController();
  var songId;

  Future addResentSongs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token") ?? "";

    var url = Uri.parse(
        'https://php71.indianic.com/odemusicapp/public/api/v1/addrecentlyplayedsong');
    final page = jsonEncode({
      "id": songId,

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
      print('song added succesfullly');
      songId = songId;
      setState(() {});
    } else {
      songId = songId;
      print(response.statusCode);
      print('song not added');
    }
  }

  Future getRecentlyPlayedSongs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token") ?? "";

    var url = Uri.parse(
      'https://php71.indianic.com/odemusicapp/public/api/v1/getallrecentlyplayedsong',
    );
    final page = jsonEncode({
      "limit": 10,
      "page": currentPage,
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
   //   recentSongs?.removeLast();
    //  recentSongs?.clear();
      List<RecentlyPlayedSongs>? result =
          RecentlyPlayedModel.fromJson(json.decode(response.body)).data?.recentlyPlayedSongs;

      recentSongs?.addAll(result ?? []);
      currentPage++;

      setState(() {});
    } else {
      print(response.statusCode);
      print('No data');
    }
  }

  @override
  void initState() {
    addResentSongs();
    getRecentlyPlayedSongs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'RECENTLY PLAYED',
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
            Navigator.pop(context);
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
          child: SmartRefresher(
            controller: refreshController,
            enablePullUp: true,
            enablePullDown: false,
            onLoading: () async{
              final data = getRecentlyPlayedSongs();
              if(data==true){
                refreshController.loadComplete();
              }
              else{
                refreshController.loadNoData();
              }
            },
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) => allSongsCard(recentSongs![index]),
              itemCount: recentSongs?.length,
            ),
          ),
        ),
      ),
    );
  }

  allSongsCard(RecentlyPlayedSongs item) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 1, 15, 15),
      child: Container(
        height: 99,
        child: InkWell(
          onTap: () {
            songId = item.id;
            addResentSongs().then((value) => showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => SongsPlayer(
                  songImg: item.image800,
                  songTitle: item.songName,

                )));

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
                        item.image150.toString(),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      item.songName.toString(),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: false,
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
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
