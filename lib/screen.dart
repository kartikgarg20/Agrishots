import 'dart:convert';
// import 'dart:html';
// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_apps/models/agri_model.dart';
import 'package:http/http.dart' as http;
import 'package:new_apps/screen2.dart';
import 'package:platform_device_id/platform_device_id.dart';

class MyScreen extends StatefulWidget {
  MyScreen({Key? key}) : super(key: key);

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  List<Datum> apiList = [];
  // String? deviceId;
  // Future<String?> _getInfo() async {
  //   // Get device id
  //   deviceId = await PlatformDeviceId.getDeviceId;
  //   return deviceId;

  //   // Update the UI
  // }

//   Future<String?> _getId() async {
//     var deviceInfo = DeviceInfoPlugin();
//     if (Platform.isAndroid) {
//       var androidDeviceInfo = await deviceInfo.androidInfo;
// //       print(androidDeviceInfo.version);
// // print(androidDeviceInfo.board);
// // print(androidDeviceInfo.bootloader);
// // print(androidDeviceInfo.brand);
// // print(androidDeviceInfo.device);
//       return androidDeviceInfo.; // unique ID on Android
//     }
//   }

  Future<List<Datum>> getAgriList() async {
    // deviceId = await _getInfo();
    // print(deviceId);
    final reponse = await http.get(
      Uri.parse('https://api.dev.agrishots.in/articles?page=1&perPage=15'),
    );
    var data = jsonDecode(reponse.body.toString());

    if (reponse.statusCode == 200) {
      for (Map<String, dynamic> i in data['data']) {
        apiList.add(Datum.fromJson(i));
        print(i);
      }
      return apiList;
    } else {
      return apiList;
    }
  }

  late List<String> newsBookmarked = List.filled(apiList.length, 'false');
  late List<bool> bookmarkButton = List.filled(apiList.length, false);

  var agriFetched;

  @override
  void initState() {
    super.initState();
    agriFetched = getAgriList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agrishots'),
        toolbarHeight: 80,
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: agriFetched,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return PageView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: apiList.length,
                      itemBuilder: (context, index) {
                        print(apiList.length.toString());
                        return Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Image.network(apiList[index].mediaslug),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      apiList[index].title,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Agrishots',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          apiList[index].createdAt.toString(),
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.share,
                                              color: Colors.white),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                bookmarkButton[index] =
                                                    !bookmarkButton[index];
                                                bookmarkButton[index]
                                                    ? newsBookmarked[index] =
                                                        apiList[index].id
                                                    : newsBookmarked[index] =
                                                        'false';
                                                print(newsBookmarked);
                                              });
                                            },
                                            icon: bookmarkButton[index]
                                                ? Icon(Icons.bookmark_added,
                                                    color: Colors.white)
                                                : Icon(
                                                    Icons.bookmark_add_outlined,
                                                    color: Colors.white))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      apiList[index].description,
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      });
                },
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.home_outlined,
                              size: 35, color: Colors.white),
                        ),
                        IconButton(
                          onPressed: () {
                            print(newsBookmarked);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Bookmarks(bookList: newsBookmarked)),
                            );
                          },
                          icon: Icon(
                            Icons.bookmark_added_outlined,
                            size: 32,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
