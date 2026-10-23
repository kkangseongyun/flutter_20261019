import 'package:flutter_riverpod/flutter_riverpod.dart';

// 상태 클래스
class MyInfo {
  final String email;
  final String phone;
  final String userImage;

  MyInfo({
    this.email = '',
    this.phone = '',
    this.userImage = 'assets/images/user_basic.jpg',
  });

  // copyWith로 일부만 변경
  MyInfo copyWith({
    String? email,
    String? phone,
    String? userImage,
  }) {
    return MyInfo(
      email: email ?? this.email,
      phone: phone ?? this.phone,
      userImage: userImage ?? this.userImage,
    );
  }
}

class MyInfoNotifier extends Notifier<MyInfo> {
  @override
  MyInfo build() => MyInfo();  // 초기 상태

  void saveMyInfo({String? email, String? phone, String? userImage}) {
    state = state.copyWith(
      email: email,
      phone: phone,
      userImage: userImage,
    );
  }
}

final myInfoProvider = NotifierProvider<MyInfoNotifier, MyInfo>(
  MyInfoNotifier.new,
);

