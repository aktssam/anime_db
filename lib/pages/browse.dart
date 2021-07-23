import 'package:anime_db/styles/colorStyle.dart';
import 'package:anime_db/styles/fontStyle.dart';
import 'package:anime_db/model/data.dart';
import 'package:flutter/material.dart';

import 'detail.dart';

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
                // title
                Text(
                  'Browse',
                  style: header,
                ),
                Icon(Icons.search, size: 32,),
                // search bar
                // SearchBar(setState: setState, buildDefaultAppBar: buildDefaultAppBar)
              ],
            ),
          ),
        ),
        body: AnimeList(),
      ),
    );
  }
}

class AnimeList extends StatelessWidget {
  final List<Map<String, dynamic>> listAnime = LIST_DATA;
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: listAnime.map((data) {
        List genre = data['genre'];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: InkWell(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailPage(listDetail: data)));
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Thumbnail
                Container(
                  width: 120,
                  height: 160,
                  child: Image.asset(
                    'images/${data['image']}',
                    fit: BoxFit.cover,
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
                      Text(
                        data['title'].toString(),
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      //rating
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 18,),
                          SizedBox(width: 3,),
                          Text(data['rating'].toString(), style: TextStyle(color: navySoft),),
                        ],
                      ),
                      //status
                      Text(data['status'].toString(), style: TextStyle(color: navySoft),),
                      Text(data['premiere'].toString(), style: TextStyle(color: navySoft),),
                      //genre
                      SizedBox(height: 8,),
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
                        }).toList()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
