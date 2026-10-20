import 'package:flutter/material.dart';
//상위 상태를 하위에 전파..
import 'package:provider/provider.dart';

void main() => runApp(ParentWidget());

class ParentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ParentState();
  }
}

class ParentState extends State<ParentWidget>{
  //상위 위젯에서 관리하는 상태, 하위에 전파되어야 하는 상태로 가정..
  int count = 0;

  void increment(){
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Lifecycle Test'),),
        body: Provider.value(//하위에 전파할 상태 선언..
          value: count,
          child: Column(
            children: [
              Text('I am Parent Widget, $count'),
              ElevatedButton(onPressed: increment, child: Text('increment')),
              ChildWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class ChildWidget extends StatefulWidget {
  ChildWidget(){
    print('ChildWidget constructor...');
  }
  @override
  State<StatefulWidget> createState() {
    return ChildState();
  }
}
//WidgetsBindingObserver - 앱의 라이프사이클 감지. 앱이 화면에 나오는 순간.. 화면에서 사라지는 순간..
class ChildState extends State<ChildWidget> with WidgetsBindingObserver{
  int count = 0;//상위에서 전파되는 상태 데이터..

  ChildState(){
    print('ChildState constructor..');
  }

  @override
  void initState() {
    super.initState();
    print('ChildState initState...');
    //이벤트 등록.. 위젯에서 발생하는 이벤트가 아니라..
    WidgetsBinding.instance.addObserver(this);//앱의 라이프 사이클 감지.. 콜백 함수 현 클래스에 있다.
  }

  @override
  void dispose() {
    super.dispose();
    //이벤트 등록 해제..
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('ChildState didChangeDependencies..');
    //상위 전파한 상태 획득..
    count = Provider.of<int>(context);
  }
  @override
  Widget build(BuildContext context) {
    print('ChildState build...');
    return Text('I am ChildWidget, $count');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch(state){
      case AppLifecycleState.resumed:
      case AppLifecycleState.inactive:
        print('resume...');
        break;
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        print('hidden...');
        break;
    }
  }
}

//최초 실행되었을 때...
//I/flutter ( 7027): ChildWidget constructor...
// I/flutter ( 7027): ChildState constructor..
// I/flutter ( 7027): ChildState initState...
// I/flutter ( 7027): ChildState didChangeDependencies..
// I/flutter ( 7027): ChildState build...

//상위 상태 변경시..
//I/flutter ( 7027): ChildWidget constructor...
// I/flutter ( 7027): ChildState didChangeDependencies..
// I/flutter ( 7027): ChildState build...
//==>위젯의 생성자는 매번 호출이다.. stateful도. 위젯은 불변이다.
//State 생성자는 다시 호출되지 않았다. 메모리에 지속된다..

//화면 출력 변경..
//I/flutter ( 7027): hidden...
//I/flutter ( 7027): resume...
