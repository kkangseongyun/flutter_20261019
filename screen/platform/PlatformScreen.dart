import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlatformScreen extends StatefulWidget {
  @override
  PlatformScreenState createState() => PlatformScreenState();
}

class PlatformScreenState extends State<PlatformScreen> {


  String? resultMessage;
  String? receiveMessage;

  Future<Null> nativeCall() async {
    //채널 준비..
    var channel = BasicMessageChannel<String>('myMessageChannel', StringCodec());
    //데이터 전달.. 결과 리턴 받는다.
    String? result = await channel.send('Hello, I am Dart');
    setState(() {
      resultMessage = result;
    });

    //데이터 수신..
    //콜백 매개변수가 네이티브에서 전달한 데이터..
    channel.setMessageHandler((String? message) async{
      setState(() {
        receiveMessage = message;
      });
      //결과 리턴..
      return 'Dart Result Data';//네이티브에 전달된다.
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Channel Test")),
        body: Center(
          child: Column(
            children: (<Widget>[
              Text('result : $resultMessage'),
              Text('receive : $receiveMessage'),
              ElevatedButton(
                  onPressed: nativeCall,
                  child: Text('native call'),
              ),
            ]),
          ),
        )
    );
  }
}