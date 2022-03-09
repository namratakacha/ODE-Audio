
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_player/screens/bottom_navigation.dart';
import 'package:music_player/models/dashboard_model.dart';
import 'package:http/http.dart' as http;

class DashboardScreen extends StatefulWidget {

const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  List<Data>? musicList = [];
  bool isSelected = false;

    Future getAllGenres() async{

    var url = Uri.parse('https://php71.indianic.com/odemusicapp/public/api/v1/allgenres');
    var response = await http.get(url);
    if(response.statusCode==200){
      print(response.body);

     final result = AllGenresModel.fromJson(json.decode(response.body));
      return musicList = result.data;

    }else{
      print('No data');
    }
    }


  @override
  void initState() {
    getAllGenres();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'What genres do you listen to?',
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
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              'You may select upto 3 or more',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child:
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 20),
                  itemCount: musicList?.length,
                  itemBuilder: (context, index) => musicOptionsList(musicList![index]),
                ),
              ),
            ),
            Container(
              color: Colors.lightBlue,
              height: 80,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: SizedBox(
                          height: 50,
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: Colors.white),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LibraryScreen()));
                              },
                              child: Text(
                                'Skip',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.grey[800],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LibraryScreen()));
                            },
                            child: Text(
                              'Done',
                              style: TextStyle(fontSize: 16),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  musicOptionsList(Data allData) {
    return Card(
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          InkWell(
            onTap: () {
              setState(
                () {
                  isSelected = !isSelected;
                },
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                allData.profileimageThumbUrl.toString(),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Transform.scale(
            scale: 1.4,
            child: Checkbox(
              side: MaterialStateBorderSide.resolveWith(
                (states) => BorderSide(width: 1.5, color: Colors.lightBlue),
              ),
              value: isSelected,
              shape: CircleBorder(),
              onChanged: (value) {
                setState(
                  () {
                    isSelected = !isSelected;
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
