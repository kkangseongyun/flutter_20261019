import 'package:flutter/material.dart';
import 'package:flutter_lab/screen/main/dto/DestinationDto.dart';
import 'package:go_router/go_router.dart';
import 'widgets/DetailMainWidget.dart';
import 'widgets/DetailNewsWidget.dart';

class DetailScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return DetailScreenState();
  }
}

class DetailScreenState extends State<DetailScreen> {
  //현재 선택된 탭 index, 상태..
  int selectedIndex = 0;

  //탭화면 구성 위젯 목록..
  List<Widget> widgets = [
    DetailMainWidget(),
    DetailNewsWidget(),
  ];

  //tab button 이벤트 콜백..
  void onItemTapped(int index){
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    final state = GoRouterState.of(context);
    final extra = state.extra as Map<String, dynamic>;
    DestinationDto dto = extra['destination'] as DestinationDto;

    return Scaffold(
      //화면 상단을 다양하게 꾸미고.. body 에서 스크롤이 발생할 때 접히게 하고 싶다.
      //일반 AppBar는 그 능력이 없다..
      //NestedScrollView : 화면이 어느쪽 스크롤이 발생했을 때 다른쪽이 같이 스크롤 되게 하려면 스크롤 정보
      //중제자가 있어야 한다.
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool scrolled){
            return [
              //AppBar, 스크롤 정보를 받아서 접히는 AppBar
              SliverAppBar(
                expandedHeight: 250.0,
                //접혔다가 거꾸로 스크롤 될때 다시 나와야 한다. 처음부터 나타날 것인가(true), 맨 마지막에 나타날것인가(false)
                floating: false,
                //접힐때 한줄은 남긴다(true), 완전히 다 사라진다(false)
                pinned: true,
                backgroundColor: Color(0xFF3899DD),
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(dto.destination, style: TextStyle(color: Colors.white),),
                  titlePadding: EdgeInsets.only(left: 56, bottom: 16,),
                  expandedTitleScale: 1.0,//접힐때 작아졌다가 펼처질때 크게 할 수 있다. 배율..
                  background: Image.asset('assets/images/detail_main.jpg', fit: BoxFit.cover,),
                ),
              )
            ];
          },
          body: widgets.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,//탭 버튼 클릭시, 탭 버튼 애니메이션 효과 적용, 적용하지 않는다(fixed)
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Main',
            backgroundColor: Color(0xFF3899DD),//이 버튼이 선택되면 bar 전체의 백그라운드 색상..
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'News',
            backgroundColor: Colors.red,//이 버튼이 선택되면 bar 전체의 백그라운드 색상..
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.amber,//선택된 버튼 색상..
        onTap: onItemTapped,
      ),
    );
  }
}
