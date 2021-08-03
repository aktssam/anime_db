import 'dart:convert';
import 'package:http/http.dart' as http;

class Anime {
  final String id;
  final String title;
  final String rating;
  final String status;
  final String coverImage;
  final String sinopsis;

  Anime({
    required this.id,
    required this.title,
    required this.rating,
    required this.status,
    required this.coverImage,
    required this.sinopsis,
  });

  factory Anime.createData(Map<String, dynamic> object) {
    var attributes = object['attributes'];
    var image = (attributes as Map<String, dynamic>)['posterImage'];
    var avgRating = attributes['averageRating'];

    if (avgRating == null) {
      avgRating = "--";
    }

    return Anime(
      id: object['id'],
      title: attributes['canonicalTitle'],
      rating: avgRating,
      status: attributes['status'],
      coverImage: image['small'],
      sinopsis: attributes['synopsis'],
    );
  }

  static Future<List<Anime>> connectToAPI(int start, int limit) async {
    String apiURL =
        "https://kitsu.io/api/edge/anime?page[limit]=$limit&page[offset]=$start";

    var apiResults = await http.get(Uri.parse(apiURL));
    var jsonObject = json.decode(apiResults.body);
    var animeData = (jsonObject as Map<String, dynamic>)['data'];

    List<Anime> listAnime = [];
    for (var object in animeData) {
      listAnime.add(Anime.createData(object));
    }
    return listAnime;
  }

  static Future<List<Anime>> connectAPI(int key) async {
    String apiURL = "";
    switch (key) {
      case 1:
        apiURL = "https://kitsu.io/api/edge/anime?sort=-favoritesCount";
        break;
      case 2:
        apiURL = "https://kitsu.io/api/edge/trending/anime";
        break;
      default:
        apiURL = "https://kitsu.io/api/edge/anime";
    }

    var apiResults = await http.get(Uri.parse(apiURL));
    var jsonObject = json.decode(apiResults.body);
    var animeData = (jsonObject as Map<String, dynamic>)['data'];

    List<Anime> listAnime = [];
    for (var object in animeData) {
      listAnime.add(Anime.createData(object));
    }
    return listAnime;
  }
}
