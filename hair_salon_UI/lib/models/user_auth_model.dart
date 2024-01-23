// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserAuthModel {
  String? verficationId;
  bool? otpSent;
  String? phoneNumber;
  bool? isLoading;
  UserModel? user;
  // String? otp;
  UserAuthModel({
    this.verficationId,
    this.otpSent = false,
    this.phoneNumber,
    this.isLoading = false,
    this.user,
    // this.otp,
  });

  @override
  String toString() {
    return 'UserAuthModel(verficationId: $verficationId, otpSent: $otpSent, phoneNumber: $phoneNumber, isLoading: $isLoading, user: $user)';
  }

  UserAuthModel copyWith({
    String? verficationId,
    bool? otpSent,
    String? phoneNumber,
    bool? isLoading,
    UserModel? user,
    //  String? otp,
  }) {
    return UserAuthModel(
      verficationId: verficationId ?? this.verficationId,
      otpSent: otpSent ?? this.otpSent,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      //   otp: otp ?? this.otp,
    );
  }
}

class UserModel {
  final String username;
  final String image;
  final String phone;
  final String id;
  UserModel({
    required this.username,
    required this.image,
    required this.phone,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'image': image,
      'phone': phone,
      'id': id,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'],
      image: map['image'],
      phone: map['phone'],
      id: map['id'],
    );
  }
}
