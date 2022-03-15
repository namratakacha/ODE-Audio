import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:app_settings/app_settings.dart';
import 'package:music_player/models/library_model.dart';




class SongsPlayer extends StatefulWidget {
  String? songTitle;
  String? songImg;
  String? songSubtitle;
  Function? miniPlayer2;

  SongsPlayer({Key? key, this.songTitle, this.songImg, this.songSubtitle, this.miniPlayer2})
      : super(key: key);

  @override
  _SongsPlayerState createState() => _SongsPlayerState();
}

class _SongsPlayerState extends State<SongsPlayer> {
  bool _isPaused = false;
  bool _isPlaying = false;
  bool isMuted = false;
  bool isShuffled = false;
  var audio = AudioPlayer();
  Duration _duration = Duration();
  Duration _position = Duration();


  Future play() async {
    int result = await audio.play(
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-13.mp3');
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.audio.onDurationChanged.listen((Duration d) {

      setState(() => _duration = d);
    });
    this.audio.onAudioPositionChanged.listen((Duration p) {

      setState(() => _position = p);
    });
    this.audio.onPlayerCompletion.listen((event){
      setState(() {
        _position = Duration(seconds: 0);
        _isPlaying = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      builder: (context, ScrollController) => Column(
        children: [
          Container(
            color: Colors.white,
            height: 100,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(3, 21, 8, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      if(_isPlaying=true){
                        widget.miniPlayer2;
                      }
                      audio.stop();
                      Navigator.pop(context, true);
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 45,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(

                            width: 285,
                            child: Text(
                              widget.songTitle ?? '',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey.shade600),
                            ),
                          ),
                        ),
                        Text(
                          widget.songSubtitle ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14, color: Colors.blueGrey.shade600),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.share,
                          size: 30,
                          color: Colors.lightBlue,
                        )),
                  )
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
            color: Colors.blue.shade200,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.lightBlue.shade100,
                  Colors.lightBlue.shade200,
                  Colors.lightBlue.shade400,
                  Colors.lightBlue,
                  Colors.lightBlue,
                  Colors.lightBlue.shade500,
                  Colors.blueGrey.shade900,
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
              child: ListView(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Container(
                        height: 330,
                        width: 330,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(widget.songImg ??
                                  ''),
                              fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 25,
                              spreadRadius: 6,
                              //offset: Offset(1, 5),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                        activeTrackColor: Colors.blueGrey.shade800,
                        inactiveTrackColor: Colors.white,
                        trackHeight: 7,
                        thumbColor: Colors.blueGrey.shade800,
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 4)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 30, 5, 3),
                      child: Container(
                        width: 300,
                        height: 10,
                        child: Slider(
                          min: 0.0,
                          max: _duration.inSeconds.toDouble(),
                          value: _position.inSeconds.toDouble(),
                          onChanged: (double value) {
                            setState(() {
                              changeToSecond(value.toInt());
                              value = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_position.toString().split('.')[0]),
                        Text(_duration.toString().split('.')[0]),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.songTitle ?? '',
                              style:
                                  TextStyle(color: Colors.blueGrey.shade900),
                            ),
                            Text(
                              widget.songSubtitle ?? '',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Stack(
                          children:[
                            Visibility(
                              visible: !isShuffled,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isShuffled = !isShuffled;
                                  });
                                },
                                icon: Icon(
                                  Icons.shuffle_on_outlined,
                                  color: Colors.blueGrey.shade900,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: isShuffled,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isShuffled = !isShuffled;
                                  });
                                },
                                icon: Icon(
                                  Icons.shuffle_outlined,
                                  color: Colors.blueGrey.shade900,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () async{
                                 await audio.seek(Duration(seconds: _position.inSeconds - 15));
                                },
                                icon: Icon(
                                  Icons.fast_rewind,
                                  size: 50,
                                  color: Colors.white,
                                )),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 25, left: 25),
                              child: IconButton(
                                icon: (_isPlaying)
                                    ? Icon(
                                        Icons.pause_circle_outline,
                                        size: 50,
                                        color: Colors.white,
                                      )
                                    : Icon(
                                        Icons.play_circle_outline,
                                        size: 50,
                                        color: Colors.white,
                                      ),
                                onPressed: () => _isPlaying
                                    ? pause()
                                    : _isPaused
                                        ? resume()
                                        : play(),
                              ),
                            ),

                            IconButton(
                                onPressed: () async{
                                  await audio.seek(Duration(seconds: _position.inSeconds + 15));
                                },
                                icon: Icon(
                                  Icons.fast_forward,
                                  size: 50,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, right: 8),
                          child: Stack(
                            children: [
                              Visibility(
                                visible: !isMuted,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      audio.setVolume(0.0);
                                      isMuted = !isMuted;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.volume_up_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: isMuted,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      audio.setVolume(1.0);
                                      isMuted = !isMuted;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.volume_off_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 50, left: 20),
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            AppSettings.openBluetoothSettings();
                          },
                          icon: Icon(
                            Icons.wifi_tethering,
                            color: Colors.grey.shade900,
                            size: 30,
                          ),
                        ),
                        Text(
                          'Devices Available',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
