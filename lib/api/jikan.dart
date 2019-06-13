
import 'package:my_anime_list/models/models.dart';
import 'depInjector.dart';
abstract class PresenterContract {
  void onLoadAnimeComplete(List<TopAnime> items);
  void onLoadAnimeError();
}
class Presenter  {
   PresenterContract pc ;
  
   
    List<TopAnime> listAnime = [] ;
     int pagenumber = 0;
     int pageY ;
     int start;
     int end;
     
     AnimeRepository _repository ;
     
   Presenter({this.pageY,this.start,this.end , this.pc  }){

    this._repository = new Injector().animeRepository;
   }
    
   
   void loadAnimeList(){
     
      _repository
      .fetchAnime(this)
      .then((items){
         pc.onLoadAnimeComplete(items);
         })
      .catchError((onError)=>pc.onLoadAnimeError());
   }
 }


  

  
  


 