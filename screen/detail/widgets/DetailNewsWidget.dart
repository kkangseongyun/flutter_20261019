import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_lab/screen/detail/dto/ArticleDto.dart';
import 'package:http/http.dart' as http;


class DetailNewsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DetailNewsWidgetState();
  }
}

class DetailNewsWidgetState extends State<DetailNewsWidget> {

  String _url =
      'https://newsapi.org/v2/everything?q=travel&apiKey=079dac74a5f94ebdb990ecf61c8854b7&pageSize=3';

  List<Article> list = [];//서버 데이터..
  late StreamController<List<Article>> streamController;


  Widget getItemWidget(List<Article> datas) {
    return ListView.builder(
      itemCount: datas.length,
      itemBuilder: (BuildContext context, int position) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                datas[position].title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                datas[position].publishedAt,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(datas[position].description),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Image.network(datas[position].urlToImage),
            ),
            if (position != datas.length - 1)
              Container(height: 15, color: Colors.grey),
          ],
        );
      },
    );
  }

  //5초마다 5번 서버데이터 획득...
  void getServerData(){
    Stream.periodic(Duration(seconds: 5), (count) => count + 1)
        .take(5)
        .asyncMap((page) async{
          String url = '$_url&page=$page';

          http.Response response = await http.get(Uri.parse(url));
          List articles = json.decode(response.body)['articles'];

          return articles.map((item) => Article(
            item['source']['name'],
            item['title'],
            item['description'],
            item['urlToImage'],
            item['publishedAt']
          )).toList();

    }).listen((article) => streamController.add(article));
  }

  @override
  void initState() {
    super.initState();
    streamController = StreamController<List<Article>>();
    getServerData();
  }

  @override
  void dispose() {
    super.dispose();
    streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: streamController.stream,
        //두번째 매개변수가 데이터..
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            list.addAll(snapshot.data);
            return getItemWidget(list);
          }
          return CircularProgressIndicator();//최초에도 한번 호출..
        },
    );
  }
}













