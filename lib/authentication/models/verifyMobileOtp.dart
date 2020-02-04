class RequestBodyOtp {
  String id;
  String mobile;
  String otp;
  String deviceId;
  String deviceToken;
  String deviceType;
  String deviceLocation;

  RequestBodyOtp(
      {this.id,
      this.mobile,
      this.otp,
      this.deviceId,
      this.deviceToken,
      this.deviceType,
      this.deviceLocation});

  factory RequestBodyOtp.fromJson(Map<String, dynamic> json) =>
      new RequestBodyOtp(
          id: json["id"],
          mobile: json["mobile"],
          otp: json['otp'],
          deviceId: json['deviceId'],
          deviceToken: json['deviceToken'],
          deviceType: json['deviceType'],
          deviceLocation: json['deviceLocation']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "mobile": mobile,
        "otp": otp,
        "deviceId": deviceId,
        "deviceToken": deviceToken,
        "deviceType": deviceType,
        "deviceLocation": deviceLocation,
      };
}

class OtpResponse {
  int status;
  String message;
  String token;
  User userDetails;

  OtpResponse({this.status, this.message, this.token, this.userDetails});

  factory OtpResponse.fromJson(Map<String, dynamic> json) => new OtpResponse(
      status: json["status"],
      message: json.containsKey('message') ? json["message"] : "",
      token: json['token'],
      userDetails: json.containsKey("userDetails")
          ? User.fromJson(json["userDetails"])
          : null);

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "token": token,
        "userDetails": userDetails,
      };
}

class User {
  String id;
  String profilePicture;
  String mobile;
  bool status;
  String lastName;
  String userLanguage;
  String firstName;
  String gender;
  String email;
  String loginSourceId;
  String loginSource;
  String defaultAddressId;
  String city;
  Address address;
  bool smsPromotion;
  String country;
  String pinCode;
  String state;

  User(
      {this.id,
      this.profilePicture,
      this.mobile,
      this.status,
      this.lastName,
      this.userLanguage,
      this.firstName,
      this.gender,
      this.email,
      this.loginSourceId,
      this.loginSource,
      this.defaultAddressId,
      this.city,
      this.address,
      this.smsPromotion,
      this.country,
      this.pinCode,
      this.state});

  factory User.fromJson(Map<String, dynamic> json) => new User(
      id: json["id"],
      profilePicture: json["profilePicture"],
      mobile: json['mobile'],
      state: json['state'],
      lastName: json['lastName'],
      userLanguage: json['userLanguage'],
      firstName: json['firstName'],
      gender: json['gender'],
      email: json['email'],
      loginSourceId: json['loginSourceId'],
      loginSource: json['loginSource'],
      defaultAddressId: json['defaultAddressId'],
      city: json['city'],
      address: Address.fromJson(json['address']),
      smsPromotion: json['smsPromotion'],
      country: json['country'],
      pinCode: json['pinCode'],
      status: json['status']);

  Map<String, dynamic> toJson() => {
//        "addressLine1": addressLine1,
//        "addressLine2": addressLine2,
      };
}

class Address {
  String addressLine1;
  String addressLine2;

  Address({this.addressLine1, this.addressLine2});

  factory Address.fromJson(Map<String, dynamic> json) => new Address(
        addressLine1: json["addressLine1"],
        addressLine2: json["addressLine2"],
      );

  Map<String, dynamic> toJson() => {
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
      };
}
