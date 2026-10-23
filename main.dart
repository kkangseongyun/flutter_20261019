import 'package:flutter/material.dart';
import 'package:flutter_lab/provider/TodosModel.dart';
import 'package:flutter_lab/riverpod/RiverpodNotifier.dart';
import 'package:flutter_lab/screen/detail/DetailScreen.dart';
import 'package:flutter_lab/screen/dio/DioTestScreen.dart';
import 'package:flutter_lab/screen/event/EventScreen.dart';
import 'package:flutter_lab/screen/myinfo/MyInfoScreen.dart';
import 'package:flutter_lab/screen/provider/ProviderAddScreen.dart';
import 'package:flutter_lab/screen/provider/ProviderHomeScreen.dart';
import 'package:flutter_lab/screen/riverpod/RiverpodAddScreen.dart';
import 'package:flutter_lab/screen/riverpod/RiverpodHomeScreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'screen/main/MainScreen.dart';

void main(){
  runApp(
    ProviderScope(child: MyApp(),),//상태가 저장될 저장소 준비..
  );
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
    GoRoute(path: '/dio', builder: (context, state) => DioTestScreen()),
    //ShellRoute - 라우트 정보를 중첩 등록, 이곳에 등록된 위젯의 라우팅 정보를 유지하기 위한 스택을 새로 만들어서 관리한다.
    //동일 구조의 테스트를 provider, riverpod, bloc 으로 하다보니.. 다른 화면에 영향을 주지 않게 하기 위해서..
    //스택 정보가 분리가 되어.. 이곳에 등록된 데이터는 이곳의 라우팅에서만 사용가능..
    ShellRoute(
      builder: (context, state, child){
        return ChangeNotifierProvider(//공통의 조상 역할하는 곳에서 상태 등록..
          create: (_) => TodosModel(),
          child: child,//결정된 GoRoute에 등록한 위젯..
        );
      },
      routes: [
        GoRoute(path: '/provider-home', builder: (context, state) => ProviderHomeScreen()),
        GoRoute(path: '/provider-add', builder: (context, state) => ProviderAddScreen()),
      ]
    ),
    ShellRoute(
        builder: (context, state, child){
          return ProviderScope(//특정 계층만을 위한 저장소 선언..
            overrides: [
              //이 저장소에서 유지해야 하는 데이터 선언.. 이곳에 없는 데이터는 자동으로 상위 저장소에서 찾게 된다.
              //앱 전역에서 유지되어야 하는 데이터는 상위 저장소에, 이 계층에서 유지되어야 하는 데이터만 선언..
              todosProvider.overrideWith(TodosNotifier.new)
            ],
            child: child,
          );
        },
        routes: [
          GoRoute(path: '/riverpod-home', builder: (context, state) => RiverpodHomeScreen()),
          GoRoute(path: '/riverpod-add', builder: (context, state) => RiverpodAddScreen()),
        ]
    )
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
