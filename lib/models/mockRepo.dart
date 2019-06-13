
import 'dart:async';

import 'package:my_anime_list/api/jikan.dart';

import 'models.dart';

class MockAnimeRepository implements AnimeRepository {
  @override
  Future<List<TopAnime>> fetchAnime(Presenter p) {
    
    return new Future.value(sample);
  }
}
TopAnime ta(){
return TopAnime(
     malId : 24,
      title : "top.title",
      url : "top.url",
      imageUrl : "top.imageUrl" ,
      type : "top.type",
      rank :23 ,
       startDate : "top.startDate",
      endDate : "top.endDate",
      episodes: 24,
      members: 3544356,
      score: 45.7
      );}
var sample = <TopAnime>[
  ta(),ta(),ta(),ta(),ta(),ta(),ta(),ta(),ta(),ta(),
];

