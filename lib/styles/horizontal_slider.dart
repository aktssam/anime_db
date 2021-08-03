import 'package:anime_db/model/anime_model.dart';
import 'package:anime_db/pages/detail.dart';
import 'package:anime_db/styles/fontStyle.dart';
import 'package:flutter/material.dart';

class HorizontalScroll extends StatelessWidget {
  late final int indexAPI;
  HorizontalScroll({required this.indexAPI});

  /* INDEX API:
  default: GET List Animes (ascending by title)
  (1) : GET Favorites List Animes
  (2) : GET Trending List Animes
  */

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Anime.connectAPI(indexAPI),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              width: 128,
              height: 256,
              child: Center(
                child: Text("Loading..."),
              ),
            );
          } else {
            return Builder(builder: (BuildContext context) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 5),
                  child: Row(
                      children: snapshot.data.map<Widget>((fetch) {
                    return Container(
                      width: 128,
                      height: 256,
                      margin: EdgeInsets.only(right: 15),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailPage(listDetail: fetch)));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: 128,
                                height: 200,
                                child: Image.network(
                                  fetch.coverImage,
                                  fit: BoxFit.cover,
                                )),
                            Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                fetch.title,
                                style: title,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              fetch.status,
                              style: subtitle,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList()),
                ),
              );
            });
          }
        });
  }
}
