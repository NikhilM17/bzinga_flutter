import 'dart:convert';
import 'dart:io';
import 'package:bzinga/authentication/models/registerMobileNumber.dart';
import 'package:bzinga/colors.dart';
import 'package:bzinga/constants.dart';
import 'package:bzinga/authentication/VerifyOtp.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class MobileNumber extends StatefulWidget {
  final String title;

  MobileNumber({Key key, this.title}) : super(key: key);

  @override
  MobileNumberState createState() => MobileNumberState();
}

class MobileNumberState extends State<MobileNumber> {
  var requestBody;
  final myController = TextEditingController();
  String fcmToken;
  String deviceType = Platform.isAndroid ? 'android' : 'ios';

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  _register() {
    _firebaseMessaging
        .getToken()
        .then((token) => {this.fcmToken = token, print(token)});
  }

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
              deviceType: deviceType,
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
              deviceType: deviceType,
              loggedin_on: new DateTime.now().millisecondsSinceEpoch.toString(),
              androidHash: "xdEGBTEgY7u")
          .toJson();
    }
    registerMobileNumber();
  }

  void registerMobileNumber() async {
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
              context,
              MaterialPageRoute(
                  builder: (context) => VerifyOtp(
                      fcmToken: fcmToken,
                      deviceId: Platform.isAndroid
                          ? androidInfo.androidId
                          : iosDeviceInfo.identifierForVendor,
                      deviceType: deviceType,
                      mobile: response.data,
                      mobileNumber: myController.text)));
        }
      }
    } else
      print(res.statusCode.toString() + " : failed");

    /*List<RegisterMobile> languageData = MobileRegisterResponse.fromJson(data).data;
     if (languageData != null) {
      for (RegisterMobile languages in languageData) {
        print(languages.value);
      }
    }*/
  }

  @override
  Widget build(BuildContext context) {
    _register();
    print("Mobile Number build called");
    return Scaffold(
      body: Container(
        padding: new EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 120),
              child: //TextWidget(content: 'Enter your mobile number')
                  Text(
                'Enter your mobile number',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              padding: new EdgeInsets.only(top: 10),
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly,
                ],
                controller: myController,
                maxLength: 10,
                style: TextStyle(fontWeight: FontWeight.w900),
                decoration: InputDecoration(
                    border: new UnderlineInputBorder(
                        borderSide:
                            new BorderSide(color: CustomColor.underline)),
                    counterText: "",
                    hintText: "Enter Mobile number",
                    hintStyle: TextStyle(
                        fontSize: 16,
                        color: CustomColor.hintColor,
                        fontWeight: FontWeight.w900)),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 8, bottom: 24),
              child: Text('We never share your number with anyone.'),
            ),
            Container(
              width: 250,
              padding: EdgeInsets.only(left: 24, right: 24, top: 24),
              child: RaisedButton(
                child: Text(
                  'GET OTP',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                onPressed: () => fetchDeviceInfo(Platform.isAndroid),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
