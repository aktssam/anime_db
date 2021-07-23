
import 'package:anime_db/model/data.dart';
import 'package:anime_db/pages/detail.dart';
import 'package:anime_db/styles/colorStyle.dart';
import 'package:anime_db/styles/fontStyle.dart';
import 'package:flutter/material.dart';
// import 'package:carousel_pro/carousel_pro.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        minimum: EdgeInsets.only(top: 50),
        child: Column(
          children: [
            // title page
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(children: [
                Text(
                  'Discover',
                  style: header,
                )
              ]),
            ),

            // // banner carousel
            // Padding(
            //   padding: const EdgeInsets.only(top: 20),
            //   child: SizedBox(
            //       height: 200,
            //       width: double.infinity,
            //       child: Carousel(
            //         showIndicator: false,
            //         images: [
            //           Image.asset(
            //             'images/banner-1.jpeg',
            //             fit: BoxFit.cover,
            //           ),
            //           Image.asset(
            //             "images/banner-2.jpeg",
            //             fit: BoxFit.cover,
            //           ),
            //         ],
            //       )),
            // ),

            // new episodes
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('New Episodes', style: categories),
                    Text('see more',
                        style: TextStyle(color: navySoft, fontSize: 14)),
                  ]),
            ),
            NewEpisodesView(),

            // popular
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Popular', style: categories),
                    Text('see more',
                        style: TextStyle(color: navySoft, fontSize: 14)),
                  ]),
            ),
            PopularView(),
          ],
        ),
      ),
    );
  }
}

// Widget New Episodes
class NewEpisodesView extends StatelessWidget {
  final List<Map<String, dynamic>> listData = LIST_DATA;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: listData.map((data) {
              return Container(
                width: 104,
                height: 200,
                margin: EdgeInsets.only(right: 10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailPage(listDetail: data)));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: 104,
                          height: 156,
                          child: Image.asset(
                            "images/${data['image']}",
                            fit: BoxFit.cover,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          "${data['title']}",
                          style: title,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        "Episode ${data['new-episode']}",
                        style: subtitle,
                      ),
                    ],
                  ),
                ),
              );
            }).toList()),
      ),
    );
  }
}

// Widget Popular Categories
class PopularView extends StatelessWidget {
  final List<Map<String, dynamic>> listData = LIST_DATA;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: listData.map((data) {
              return Container(
                width: 104,
                height: 200,
                margin: EdgeInsets.only(right: 10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailPage(listDetail: data)));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: 104,
                          height: 156,
                          child: Image.asset(
                            "images/${data['image']}",
                            fit: BoxFit.cover,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          "${data['title']}",
                          style: title,
                        ),
                      ),
                      Text(
                        "${data['status']}",
                        style: subtitle,
                      ),
                    ],
                  ),
                ),
              );
            }).toList()),
      ),
    );
  }
}
