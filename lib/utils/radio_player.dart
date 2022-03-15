import 'package:flutter/material.dart';

class RadioBottomSheet extends StatefulWidget {
  String? radioTitle;
  String? radioImg;
  String? radioSubtitle;
  RadioBottomSheet(
      {Key? key, this.radioTitle, this.radioImg, this.radioSubtitle})
      : super(key: key);

  @override
  _RadioBottomSheetState createState() => _RadioBottomSheetState();
}

class _RadioBottomSheetState extends State<RadioBottomSheet> {

  bool isVisible = false;

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
              padding: const EdgeInsets.fromLTRB(8, 21, 8, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
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
                        Text(
                          widget.radioTitle ?? '',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey.shade600),
                        ),
                        Text(
                          widget.radioSubtitle ?? '',
                          style: TextStyle(
                              fontSize: 14, color: Colors.blueGrey.shade600),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.share,
                        size: 30,
                        color: Colors.lightBlue,
                      ))
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
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: ListView(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 330,
                        width: 330,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(widget.radioImg ??
                                  'assets/images/temp/library_recent_one.jpg'),
                              fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 25,
                              spreadRadius: 6,
                              offset: Offset(1, 5),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 75, right: 20),
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.fast_rewind,
                                    size: 50,
                                    color: Colors.white,
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 25, left: 25),
                                child: Stack(
                                    children: [
                                      Visibility(
                                        visible: !isVisible,
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isVisible = !isVisible;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.play_circle_outline,
                                            size: 50,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: isVisible,
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isVisible = !isVisible;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.pause_circle_outline,
                                            size: 50,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.fast_forward,
                                    size: 50,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.volume_up_rounded,
                                  color: Colors.white,
                                )),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 75, left: 10),
                      child: Column(
                        children: [
                          IconButton(
                            onPressed: () {},
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
            ),
          )
        ],
      ),
    );
  }
}
