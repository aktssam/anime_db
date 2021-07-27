import 'package:anime_db/model/anime_model.dart';
import 'package:flutter/material.dart';
import 'package:anime_db/styles/fontStyle.dart';

class DetailPage extends StatelessWidget {
  final Anime listDetail;
  DetailPage({required this.listDetail});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Detail",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 128,
                  height: 186,
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      child: Image.network(listDetail.coverImage,
                          fit: BoxFit.cover)),
                ),
                SizedBox(width: 20),
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        listDetail.title,
                        style:
                            TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        softWrap: true,
                      ),
                      SizedBox(height: 10),
                      Text("Status: ${listDetail.status}", style: subtitle),
                      Row(children: [
                        Icon(Icons.star_rate, color: Colors.amber, size: 18,),
                        SizedBox(width: 4),
                        Text(listDetail.rating,
                          style: subtitle,
                        ),
                      ]),
                      SizedBox(height: 8),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Sinopsis", style: header),
                SizedBox(height: 16),
                Text(listDetail.sinopsis, style: TextStyle(fontSize: 14))
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
