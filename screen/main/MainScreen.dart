import 'package:flutter/material.dart';
import 'package:flutter_lab/screen/event/EventScreen.dart';
import 'package:flutter_lab/screen/main/widgets/MainDrawer.dart';
import 'package:flutter_lab/screen/myinfo/MyInfoScreen.dart';
import 'dto/DestinationDto.dart';
import 'widgets/DestinationCard.dart';

class MainScreen extends StatelessWidget {
  //서버에서 구한 가상의 데이터 가정..
  List<DestinationDto> destinations = [
    DestinationDto(
      id: 1,
      image: 'assets/images/main_swiss.jpg',
      destination: '스위스',
      discount: '최대 20% 할인',
    ),
    DestinationDto(
      id: 2,
      image: 'assets/images/main_australia.jpg',
      destination: '호주',
      discount: '최대 10% 할인',
    ),
    DestinationDto(
      id: 3,
      image: 'assets/images/main_georgia.jpg',
      destination: '조지아',
      discount: '최대 20% 할인',
    ),
    DestinationDto(
      id: 4,
      image: 'assets/images/main_mongolia.jpg',
      destination: '몽골',
      discount: '최대 20% 할인',
    ),
    DestinationDto(
      id: 5,
      image: 'assets/images/main_nepal.jpg',
      destination: '네팔',
      discount: '최대 15% 할인',
    ),
    DestinationDto(
      id: 6,
      image: 'assets/images/main_hawaii.jpg',
      destination: '하와이',
      discount: '최대 5% 할인',
    ),
  ];

  //화면에 출력하기 위한 위젯을 준비하는 개발자 함수, build에서 호출..
  List<Widget> _makeDestinationGrid() {
    return destinations.map((destination){
      return DestinationCard(destination);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MainScreen'),
      ),
      drawer: MainDrawer(),
      //화면구성, 여러 위젯 나열, 가로/세로 화면 벗어나면 기본 스크롤 지원하지 않느낟.
      //노란색/검정색 패턴이 출력된다.
      //SingleChildScrollView : 자식은 하나..
      //ListView : 자식 여러개..
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(//화면의 영역 설정, 사이즈, align, 여백, 백그라운드등등..
              width: double.infinity,
              constraints: BoxConstraints(maxHeight: 300),//세로방향으로.. 너네 사이즈 유지해.
              //단 300을 넘을 수는 없어..
              child: Image.asset(
                'assets/images/main_bg_1.jpg',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '특가 여행지',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EventScreen()));
                    },
                    label: Text('특가 여행지 보기'),
                    icon: Icon(Icons.arrow_drop_down, size: 20,),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3899DD),
                      foregroundColor: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.count(
                shrinkWrap: true,//GridView는 사이즈 계산할 때 무한 공간 차지가 기본, 너네 콘텐츠 만큼 사이즈 확보
                //GridView는 기본 자체 스크롤 지원해서. 항목 스크롤이 된다. 하지마라..
                //화면 전체 스크롤에 의해 스크롤 되게 하고 싶어서..
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,//한줄에 2개..
                childAspectRatio: 0.85,//가로/세로 비율..
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: _makeDestinationGrid(),
              ),
            ),

            // ElevatedButton(
            //     onPressed: (){
            //       Navigator.push(context, MaterialPageRoute(builder: (context) => MyInfoScreen()));
            //     },
            //     child: Text('Go MyInfo'),
            // )

          ],
        ),
      )


    );
  }
}















