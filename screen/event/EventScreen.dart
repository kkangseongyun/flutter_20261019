import 'package:flutter/material.dart';
import 'dto/EventDto.dart';
import 'widgets/EventCard.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

//PageView 에 의한 화면 조정..
class EventScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return EventState();
  }
}

class EventState extends State<EventScreen> {
  //dto 데이터..
  List<EventDto> datas = [
    EventDto('assets/images/main_australia.jpg', '호주', '시드니+멜버른+브리즈번', '2.14(금) ~ 2.23(일)',
        '20%'),
    EventDto('assets/images/main_georgia.jpg', '조지아', '나리칼라+게르게티',
        '2.14(금) ~ 2.29(토)', '15%'),
    EventDto(
        'assets/images/main_hawaii.jpg', '하와이', '호놀룰루+마우이', '2.15(토) ~ 2.20(목)', '20%'),
    EventDto('assets/images/main_mongolia.jpg', '몽골', '울란바토르+알타이', '2.17(월) ~ 2.23(일)',
        '20%'),
    EventDto('assets/images/main_nepal.jpg', '네팔', '카트만두+ABC', '2.21(금) ~ 3.8(일)', '15%'),
  ];

  List<EventCard> makePageWidgets() {
    return datas.map((dto){
      return EventCard(dto);
    }).toList();
  }

  //PageView 에 지정..
  //PageView 의 초기 설정...
  //PageView에서 유저가 화면을 조정한 이벤트, 이벤트의 정보가 필요하다.==>Indicator에게 동일 이벤트 정보가 넘어가야 해서..
  //선언형 프로그래밍.. 정보만 설정한다. 우리가 이용하는 위젯이 실제 화면 출력 객체가 아니다.
  //유저 이벤트에 의해 발생한 데이터 획득을 우리가 이용한 위젯으로 얻을 수 없다..
  //유저 이벤트, 이벤트에 의한 데이터를 획득하기 위한 XXXController를 별도로 사용해서 지정한다.. 이벤트 데이터 이곳에 적용해줘...
  PageController controller = PageController(
    initialPage: 0,//초기 화면..
    viewportFraction: 0.9,//현 화면 왼쪽, 오른쪽 화면이 현 화면과 같이 얼마나 나와야 하는가
  );

  @override
  void dispose() {
    super.dispose();
    controller.dispose();//더이상 데이터 유지하지 않아도 된다.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF3899DD),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller,//이렇게 controller준비, 설정해야.. controller 정보대로 설정되고.. 유저 이벤트 정보 유지
                children: makePageWidgets(),
              ),
            ),
            SmoothPageIndicator(
              controller: controller,//PageView와 Indicator를 동일 controller로 지정하면 pageview의 이벤트 정보가 자동
              //indicator에 전달..
              count: 5,
              effect: WormEffect(
                dotColor: Colors.white,
                activeDotColor: Colors.yellow,
              ),
              onDotClicked: (index){},
            ),
            SizedBox(height: 32.0,),
          ],
        ),
      ),
    );
  }
}









