import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_player/models/library_model.dart';
import 'package:music_player/models/recently_played_model.dart';

import 'package:music_player/screens/search_screen.dart';
import 'package:music_player/screens/see_all_recent_songs_screen.dart';
import 'package:music_player/utils/songs_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';




class LibraryPage extends StatefulWidget {
    Function? _miniPlayer;
    LibraryPage(this._miniPlayer);
   //const LibraryPage({Key? key}) : super(key: key);

  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {

  bool _isPlaying = false;
  List<AllSongs>? songsList = [];
  List<RecentlyPlayedSongs>? recentSongs = [];
  var songId;
  int currentPage = 1;
  final RefreshController refreshController = RefreshController(initialRefresh: false);


  Future getAllSongs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token") ?? "";

    var url = Uri.parse(
        'https://php71.indianic.com/odemusicapp/public/api/v1/user/songs',
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

      List<AllSongs>? result =
          AllSongsModel.fromJson(json.decode(response.body)).data?.allSongs;
      songsList?.addAll(result ?? []);
      currentPage++;
      setState(() {});
    } else {
      print(response.statusCode);
      print('No data');
    }
  }

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
      "page": 1,
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
      recentSongs?.clear();
      List<RecentlyPlayedSongs>? result =
          RecentlyPlayedModel.fromJson(json.decode(response.body)).data?.recentlyPlayedSongs;
      recentSongs?.clear();
      recentSongs?.addAll(result ?? []);
    

      setState(() {});
    } else {
      print(response.statusCode);
      print('No data');
    }
  }




  reloadData() async {
   // recentSongs?.clear();
    getRecentlyPlayedSongs();
    //recentSongs?.removeAt(0);
    }


  @override
  void initState() {
    getAllSongs();
    getRecentlyPlayedSongs();

    //getResentSongs();
    super.initState();
  }


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
                      getRecentlyPlayedSongs().then((value) => addResentSongs()).then((value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SeeAllSongs())));

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
              height: 210,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => recentSongCard(recentSongs![index]),
                  itemCount: recentSongs?.length),
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
                child: SmartRefresher(
                  controller: refreshController,
                  enablePullUp: true,
                  enablePullDown: false,

                  onLoading: () async{
                    final data = getAllSongs();
                    if(data==true){
                      refreshController.loadComplete();
                    }
                    else{
                      refreshController.loadFailed();
                    }
                  },
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => allSongsCard(songsList![index]),
                    itemCount: songsList?.length,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  recentSongCard(RecentlyPlayedSongs item) {
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
                    builder: (context) => SongsPlayer(
                          songImg: item.image800,
                          songTitle: item.songName,
                        ));
                // if(_isPlaying = true){
                //   widget._miniPlayer?.call(SongsPlayer(songTitle: item.resentSongTitle,songImg: item.recentImg,));}
              },
              child: SizedBox(
                width: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(9),
                  child: Image.network(
                    item.image150.toString(),
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
                child: Text(item.songName.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start),
              ),
            ),
          ],
        ),
      ),
    );
  }

  allSongsCard(AllSongs item) {
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
                  songImg: item.image800.toString(),
                  songTitle: item.songName,
                  songSubtitle: item.artistName,
                ),),).then((val) => val == true ? reloadData() : null);

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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item.songName.toString(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 5),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item.artistName.toString(),
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
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
