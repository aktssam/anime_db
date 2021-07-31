import 'package:anime_db/model/anime_model.dart';
import 'package:anime_db/pages/detail.dart';
import 'package:anime_db/styles/colorStyle.dart';
import 'package:anime_db/styles/fontStyle.dart';
import 'package:flutter/material.dart';

class BrowsePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.only(top: 50),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Browse', style: header),
                Icon(Icons.search, size: 32),
              ],
            ),
          ),
        ),
        body: ListAnimeData(),
      ),
    );
  }
}

class ListAnimeData extends StatefulWidget {
  @override
  _ListAnimeDataState createState() => _ListAnimeDataState();
}

class _ListAnimeDataState extends State<ListAnimeData> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Anime.connectToAPI(0),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Container(
            child: Center(
              child: Text("Loading..."),
            ),
          );
        } else {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int id) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailPage(listDetail: snapshot.data[id])));
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Thumbnail
                        Container(
                          width: 120,
                          height: 160,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            child: Image.network(
                              snapshot.data[id].coverImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        //Column
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //judul
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Text(
                                  snapshot.data[id].title,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  // softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  // overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: 16),
                              //rating
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_rate,
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    snapshot.data[id].rating,
                                    style: TextStyle(color: navySoft),
                                  ),
                                ],
                              ),
                              //status
                              Text(
                                "Status: ${snapshot.data[id].status}",
                                style: TextStyle(color: navySoft),
                              ),
                              //genre
                              SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        }
      },
    );
  }
}
