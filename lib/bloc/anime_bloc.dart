import 'package:anime_db/model/anime_model.dart';
import 'package:bloc/bloc.dart';

class AnimeEvent {}

abstract class AnimeState {}

class AnimeUnitialized extends AnimeState {}

class AnimeLoaded extends AnimeState {
  late List<Anime> animes;
  late bool hasReachedMax;

  AnimeLoaded({required this.animes, required this.hasReachedMax});
  AnimeLoaded copyWith(
      {required List<Anime> animes, required bool hasReachedMax}) {
    return AnimeLoaded(animes: animes, hasReachedMax: hasReachedMax);
  }
}

class AnimeBloc extends Bloc<AnimeEvent, AnimeState> {
  AnimeBloc() : super(AnimeUnitialized());
  @override
  Stream<AnimeState> mapEventToState(AnimeEvent event) async* {
    List<Anime> animes;
    if (state is AnimeUnitialized) {
      animes = await Anime.connectToAPI(0, 20);
      yield AnimeLoaded(animes: animes, hasReachedMax: false);
    } else {
      AnimeLoaded animeLoaded = state as AnimeLoaded;
      animes = await Anime.connectToAPI(animeLoaded.animes.length, 20);
      yield (animes.isEmpty)
          ? animeLoaded.copyWith(animes: animes, hasReachedMax: true)
          : AnimeLoaded(
              animes: animeLoaded.animes + animes, hasReachedMax: false);
    }
  }
}
