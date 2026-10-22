import 'package:flutter/material.dart';
import 'package:flutter_lab/screen/detail/DetailScreen.dart';
import 'package:go_router/go_router.dart';
import '../dto/DestinationDto.dart';

class DestinationCard extends StatelessWidget {

  final DestinationDto destinationDto;

  const DestinationCard(this.destinationDto);

  @override
  Widget build(BuildContext context) {
    return Card(
      //그림자효과..
      elevation: 10,
      //둥근 사각형.. CircleBorder..
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      //이벤트만 처리하기 위한 위젯..
      //GestureDetector : 유저 이벤트에 의한 시각효과 없다.
      //InkWell : 유저 이벤트에 의한 잉크 번짐 효과 적용..
      child: InkWell(
        onTap: (){
          // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen()));
          context.push('/detail', extra: {
            'destination': destinationDto,
          });
        },
        //잉크 번짐효과가.. round rect 밖에까지 진행되지 않게 하기 위해서..
        borderRadius: BorderRadius.circular(10),
        child: Padding(//여백만 설정하는 위젯..
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //여백이 발생한다면 여백을 모두 차지한다.
              //아래에 추가한 것이 하단에 붙는다.
              Expanded(
                child: ClipRRect(//round rect
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    destinationDto.image,
                    width: 150,
                    fit: BoxFit.cover,//위젯의 사이즈와 화면에 출력되는 이미지의 사이즈가 다른 경우 어떻게?
                  ),
                ),
              ),
              SizedBox(height: 4,),//여백만 차지하는 위젯..
              Text(
                destinationDto.destination,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                destinationDto.discount,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}