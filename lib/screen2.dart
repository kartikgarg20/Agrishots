import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/agri_model.dart';

class Bookmarks extends StatefulWidget {
  final bookList;
  Bookmarks({Key? key, required this.bookList}) : super(key: key);

  @override
  State<Bookmarks> createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  List<Datum> apiList = [];
  List<Datum> apiList2 = [];

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
      getList();
      return apiList;
    } else {
      return apiList;
    }
  }

  var agriFetched;

  void getList() {
    for (var i = 0; i < apiList.length; i++) {
      for (var a = 0; a < widget.bookList.length; a++) {
        if (apiList[i].id == widget.bookList[a]) {
          apiList2.add(apiList[i]);
        }
      }
    }
    print(apiList2.length);
  }

  @override
  void initState() {
    super.initState();
    agriFetched = getAgriList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bookmarks',
        ),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
          child: Expanded(
        child: FutureBuilder(
          future: agriFetched,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return ListView.builder(
              itemCount: apiList2.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 0.6),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                height: 50,
                                width: 260,
                                child: Text(
                                  apiList[index].title,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 70,
                                child: Image.network(apiList2[index].mediaslug),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.bookmark_added,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Icon(
                                Icons.share,
                                color: Colors.white,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      )),
      backgroundColor: Colors.black,
    );
  }
}
