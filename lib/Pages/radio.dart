import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_player/models/radio_model.dart';
import 'package:music_player/screens/search_screen.dart';
import 'package:music_player/screens/see_all_radio_screen.dart';
import 'package:music_player/utils/radio_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RadioPage extends StatefulWidget {
  const RadioPage({Key? key}) : super(key: key);

  @override
  _RadioPageState createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage> {

  List<RadioList>? radioList = [];
  int currentPage = 1;
  // int totalPages = 10;
  final RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    getRadioList();

    super.initState();
  }

  Future getRadioList() async {
    // if(isRefresh){
    //   currentPage = 1;
    // }else{
    //   if(currentPage>=totalPages){
    //     refreshController.loadNoData();
    //     return false;
    //   }
    // }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token") ?? "";

    var url = Uri.parse(
      'https://php71.indianic.com/odemusicapp/public/api/v1/allradio',
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
     // radioList?.clear();
      List<RadioList>? result = RadioModel.fromJson(json.decode(response.body)).data?.radio;
      radioList?.addAll(result ?? []);
      currentPage++;
      //totalPages = result![totalPages] as int;

      setState(() {});
    } else {
      print(response.statusCode);
      print('No data');
    }
  }

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
        child: Column(
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
                      getRadioList().then((value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SeeAllRadio())));
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
            Expanded(
              child: SmartRefresher(
                controller: refreshController,
                enablePullUp: true,
                enablePullDown: false,
                // onRefresh: () async{
                //   final data = getRadioList();
                //   if(data==true){
                //     refreshController.refreshCompleted();
                //   }
                //   else{
                //     refreshController.refreshFailed();
                //   }
                // },
                onLoading: () async{
                  final data = getRadioList();
                  if(data==true){
                    refreshController.loadComplete();
                  }
                  else{
                    refreshController.loadNoData();
                  }
                },
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 15,childAspectRatio: 0.80),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,

                    itemBuilder: (context, index) =>
                        radioListCard(radioList![index], context),
                    itemCount: radioList?.length),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 15, bottom: 3),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         'FEATURED ARTIST RADIO',
            //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            //       ),
            //       TextButton(
            //         onPressed: () {
            //           Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => SeeAllArtistRadio()));
            //
            //         },
            //         child: Text(
            //           'See All',
            //           style: TextStyle(
            //               color: Colors.lightBlue,
            //               fontSize: 16,
            //               fontWeight: FontWeight.bold),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // Container(
            //   height: 249,
            //   child: ListView.builder(
            //       shrinkWrap: true,
            //       scrollDirection: Axis.horizontal,
            //       itemBuilder: (context, index) =>
            //           artistListCard(items[index], context),
            //       itemCount: items.length),
            // ),
          ],
        ),
      ),
    );
  }

//   artistListCard(RadioModel1 item, BuildContext context) {
//     return Container(
//       child: Padding(
//         padding: const EdgeInsets.only(left: 15, bottom: 9),
//         child: Column(
//           children: [
//             InkWell(
//               onTap: () {
//                 showModalBottomSheet(
//                     isScrollControlled: true,
//                     context: context,
//                     builder: (context) => RadioBottomSheet(
//                           radioImg: item.artistImg,
//                           radioTitle: item.artistTitle,
//                         ));
//               },
//               child: SizedBox(
//                 width: 179,
//                 height: 179,
//                 child: Padding(
//                   padding: const EdgeInsets.only(right: 9),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(9),
//                     child: Image.asset(
//                       item.artistImg,
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 5),
//             Container(
//               width: 179,
//               child: Text(item.artistTitle,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   textAlign: TextAlign.left),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

radioListCard(RadioList item, BuildContext context) {
  return Column(
   // mainAxisSize: MainAxisSize.max ,
    children: [
      InkWell(
      onTap: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => RadioBottomSheet(
                  radioImg: item.profileimageUrl,
                  radioTitle: item.name,
                  radioSubtitle: item.shortDescription,
                  radioLink: item.link,
                ));
      },
      child: Container(
        height: 190,
        width: 190,
        child: Card(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Image.network(
              item.profileimageUrl.toString(),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),

        ),
      SizedBox(height: 5),
      Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Container(
          width: 190,
          child: Text(item.name.toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left),
        ),
      ),
      SizedBox(height: 5),
      Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Container(
          width: 190,
          child: Text(item.shortDescription.toString(),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade800,
              ),
              textAlign: TextAlign.left),
        ),
      ),
    ],
  );
}
}
