import 'package:my_anime_list/models/mockRepo.dart';
import 'package:my_anime_list/models/prodRepo.dart';
import 'package:my_anime_list/models/models.dart';
enum Flavor { MOCK, PROD }

//DI
class Injector {
  static final Injector _singleton = new Injector._internal();
  static Flavor _flavor;

  static void configure(Flavor flavor) {
    _flavor = flavor;
  }

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  AnimeRepository get animeRepository {
    
    switch (_flavor) {
      case Flavor.MOCK:
        return new MockAnimeRepository();
      default:{
       
        return new ProdAnimeRepository();}
    }
  }
}