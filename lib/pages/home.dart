import 'package:flutter/material.dart';
import 'package:anime_db/styles/colorStyle.dart';
import 'package:anime_db/styles/fontStyle.dart';
import 'package:anime_db/styles/horizontal_slider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatelessWidget {
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
                Text('Discover', style: header),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // title page
              // Padding(
              //   padding: const EdgeInsets.only(left: 20),
              //   child: Row(children: [
              //     Text(
              //       'Discover',
              //       style: header,
              //     )
              //   ]),
              // ),

              // banner carousel
              Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 200,
                      autoPlay: true,
                      enlargeCenterPage: true,
                    ),
                    items: [
                      'images/banner-1.jpeg',
                      'images/banner-2.jpeg',
                      'images/banner-3.jpg',
                    ].map((e) {
                      return Builder(builder: (BuildContext context) {
                        return Container(
                            // width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 0),
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                child: Image.asset(
                                  e,
                                  fit: BoxFit.cover,
                                )));
                      });
                    }).toList(),
                  )),

              // new episodes
              SizedBox(
                height: 12,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Favorites', style: categories),
                      Text('see more',
                          style: TextStyle(color: navySoft, fontSize: 14)),
                    ]),
              ),
              FavoriteView(),
              // popular
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Trending', style: categories),
                      Text('see more',
                          style: TextStyle(color: navySoft, fontSize: 14)),
                    ]),
              ),
              TrendingView(),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget Popular Categories
class TrendingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HorizontalScroll(indexAPI: 2);
  }
}

class FavoriteView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HorizontalScroll(indexAPI: 1);
  }
}
