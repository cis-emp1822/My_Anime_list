import 'dart:async';
//import 'package:built_collection/built_collection.dart';
import 'package:jikan_dart/jikan_dart.dart';
import 'models.dart';
import 'package:my_anime_list/api/jikan.dart';
class ProdAnimeRepository implements AnimeRepository {


  @override
  Future<List<TopAnime>> fetchAnime(Presenter p) async {
    var jikanApi = JikanApi();
    var x1 =  await jikanApi.getTop(TopType.anime , page: p.pageY , subtype: TopSubtype.bypopularity );
    
      
        for(int x=0; x< x1.asList().length ; x++)
        p.listAnime.add(TopAnime.fromTop(x1.asList()[x]));
        
 //print("${p.listAnime}");
 return p.listAnime ;
      }

      
  
}

