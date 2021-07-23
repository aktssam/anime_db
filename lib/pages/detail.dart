import 'package:flutter/material.dart';
import 'package:anime_db/styles/colorStyle.dart';
import 'package:anime_db/styles/fontStyle.dart';

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> listDetail;
  DetailPage({required this.listDetail});
  @override
  Widget build(BuildContext context) {
    print(listDetail['episode']);
    List episode = listDetail['episode'].toList();
    List genre = listDetail['genre'].toList();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(300),
          child: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              "Detail",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            bottom: TabBar(
                labelColor: blackPrimary,
                unselectedLabelColor: navySoft,
                tabs: [
                  Tab(
                    text: "Description",
                  ),
                  Tab(
                    text: "Episode",
                  ),
                ]),
            flexibleSpace: Padding(
              // padding: const EdgeInsets.only(left: 20, top: 90),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
              child: Row(
                children: [
                  Container(
                    width: 128,
                    height: 186,
                    child: Image.asset("images/${listDetail["image"]}", fit: BoxFit.cover,),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.48,
                    height: 160,
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "${listDetail["title"]}",
                          style: header,
                          softWrap: true,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Status: ${listDetail["status"]}",
                          style: subtitle,
                        ),
                        Text(
                          "Rating: ${listDetail["rating"]}",
                          style: subtitle,
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: genre.map((genre) {
                            return Container(
                              margin: EdgeInsets.only(right: 3),
                              color: Colors.blue[300],
                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: Text(
                                  "$genre", style: TextStyle(fontSize: 11, color:Colors.white),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(children: [
          //Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sinopsis",
                  style: header,
                ),
                SizedBox(
                  height: 16,
                ),
                Text("${listDetail["synopsis"]}",
                    style: TextStyle(fontSize: 14)),
              ],
            ),
          ),

          //Episode
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListView(
              children: episode.map((ep) {
                return Card(
                  
                  child: InkWell(
                    onTap: () {},
                    child: ListTile(
                      leading: Container(
                        width: 120,
                        height: 160,
                        child: Image.asset(
                          'images/${listDetail['image']}',
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        "$ep",
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text("Sinopsis 2", style: header,),
          //       SizedBox(height: 10,),
          //       Text("${listDetail["synopsis"]}", style: TextStyle(fontSize: 16)),
          //     ],
          //   ),
          // )
        ]),
      ),
    );
  }
}