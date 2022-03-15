import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_player/models/library_model.dart';
import 'package:music_player/screens/bottom_navigation.dart';
import 'package:music_player/models/dashboard_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';


class DashboardScreen extends StatefulWidget {
  final bool? IsChecked;

  DashboardScreen({Key? key, this.IsChecked}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Data1>? musicList = [];
  List<AllSongs>? songsList = [];
  int currentPage = 1;
  bool isLoading = false;
  bool isSelected = false;
  late List<bool> IsChecked =
      List<bool>.generate(musicList!.length, (index) => false);
  bool shimmerEnabled = false;


  Future getAllGenres() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token") ?? "";

    var url = Uri.parse(
        'https://php71.indianic.com/odemusicapp/public/api/v1/allgenres');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      print(response.body);

      List<Data1>? result =
          AllGenresModel.fromJson(json.decode(response.body)).data;
      result?.removeLast();
      musicList?.addAll(result ?? []);

      setState(() {});
    } else {
      print(response.statusCode);
      print('No data');
    }
  }

  // getEffect()async{
  //   setState(() async{
  //     isLoading = true;
  //   });
  //   await Future.delayed(Duration(seconds: 2));
  //   setState(() {
  //     isLoading = false;
  //   });
  // }


  @override
  void initState() {
    getAllGenres();
    super.initState();
    //getEffect();
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
           // isLoading
           //     ? Expanded(child: Padding(
           //   padding: const EdgeInsets.only(left: 10, right: 10),
           //   child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
           //       crossAxisCount: 2,
           //       crossAxisSpacing: 5,
           //       mainAxisSpacing: 20),
           //       itemCount: 21,
           //       itemBuilder: (context, index){
           //     return Shimmer.fromColors(
           //     baseColor: Colors.red,
           //       highlightColor: Colors.yellow,
           //       child: Container(
           //         child: Card(
           //         shape: RoundedRectangleBorder(
           //         borderRadius: BorderRadius.circular(10),
           // ),),
           //       ),
           //     );
           // }),
           // ))
           Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 20),
                  itemCount: musicList?.length,
                  itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  musicList![index].profileimageUrl.toString(),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            Center(
                                child: Text(
                                  musicList![index].name.toString(),
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                )),
                            Positioned(
                              right: 1,
                              top: 1,
                              child: Transform.scale(
                                scale: 1.3,
                                child: Checkbox(
                                  value: IsChecked[index],
                                  activeColor: Colors.lightBlue,
                                  shape: CircleBorder(),
                                  side: MaterialStateBorderSide.resolveWith(
                                        (states) =>
                                        BorderSide(
                                            width: 1.0,
                                            color: Colors.lightBlue),
                                  ),
                                  onChanged: (newValue) {
                                    setState(() {
                                      IsChecked[index] = newValue!;
                                    });
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }
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
                               // getAllSongs().then((value) =>
                                    Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LibraryScreen())
                               // )
                                );

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

// musicOptionsList(Data allData) {
//   return Stack(
//
//     children:[
//       Card(
//       child: InkWell(
//         onTap: () {
//           setState(
//             () {
//               //isSelected = !isSelected;
//               //isSelected = !isSelected;
//             },
//           );
//         },
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child: Image.network(
//             allData.profileimageUrl.toString(),
//             fit: BoxFit.fill,
//           ),
//         ),
//       ),
//     ),
//       Checkbox(value: IsChecked[index],
//         onChanged: (newValue) {
//         setState(() {
//           IsChecked[index] = newValue!;
//         });
//       },)
//   ],
//   );
// }
}
