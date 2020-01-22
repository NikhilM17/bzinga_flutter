import 'dart:convert';
import 'dart:io';
import 'package:bzinga/constants.dart';
import 'package:bzinga/network/VerifyOtp.dart';
import 'package:bzinga/widgets/button.dart';
import 'package:bzinga/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:device_info/device_info.dart';
import 'package:http/http.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(display1: TextStyle(fontFamily: 'Raleway')),
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Bzinga'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

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

class _MyHomePageState extends State<MyHomePage> {
  var requestBody;
  final myController = TextEditingController();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  AndroidDeviceInfo androidInfo;
  IosDeviceInfo iosDeviceInfo;

  fetchDeviceInfo(bool isAndroid) async {
    if (isAndroid) {
      androidInfo = await deviceInfo.androidInfo;
      requestBody = RequestBodyMobile(
              mobile: myController.text,
              source: "mobile",
              language: "English",
              deviceId: androidInfo.androidId,
              deviceName: androidInfo.model,
              deviceKey: androidInfo.id,
              user_agent: androidInfo.product,
              deviceType: 'android',
              loggedin_on: new DateTime.now().millisecondsSinceEpoch.toString(),
              androidHash: "xdEGBTEgY7u")
          .toJson();
    } else {
      iosDeviceInfo = await deviceInfo.iosInfo;
      requestBody = RequestBodyMobile(
              mobile: myController.text,
              source: "mobile",
              language: "English",
              deviceId: iosDeviceInfo.identifierForVendor,
              deviceName: iosDeviceInfo.model,
              deviceKey: "",
              user_agent: "",
              deviceType: 'ios',
              loggedin_on: new DateTime.now().millisecondsSinceEpoch.toString(),
              androidHash: "xdEGBTEgY7u")
          .toJson();
    }
    registerMobileNumber();
  }

  Future<MobileRegisterResponse> registerMobileNumber() async {
    var url = Constants.REGISTER_MOBILE_NUMBER;

    print(json.encode(requestBody));

    Response res = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(requestBody));
    if (res.statusCode == 200) {
      MobileRegisterResponse response =
          MobileRegisterResponse.fromJson(json.decode(res.body));
      if (response != null) {
        if (response.status == 200 && response.data != null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => VerifyOtp()));
        }
      }
    } else
      print(res.statusCode.toString() + " : failed");

//    List<RegisterMobile> languageData = MobileRegisterResponse.fromJson(data).data;

    /* if (languageData != null) {
      for (RegisterMobile languages in languageData) {
        print(languages.value);
      }
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.black87,
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Container(
                padding: new EdgeInsets.only(top: 10),
                child: TextWidget(content: 'Enter your mobile number')
                /*Text(
                'Enter your mobile number',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
              ),*/
                ),
            Padding(
              padding: new EdgeInsets.only(top: 10),
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                style: new TextStyle(color: Colors.white),
                controller: myController,
                maxLength: 10,
                decoration: InputDecoration(
                    hintText: "Enter Mobile number",
                    hintStyle:
                        TextStyle(fontSize: 16, color: Color(0x34FFFFFF))),
              ),
            ),
            ButtonWidget(
              title: 'GET OTP',
              onPressed: () => fetchDeviceInfo(Platform.isAndroid),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
