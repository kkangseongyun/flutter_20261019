import 'package:flutter/material.dart';
import 'package:flutter_lab/screen/detail/DetailScreen.dart';
import 'package:flutter_lab/screen/event/EventScreen.dart';
import 'package:flutter_lab/screen/myinfo/MyInfoScreen.dart';
import 'package:go_router/go_router.dart';
import 'screen/main/MainScreen.dart';

void main(){
  runApp(MyApp());
}

//앱의 화면 정보 등록, MaterialApp에 등록..
GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => MainScreen()),
    GoRoute(path: '/myinfo/:id', builder: (context, state) {
      //전달된 데이터를 GoRouter에서 추출해서 전환되는 위젯의 생성자로 전달.. 위젯이 GoRouter API 종속성이 없어 좋다.
      String? id = state.pathParameters['id'];//url path :뒷 문자열과 맞추면 된다.
      String? keyword = state.uri.queryParameters['q'];
      var extraData = state.extra as Map<String, dynamic>;
      return MyInfoScreen(id: id, keyword: keyword, extra: extraData);
    }),
    GoRoute(path: '/event', builder: (context, state) => EventScreen()),
    GoRoute(path: '/detail', builder: (context, state) => DetailScreen()),
  ]
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
