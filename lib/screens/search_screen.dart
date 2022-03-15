import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_player/models/recently_search_model.dart';
import 'package:music_player/models/search_song_model.dart';
import 'package:music_player/utils/songs_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MySearchDelegate extends SearchDelegate {

  List<Songs>? songs = [];
  var songId;


  List<RecentlySearchSongs>? recentlySearchSongs = [];
  bool isRecentVisible = false;

  Future<List<Songs>?> getAllSearchSong() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token") ?? "";

    var url = Uri.parse(
        'https://php71.indianic.com/odemusicapp/public/api/v1/search/song?name=The Full Ticket');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      print(response.body);
      songs?.clear();
      List<Songs>? result =
          SearchSongModel.fromJson(json.decode(response.body)).data?.songs;

      songs?.addAll(result ?? []);

    } else {
      print(response.statusCode);
      print('No data');
    }
  }

  Future getResentSearchSongs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token") ?? "";

    var url = Uri.parse(
        'https://php71.indianic.com/odemusicapp/public/api/v1/addrecentlysearchsong');
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
    } else {
      songId = songId;
      print(response.statusCode);
      print('song not added');
    }
  }

  Future getAllRecentlySearchSongs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token") ?? "";

    var url = Uri.parse(
      'https://php71.indianic.com/odemusicapp/public/api/v1/getallrecentlysearchsong',
    );
    final page = jsonEncode({
      "all": 1,
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
      recentlySearchSongs?.clear();

      List<RecentlySearchSongs>? result =
          RecentlySearchSongModel.fromJson(json.decode(response.body)).data?.recentlySearchSongs;
      recentlySearchSongs?.addAll(result ?? []);

    } else {
      print(response.statusCode);
      print('No data');
    }
  }

  reloadData() async {
   // recentlySearchSongs?.clear();
    getAllRecentlySearchSongs();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: (query.isEmpty)? SizedBox() : Icon(Icons.cancel)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back_ios),
    );
  }



  @override
  Widget buildResults(BuildContext context) {

    List<Songs>? songsSuggestions = query.isEmpty? songs: songs?.where((e) {
      var result = e.songName?.toLowerCase();
      var input = query.toLowerCase();
      return result!.startsWith(input);
    }).toList();

    return FutureBuilder<List<Songs>?>(
      future: getAllSearchSong(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) =>
                  songsList(songsSuggestions!.elementAt(index), context),
              itemCount: songsSuggestions?.length,
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
    getAllSearchSong();
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    List<Songs>? songsSuggestions = query.isEmpty? songs: songs?.where((e) {
      var result = e.songName?.toLowerCase();
      var input = query.toLowerCase();
      return result!.startsWith(input);
    }).toList();

    return FutureBuilder(
      future: getAllRecentlySearchSongs().then((value) => reloadData()).then((value) => getAllSearchSong()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {

          return Scaffold(
            body: Container(
              child: Column(
                children: [
                  Visibility(
                    visible: query.isEmpty? isRecentVisible: !isRecentVisible,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 5, left: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'RECENT SEARCHES',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: query.isEmpty? isRecentVisible: !isRecentVisible,
                    child: Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            recentSearchList(recentlySearchSongs![index], context),
                        itemCount: recentlySearchSongs?.length,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 5, left: 15),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'ALL SONGS',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Visibility(
                      visible : true,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            songsList(songsSuggestions!.elementAt(index), context),
                        itemCount: songsSuggestions?.length,

                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  recentSearchList(RecentlySearchSongs item, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Container(
        height: 93,
        child: InkWell(
          onTap: () {
            getAllRecentlySearchSongs().then((value) => showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => SongsPlayer(
                  songImg: item.image800,
                  songTitle: item.songName,
                  songSubtitle: '',
                )));

            query = item.songName.toString();
            showResults(context);
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
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                    color: Colors.white,
                    width: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item.songName.toString(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                           '',
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

  songsList(Songs item, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Container(
        height: 93,
        child: InkWell(
          onTap: () {
            songId = item.id;
            getResentSearchSongs().then((value) => showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => SongsPlayer(
                  songImg: item.image800,
                  songTitle: item.songName,
                  songSubtitle: item.artistName,
                )).then((val) => val == true ? reloadData() : null));

            query = item.songName.toString();
            showResults(context);
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
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                    color: Colors.white,
                    width: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item.songName.toString(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item.artistName.toString(),
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 14),
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
