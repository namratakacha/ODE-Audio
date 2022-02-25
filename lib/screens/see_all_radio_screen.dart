import 'package:flutter/material.dart';
import 'package:music_player/Pages/radio.dart';
import 'package:music_player/models/radio_model.dart';
import 'package:music_player/screens/search_screen.dart';
import 'package:music_player/utils/radio_player.dart';

class SeeAllRadio extends StatefulWidget {
  const SeeAllRadio({Key? key}) : super(key: key);

  @override
  _SeeAllRadioState createState() => _SeeAllRadioState();
}

class _SeeAllRadioState extends State<SeeAllRadio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FEATURED STATIONS',
          style: TextStyle(
              fontSize: 22,
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
            Navigator.pop(
                context,
                MaterialPageRoute(
                    builder: (context) => RadioPage()));
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
          ),),),
    );
  }
  allSongsCard(RadioModel item) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 1, 15, 15),
      child: Container(
        height: 99,
        child: InkWell(
          onTap: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => RadioBottomSheet(
                  radioImg: item.radioImg,
                  radioTitle: item.radioTitle,
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
                        item.radioImg,
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
                          item.radioTitle,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          item.radioSubtitle,
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

