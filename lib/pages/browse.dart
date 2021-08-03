import 'package:anime_db/bloc/anime_bloc.dart';
import 'package:anime_db/model/anime_model.dart';
import 'package:anime_db/pages/detail.dart';
import 'package:anime_db/styles/colorStyle.dart';
import 'package:anime_db/styles/fontStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

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
          body: BlocBuilder<AnimeBloc, AnimeState>(
            builder: (context, state) {
              if (state is AnimeUnitialized)
                return Center(
                  child: SizedBox(
                    child: CircularProgressIndicator(),
                  ),
                );
              else {
                AnimeLoaded animeLoaded = state as AnimeLoaded;
                return ListAnimeData(
                  animeLoaded: animeLoaded,
                );
              }
            },
          )),
    );
  }
}

class ListAnimeData extends StatefulWidget {
  AnimeLoaded animeLoaded;
  ListAnimeData({required this.animeLoaded});
  @override
  _ListAnimeDataState createState() => _ListAnimeDataState();
}

class _ListAnimeDataState extends State<ListAnimeData> {
  ScrollController controller = ScrollController();
  late AnimeBloc bloc;

  void onScroll() {
    double maxScroll = controller.position.maxScrollExtent;
    double currentScroll = controller.position.pixels;

    if (currentScroll == maxScroll) bloc.add(AnimeEvent());
  }

  @override
  Widget build(BuildContext context) {
    var animeLoaded = widget.animeLoaded;
    bloc = BlocProvider.of<AnimeBloc>(context);
    controller.addListener(onScroll);
    return ListView.builder(
      controller: controller,
      itemCount: (animeLoaded.hasReachedMax)
          ? animeLoaded.animes.length
          : animeLoaded.animes.length + 1,
      itemBuilder: (context, index) {
        if (index < animeLoaded.animes.length) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailPage(listDetail: animeLoaded.animes[index])));
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
                        animeLoaded.animes[index].coverImage,
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
                            animeLoaded.animes[index].title,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
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
                              animeLoaded.animes[index].rating,
                              style: TextStyle(color: navySoft),
                            ),
                          ],
                        ),
                        //status
                        Text(
                          "Status: ${animeLoaded.animes[index].status}",
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
        } else {
          return Container(
            child: Center(
              child: SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}
