//함수 선언시 리턴 타입 명시가능. 생략하면 dynamic
//이름만 main 이면 dart engine 의 entry point
main(){
  //모든 변수는 객체이다..
  int data1 = 10;
  print(data1.isEven);

  //모든 변수가 객체임으로 자바같은 언어의 기초타입 캐스팅 불가하다.
  // double data2 = data1;//error.. 캐스팅을 논할 수 없다. 암시적, 명시적 모두 안된다.
  double data2 = data1.toDouble();
  int data3 = data2.toInt();

  //String <-> int
  String data4 = '10';
  int data5 = int.parse(data4);
  String data6 = data5.toString();

  //var, dynamic...
  int a = 10;
  // a = true;//error..

  var b = 10;//대입되는 값에 의해 int 로 고정..
  // b = true;//error..

  //any 타입...
  dynamic c = 10;
  c = true;
  c = 'hello';

  var e;//타입 유추 기법이다. 선언과 동시에 데이터를 지정하지 않으면 타입 유추가 안된다.==>dynamic 타입이 된다.
  e = 10;
  e = true;

  //null safety....
  User user1 = User();//객체 생성, new 예약어 지원한다. 생략 가능하다. 대부분 생략한다.
  // user1 = null;//error..
  user1.name = 'kim';//ok

  User? user2 = User();
  user2 = null;//ok....
  user2?.name = 'lee';
}

class User {
  String name = 'none';
}