class User {
  String? name;
  int? age;

  //case1
  // User(String name, int age){
  //   this.name = name;
  //   this.age = age;
  // }

  //case2
  // User(this.name, this.age);

  //case3 - 매개변수를 이용해 약간의 알고리즘(한줄), 결과로 멤버 초기화
  User(String name, int age): this.name = name.toUpperCase(), this.age = age * 10;

  //named constructor.................
  User.one(){}
  User.two(): this('kim', 20);
  User.three(): this.one();
}

class Singleton {
  int data = 0;
  //객체가 생성되려면 factory 생성자가 아닌 다른 생성자가 있어야 한다.
  //내부에서만 생성하게 해야 한다. singleton 알고리즘을 구현하려면..
  Singleton._privateContructor();
  static final Singleton _instance = Singleton._privateContructor();
  factory Singleton() => _instance;
}

main(){
  var obj1 = new User('kim', 20);
  var obj2 = new User.one();

  var obj3 = Singleton();
  var obj4 = Singleton();
  obj3.data = 10;
  obj4.data = 20;

  print('${obj3.data}, ${obj4.data}');//20, 20
}