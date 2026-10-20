//material.dart : 사실상의 필수, 구글의 머티리얼 디자인이 적용된 다양한 위젯을 제공..
//원한다면 ios 스타일이 적용된 화면 구성도 가능하다. cupertino.dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  //화면 출력(정보)을 위해 자동 호출..
  @override
  Widget build(BuildContext context) {
    //사실상의 필수, 앱 전체 테마 설정, 앱의 라우팅 처리..
    //앱 내에서 여러 위젯에 MaterialApp 을 선언해도 되지만 대부분의 경우.. runApp()에 의해 출력되는 최초의 위젯.
    //그 위젯의 root 객체로 설정.. 앱테마, 앱 라우팅 처리는 한번만 선언하면 되니까..
    return MaterialApp(
      //화면 기본 구조를 제공하는 위젯.. 필수는 아니다.. 화면단위 위젯에서 대부분 사용
      home: Scaffold(
        appBar: AppBar(
          title: Text('widget test'),
        ),
        body: Column(
          children: [
            MyStatelessWidget(),
            MyStatefulWidget(),
          ],
        ),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  //상태를 못 가지는 것이지, 변수 선언이 안된다는 것은 아니다.
  bool favorited = false;
  int favoriteCount = 10;

  void toggleFavorite() {
    print('Stateless...toggleFavorite');
    // setState//error. State의 함수이다.
    if(favorited){
      favoriteCount -= 1;
      favorited = false;
    }else {
      favoriteCount += 1;
      favorited = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Stateless...build');
    return Row(
      children: [
        IconButton(
            onPressed: toggleFavorite,
            icon: (favorited) ? Icon(Icons.star) : Icon(Icons.star_border),
            color: Colors.red,
        ),
        Text('$favoriteCount')
      ],
    );
  }
}

class MyStatefulWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<MyStatefulWidget> {
  bool favorited = false;
  int favoriteCount = 10;

  void toggleFavorite() {
    print('Stateful...toggleFavorite');
    //상태를 가질 수 있고, 상태 변경시에 화면 갱신(re-rendering) 시킬 수 있지만
    //화면 변경 명령을 setState() 로 내려야 화면 갱신..
    //setState() 함수 호출은 비동기 처리이다.
    //상태 변경후 변경된 값으로 화면이 갱신되게 하려면.. 상태 변경을
    //setState()의 매개변수 함수에서 해야한다. 안그러면 비동기임으로 시점 차이에의해
    //상태값은 변경되지만.. 변경된 것이 화면에 적용되지 않을 수 있다.
    //setState() 함수는 매개변수 함수 호출을 먼저하고.. 그 함수 실행이 끝나면 화면 갱신
    setState(() {
      if(favorited){
        favoriteCount -= 1;
        favorited = false;
      }else {
        favoriteCount += 1;
        favorited = true;
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    print('Stateful...build');
    return Row(
      children: [
        IconButton(
          onPressed: toggleFavorite,
          icon: (favorited) ? Icon(Icons.star) : Icon(Icons.star_border),
          color: Colors.red,
        ),
        Text('$favoriteCount')
      ],
    );
  }
}


