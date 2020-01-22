class RegisterMobile {
  String userId;
  bool requiredName;

  RegisterMobile({this.userId, this.requiredName});

  factory RegisterMobile.fromJson(Map<String, dynamic> json) =>
      new RegisterMobile(
        userId: json["userId"],
        requiredName: json["requiredName"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "requiredName": requiredName,
      };
}

class MobileRegisterResponse {
  int status;
  RegisterMobile data;

//  List<RegisterMobile> data;

  MobileRegisterResponse({this.status, this.data});

  factory MobileRegisterResponse.fromJson(Map<String, dynamic> resMap) =>
      new MobileRegisterResponse(
        status: resMap["status"],
        data: RegisterMobile.fromJson(resMap["data"]),
      );

  /*factory MobileRegisterResponse.fromJson(Map<String, dynamic> resMap) =>
      new MobileRegisterResponse(
        status: resMap["status"],
        data: (resMap['data'] as List)
            .map((model) => RegisterMobile.fromJson(model))
            .toList(),
      );*/

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data,
      };
}

class RequestBodyMobile {
  String mobile;
  String source;
  String language;
  String id;
  String deviceId;
  String deviceName;
  String deviceKey;
  String user_agent;
  String deviceType;
  String loggedin_on;
  String androidHash;

  RequestBodyMobile(
      {this.mobile,
      this.source,
      this.language,
      this.id,
      this.deviceId,
      this.deviceName,
      this.deviceKey,
      this.user_agent,
      this.deviceType,
      this.loggedin_on,
      this.androidHash});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['mobile'] = this.mobile;
    data['source'] = this.source;
    data['language'] = this.language;
    data['id'] = this.id;
    data['deviceId'] = this.deviceId;
    data['deviceName'] = this.deviceName;
    data['deviceKey'] = this.deviceKey;
    data['user_agent'] = this.user_agent;
    data['deviceType'] = this.deviceType;
    data['loggedin_on'] = this.loggedin_on;
    data['androidHash'] = this.androidHash;
    return data;
  }
}
