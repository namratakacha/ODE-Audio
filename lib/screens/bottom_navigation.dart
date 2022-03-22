import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:music_player/Pages/account.dart';
import 'package:music_player/Pages/library.dart';
import 'package:music_player/Pages/podcast.dart';
import 'package:music_player/Pages/radio.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:app_settings/app_settings.dart';
import 'package:music_player/models/library_model.dart';
import 'package:music_player/utils/songs_player.dart';
import 'package:miniplayer/miniplayer.dart';

class LibraryScreen extends StatefulWidget {
  String? songTitle;
  int? selectedIndex= 0;
  LibraryScreen({
    Key? key,
    this.songTitle,
    this.selectedIndex

  }) : super(key: key);

  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  int _selectedIndex = 0;
  bool _isPaused = false;
  bool _isPlaying = false;
  var audio = AudioPlayer();
  Duration _duration = Duration();
  Duration _position = Duration();
  num value = 0;

  var Tabs = <Widget>[
    // LibraryPage(),
    // RadioPage(),
    // PodcastPage(),
    // MyAccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future play() async {
    int result = await audio.play(
        'https://github.com/raveena2705/asset/blob/master/Nit_Nit_-_(amlijatt.in)%5B1%5D.mp3?raw=true');
    if (result == 1) {
      setState(() {
        _isPlaying = true;
      });
    }
  }

  Future pause() async {
    int result = await audio.pause();
    if (result == 1) {
      setState(() {
        _isPlaying = false;
      });
    }
  }

  Future resume() async {
    int result = await audio.resume();
    if (result == 1) {
      setState(() {
        _isPlaying = true;
      });
    }
  }

  void changeToSecond(int second){
    Duration newDuration = Duration(seconds: second);
    this.audio.seek(newDuration);
  }

  SongsPlayer? songsPlayer;

  Widget miniPlayer(SongsPlayer? songsPlayer) {
    this.songsPlayer = songsPlayer;
    setState(() {});
    if (songsPlayer == null) {
      return SizedBox();
    }
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => SongsPlayer(
                  songImg: songsPlayer.songImg,
                  songTitle: songsPlayer.songTitle,
                  songSubtitle: songsPlayer.songSubtitle,
                ));
      },
      child: Dismissible(
        key: UniqueKey(),
        onDismissed: (_) => audio.stop().then((value) => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LibraryScreen()))),

        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFF21444D),
              Color(0xFF148EA6),
            ], begin: Alignment.centerLeft, end: Alignment.centerRight),
          ),

          width: double.infinity,
          height: 90,
          child: ListView(
            children: [
              TweenAnimationBuilder(tween: Tween(begin: 0.0, end: 1,), duration: Duration(seconds: 10), builder: (context, value, _)=>
                  LinearProgressIndicator(value: 0 ,valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlue),),
              ),
              ListTile(
                leading: IconButton(
                  icon: (_isPlaying)
                      ? Icon(
                          Icons.pause_circle_outline,
                          size: 42,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.play_circle_outline,
                          size: 42,
                          color: Colors.white,
                        ),
                  onPressed: () {

                    _isPlaying
                      ? pause()
                      : _isPaused
                          ? resume()
                          : play();
                    downloadData();

                  }
                ),
                title: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: Center(
                      child: Text(
                        songsPlayer.songTitle ?? 'hi',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                trailing: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 30,
                    width: 30,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        songsPlayer.songImg ?? '',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      AppSettings.openBluetoothSettings();
                    },
                    icon: Icon(
                      Icons.wifi_tethering,
                      color: Colors.lightBlue.shade100,
                      size: 20,
                    ),
                  ),
                  Text(
                    'Devices Available',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.lightBlue.shade100,
                    ),
                  ),
                ],
              ),
            ],
          ),
          //
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.selectedIndex ?? 0;
    Tabs = [
      LibraryPage(miniPlayer),
      RadioPage(),
      PodcastPage(),
      MyAccountPage(),
    ];
    // this.audio.onDurationChanged.listen((Duration d) {
    //
    //   setState(() => _duration = d);
    // });
    // this.audio.onAudioPositionChanged.listen((Duration p) {
    //
    //   setState(() => _position = p);
    // });
    // this.audio.onPlayerCompletion.listen((event){
    //   setState(() {
    //     _position = Duration(seconds: 0);
    //     _isPlaying = false;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: IndexedStack(
      index: _selectedIndex,
        children: Tabs,

        // ..add(
        //   Offstage(
        //     offstage: songsPlayer==null,
        //     child: Miniplayer(
        //         minHeight: 90,
        //         maxHeight: MediaQuery.of(context).size.height,
        //         builder: (height, percentage){
        //           return Container();
        //         }
        //     )),
        //   )

        ),
      bottomNavigationBar: Column(

        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          // Container(
          //   height: 26,
          //   width: MediaQuery.of(context).size.width,
          //   child: Slider(
          //   min: 0.0,
          //   max: _duration.inSeconds.toDouble(),
          //   value: _position.inSeconds.toDouble(),
          //   onChanged: (double value) {
          //     setState(() {
          //       changeToSecond(value.toInt());
          //       value = value;
          //     });
          //   },
          // ),),


          miniPlayer(songsPlayer),
          Divider(
            color: Colors.white,
            height: 1,
          ),
          BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.library_music_sharp,
                  ),
                  label: 'Library',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.wifi_tethering),
                  label: 'Radio',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.mic),
                  label: 'Poadcast',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'My Account',
                ),
              ],
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.lightBlue.shade100.withOpacity(0.7),
              backgroundColor: Color(0xFF19BFDE),
              iconSize: 29,
              onTap: _onItemTapped,
              elevation: 5),
        ],
      ),
    );
  }
  void downloadData(){
    new Timer.periodic(
        Duration(seconds: 1),
            (Timer timer){
          setState(() {
            if(value == 1) {
              timer.cancel();
            }
            else {
              value =_duration.inSeconds.toDouble();
            }
          });
        }
    );
  }
}

