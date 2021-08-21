import 'package:anime_db/model/anime_model.dart';
import 'package:anime_db/pages/detail.dart';
import 'package:anime_db/styles/colorStyle.dart';
import 'package:anime_db/styles/fontStyle.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future<List<Anime>> listAnime = Anime.connectAPI(0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            onSubmitted: (text) {
              setState(() {
                listAnime = Anime.search(text);
              });
            },
          ),
        ),
        body: FutureBuilder(
            future: listAnime,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: Text("No Result"),
                );
              } else {
                return Builder(builder: (BuildContext context) {
                  return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: snapshot.data.map<Widget>((fetch) {
                        return Card(
                          margin:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailPage(listDetail: fetch)));
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Thumbnail
                                Container(
                                  width: 120,
                                  height: 160,
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    child: Image.network(
                                      fetch.coverImage,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      //judul
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        padding:
                                            const EdgeInsets.only(bottom: 16),
                                        child: Text(
                                          fetch.title,
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
                                            fetch.rating,
                                            style: TextStyle(color: navySoft),
                                          ),
                                        ],
                                      ),
                                      //status
                                      Text(
                                        "Status: ${fetch.status}",
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
                      }).toList(),
                    ),
                  );
                });
              }
            }),
      ),
    );
  }
}
