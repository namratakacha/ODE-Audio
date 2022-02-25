import 'package:flutter/material.dart';
import 'package:music_player/models/radio_model.dart';
import 'package:music_player/screens/search_screen.dart';
import 'package:music_player/screens/see_all_artist_radio_screen.dart';
import 'package:music_player/screens/see_all_radio_screen.dart';
import 'package:music_player/utils/radio_player.dart';

class RadioPage extends StatefulWidget {
  const RadioPage({Key? key}) : super(key: key);

  @override
  _RadioPageState createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'RADIO',
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
                    'FEATURED STATIONS',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SeeAllRadio()));
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
              height: 249,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                      radioListCard(items[index], context),
                  itemCount: items.length),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'FEATURED ARTIST RADIO',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SeeAllArtistRadio()));
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
              height: 249,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                      artistListCard(items[index], context),
                  itemCount: items.length),
            ),
          ],
        ),
      ),
    );
  }

  artistListCard(RadioModel item, BuildContext context) {
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
                    builder: (context) => RadioBottomSheet(
                          radioImg: item.artistImg,
                          radioTitle: item.artistTitle,
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
                      item.artistImg,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
              width: 179,
              child: Text(item.artistTitle,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left),
            ),
          ],
        ),
      ),
    );
  }
}

radioListCard(RadioModel item, BuildContext context) {
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
                  builder: (context) => RadioBottomSheet(
                        radioImg: item.radioImg,
                        radioTitle: item.radioTitle,
                        radioSubtitle: item.radioSubtitle,
                      ));
            },
            child: SizedBox(
              width: 179,
              height: 179,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(9),
                child: Image.asset(
                  item.radioImg,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Container(
            width: 179,
            child: Text(item.radioTitle,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left),
          ),
          SizedBox(height: 5),
          Container(
            width: 179,
            child: Text(
              item.radioSubtitle,
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
