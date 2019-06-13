import '../api/jikan.dart';
import 'package:flutter_web/material.dart';
import 'package:my_anime_list/models/models.dart';
import 'package:my_anime_list/api/depInjector.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> implements PresenterContract {
  Presenter _p;
  bool _isLoading , textValidate = true ;
  PageController _pageController = PageController(initialPage: 0, keepPage: false);
final  _text = TextEditingController();
 
  List<TopAnime> _anime = [];
  MyHomePageState() {
    Injector.configure(Flavor.PROD);
    _p = new Presenter(pageY: 1, start: 0, end: 50, pc: this);
  }
  @override
  void initState() {
    super.initState();

    _isLoading = true;
    _p.loadAnimeList();
  }
  @override
  void dispose() {
    _pageController.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _isLoading
          ? new Center(
              child: new CircularProgressIndicator(),
            )
          : Column(children: [
              Expanded(
                  child: PageView.builder(
                      controller: _pageController,
                      itemCount: _anime == null ? 0 : _anime.length / 10 ,
                      onPageChanged: (raju) => pageChange(raju),
                      itemBuilder: (context, tens) {
                        return Center(
                          child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (BuildContext context, int ones) {
                               

                                return 
                                InkWell(
                                  onTap:  (){  },
                               child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width:
                                            0.4, //                   <--- border width here
                                      ),
                                    ),
                                    height: 80,
                                    child: Row(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                      children : <Widget>[
                                        // FadeInImage(
                                        //   placeholder: NetworkImage(
                                        //       'https://cdn.myanimelist.net/img/sp/icon/apple-touch-icon-256.png'),
                                        //   image: NetworkImage(
                                        //       '${_anime[tens * 10 + ones].imageUrl}'),
                                        //   height: 150,
                                        //   width: 100,
                                        // ),
                                        Expanded(
                                          child: Text(
                                            "${_anime[tens * 10 + ones].title}",
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                         Flexible(
                                         child:  Text(
                                            "RANK: ${_anime[tens * 10 + ones].rank}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22.0,))),
                                          
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(15, 3, 30, 3),
                                        ),
                                        Expanded(
                                         child: Text(
                                            "Members: ${_anime[tens * 10 + ones].members}")),
                                            Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(15, 3, 30, 3),
                                        ),
                                        Flexible(
                                         child: 
                                        Text(
                                            "Score: ${_anime[tens * 10 + ones].score}")),
                                             Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(15, 3, 30, 3),
                                        ),
                                        Flexible(
                                         child: 
                                        Text(
                                            "Start Date: ${_anime[tens * 10 + ones].startDate}"),),
                                              Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(15, 3, 30, 3),
                                        ),
                                        Expanded(
                                         child: 
                                        Text(
                                            "Episodes: ${_anime[tens * 10 + ones].episodes}")),
                                      ],
                                    )
                                    
                                    ));
                              }),
                        );
                      })),
              Text("${_p.pagenumber+1}"),
              
            ]),
      bottomNavigationBar: BottomAppBar(
        
          child: Container(
        height: 50,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Expanded(
              child: Slider(
            onChanged: (value) {
              gotoPage(value);
            },
            value: _p.pagenumber.toDouble(),
            max: _p.pageY * 5.toDouble(),
          )),
          Flexible(
          child: 
          Container(
            width: 120,
            height:60,
          child: TextField(
            controller: _text, 
             decoration: new InputDecoration(labelText: "Max. ${5*_p.pageY}" ,  errorText: textValidate ? null :'Wrong value' ,),
                keyboardType: TextInputType.number,
           )))
           ,Flexible(
          child: Container(
            width: 70, 
            child: FlatButton(
             color: Colors.green,
             child: Icon(Icons.arrow_right),
             onPressed:(){ 
               var v = validateGoto(_text.text);
               gotoPage(v);
                 }
           )))
                   ]),
      )),
    );
  }

  gotoPage(double bit) {
    setState(() {
      _p.pagenumber = bit.toInt();
      _pageController.jumpToPage(_p.pagenumber);
    });
  }
  double validateGoto(String str){
    print ("validate called");
    double bit;
    try{
    bit = double.parse(str+".0");
    }
    catch(e){
      textValidate = false;
     return 0.0;
    }
    if(bit>_p.pageY*5||bit<1.0)
    { textValidate=false;
      return 0.0;
    }
    textValidate = true ;
    return bit-1 ;
  }
  pageChange(int raju) {
     print("\n\n\n\n\n raju == $raju");
    if (raju + 1 == _anime.length / 10) {
     
      setState(() {
        _p.pagenumber = raju;
        _p.pageY++;
        _p.loadAnimeList();
      });
    } else
      setState(() {
        _p.pagenumber = raju;
      });
  }

  @override
  void onLoadAnimeComplete(List<TopAnime> items) {
    setState(() {
      
      print(" \n \n \n \n \n loading completed \n \n \n");
      _anime.clear();
      _anime.addAll(items);
print("${_anime}");
      _isLoading = false;
    });
  }

  @override
  void onLoadAnimeError() {}
}
