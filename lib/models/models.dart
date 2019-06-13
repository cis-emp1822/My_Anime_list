import 'package:jikan_dart/jikan_dart.dart';
import 'package:my_anime_list/api/jikan.dart';
 class TopAnime {
  
  // 'mal_id')
  int  malId;

  //'rank')
  int  rank;

  //'title')
  String  title;

  // 'url')
  String  url;

  // 'image_url')
  String  imageUrl;

  //'type')
  String  type;

  // 'episodes')
  //
  int  episodes;

  // 'start_date')
  //nullable
  String  startDate;

  // 'end_date')
  //nullable
  String  endDate;

  // 'members')
  int  members;

  //'score')
double  score;

  TopAnime({this.malId, this.title, this.url ,this.imageUrl , this.type , this.rank , this.startDate ,this.endDate , this.episodes , this.members , this.score });

  TopAnime.fromTop(Top top)
      : 
      malId = top.malId,
      title = top.title,
      url = top.url,
      imageUrl = top.imageUrl ,
      type = top.type,
      rank = top.rank,
      startDate = top.startDate,
      endDate = top.endDate,
      score = top.score,
      members = top.members,
      episodes = top.episodes ;
}

abstract class AnimeRepository {
  Future<List<TopAnime>> fetchAnime(Presenter p);
}