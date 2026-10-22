import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class DioTestScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
     return DioTestScreenState();
  }
}

class DioTestScreenState extends State<DioTestScreen> {
  //서버에서 받은 데이터 가정..
  List datas = [];

  //ListView의 스크롤 정보를 활용하고자 한다. ListView에 추가하면 이 controller에 스크롤 정보 유지..
  ScrollController controller = ScrollController();

  //서버에 전송 데이터..
  int page = 1;
  int seed = 1;

  //서버 네트워킹이 필요한 순간 호출되는 함수..
  Future<dynamic> dioTest() async {
    try{
      var dio = Dio(BaseOptions(
        connectTimeout: Duration(seconds: 5,),
        receiveTimeout: Duration(seconds: 5,),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        }
      ));

      Response<dynamic> response = await dio.get(
        "https://randomuser.me/api?seed=${seed}&page=${page}&results=20"
      );
      return response.data['results'];
    }catch(e){
      print(e);
    }
    return [];
  }

  //ListView 스크롤 이벤트 콜백..
  scrollListener() async {
    //마지막 항목까지 스크롤이 된것인지 판단.
    if(controller.offset >= controller.position.maxScrollExtent && !controller.position.outOfRange){
      //다음 페이지 데이터. .획득 화면 갱신..
      page++;
      List result = await dioTest();
      setState(() {
        datas.addAll(result);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(scrollListener);
    //최초 데이터 획득..
    //코드 편의성을 목적으로 한다면.. await를 사용해서.. 데이터 획득이 편하다..
    //await를 사용하며면 함수가 async로 선언..
    //이 함수 라이프사이클 함수다..
    dioTest().then((value){
      setState(() {
        datas = value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  //화면 갱신..이벤트 콜백..
  Future<void> refresh() async {
    page = 1;
    seed++;
    List result = await dioTest();
    setState(() {
      datas = result;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dio'),
        ),
        body: RefreshIndicator(
          onRefresh: refresh,
          child: ListView.separated(
            controller: controller,
            itemCount: datas.length,
            itemBuilder: (BuildContext context, int position) {
              return ListTile(
                contentPadding: EdgeInsets.all(5),
                title: Text(
                    "${datas[position]["name"]["first"]} ${datas[position]["name"]["last"]}"),
                subtitle: Text(datas[position]["email"]),
                leading: CircleAvatar(
                  radius: 25,
                  child: ClipOval(
                    child:
                    Image.network(datas[position]["picture"]['thumbnail']),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int position) {
              return Divider(
                color: Colors.black,
              );
            },
          ),
        )
    );
  }
}