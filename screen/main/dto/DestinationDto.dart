//여행지 데이터 추상화 가정..
class DestinationDto {
  final int id;
  final String image;
  final String destination;
  final String discount;

  const DestinationDto({
    required this.id,
    required this.image,
    required this.destination,
    required this.discount
  });
}