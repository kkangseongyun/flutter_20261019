main() {

  //옵셔널 매개변수는 nullable로 선언이 되던가, default 지정.
  void testFun1(bool data1, { String? data2, int data3 = 0 }){ }

  testFun1(true);
  testFun1(true, data2: 'hello', data3: 10);
  //이름이 명시됨으로.. 순서는 의미가 없다.
  testFun1(true, data3: 10, data2: 'hello');


  void testFun2(bool data1, [ String? data2, int data3 = 0 ]) { }

  testFun2(true);
  //positional parameter는 이름을 명시할 수 없다.
  // testFun2(true, data2: 'hello', data3: 20);//error..
  testFun2(true, 'hello');
  testFun2(true, 'hello', 20);
  // testFun2(true, 20);//error..
}