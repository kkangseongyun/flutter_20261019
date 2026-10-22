import 'package:flutter/material.dart';

class MyInfoScreen extends StatefulWidget {

  String? id;
  String? keyword;
  Map<String, dynamic>? extra;

  MyInfoScreen({this.id, this.keyword, this.extra});

  @override
  State<MyInfoScreen> createState() => _MyInfoScreenState();
}

class _MyInfoScreenState extends State<MyInfoScreen> {

  //유저 입력 데이터 저장....
  String? email = '';
  String? phone = '';
  String _userImage = 'assets/images/user_basic.jpg';

  //Form 위젯을 사용한다면 key 매핑후 원하는 시점에 key 로 State객체 획득..
  //key로 State객체 획득하려면 key가 꼭 GlobalKey 로 준비되어야..
  final _formKey = GlobalKey<FormState>();

  //최종 데이터 저장을 위해서 호출되는 개발자 함수..
  Future<void> _saveData() async {
    print('$email, $phone, $_userImage');
  }

  @override
  void initState() {
    super.initState();
    //State 에서 State의 위젯 데이터 참조 방법...
    print('${widget.id}, ${widget.keyword}, ${widget.extra}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 정보'),
        actions: [
          TextButton(
              onPressed: (){
                //key 로 FormState 획득..
                final form = _formKey.currentState;
                //validate() - 모든 하위의 validator() 호출, 전체 null이면 true, 하나라도 null 이 아니면 false
                if(form?.validate() ?? false){
                  form?.save();//하위 onSaved() 함수 호출..
                  _saveData();
                }
              }, 
              child: Text('저장', style: TextStyle(color: Colors.black, fontSize: 16,),),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              // 원형 프로필 이미지
              Card(
                elevation: 0,
                shape: CircleBorder(),
                clipBehavior: Clip.antiAlias,
                child: Container(
                  width: 150,
                  height: 150,
                  child: Image.asset(_userImage, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 24),
              // Gallery 버튼
              ElevatedButton(
                onPressed: (){},
                child: Text('Gallery App'),
              ),
              SizedBox(height: 24),
              // Camera 버튼
              ElevatedButton(onPressed: (){}, child: Text('Camera App')),
              SizedBox(height: 30),

              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //Form 을 이용하면 유저 입력 부분을 Form과 상호 연동이 가능한 위젯으로 준비
                    //TextField 안되고.. TextFormField 를 사용해야 한다..
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Email'),
                      //FormState의 validate() 호출 순간 하위 위젯의 모든 validator() 함수 자동 호출..
                      //매개변수가 유저가 현재 입력한 데이터..
                      validator: (value){
                        if(value?.isEmpty ?? false){
                          return 'enter your email';//invalid.. 리턴 문자열이 에러 메시지. 자동 출력..
                        }
                        return null;//valid
                      },
                      //FormState 의 save() 호출시에 하위 위젯의 모든 onSaved 호출.. 매개변수가 유저입력 데이터.
                      onSaved: (value) => setState(() {
                        email = value;
                      }),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Phone'),
                      validator: (value){
                        if(value?.isEmpty ?? false){
                          return 'enter your phone';
                        }
                        return null;//valid
                      },
                      onSaved: (value) => setState(() {
                        phone = value;
                      }),
                    ),
                  ],
                ),
              ),
		
            ],
          ),
        ),
      ),
    );
  }
}
