import 'dart:convert';
import 'package:bzinga/authentication/models/verifyMobileOtp.dart';
import 'package:bzinga/colors.dart';
import 'package:bzinga/constants.dart';
import 'package:bzinga/utils/sharedPrefs.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'models/registerMobileNumber.dart';

class VerifyOtp extends StatefulWidget {
  final String mobileNumber;
  final RegisterMobile mobile;
  final String deviceId;
  final String deviceType;
  final String fcmToken;

  VerifyOtp(
      {Key key,
      this.mobile,
      this.deviceType,
      this.deviceId,
      this.mobileNumber = '',
      this.fcmToken})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return VerifyOtpState();
  }
}

class VerifyOtpState extends State<VerifyOtp> {
  final otpController = TextEditingController();
  bool isAccepted = false;

  TapGestureRecognizer tapRight = TapGestureRecognizer()
    ..onTap = () {
      print("Clicked GET OTP");
    };

  void verifyOtpCall() async {
    String location = await SharedPrefs().getCity();
    if (isAccepted) {
      var requestBody = RequestBodyOtp(
        id: widget.mobile.userId,
        otp: otpController.text,
        mobile: widget.mobileNumber,
        deviceId: widget.deviceId,
        deviceType: widget.deviceType,
        deviceToken: "",
        deviceLocation: location,
      );

      var url = Constants.VERIFY_OTP;

      Response res = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode(requestBody));

      if (res.statusCode == 200) {
        print(json.decode(res.body));
        OtpResponse otpResponse = OtpResponse.fromJson(json.decode(res.body));
        Fluttertoast.showToast(
            msg: 'Otp verification successfull', gravity: ToastGravity.BOTTOM);
        print(otpResponse);
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Please accept the terms and conditions of user',
          gravity: ToastGravity.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 125),
        child: Center(
          child: Column(
            children: <Widget>[
              Text('Enter your name & OTP',
                  style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
              Container(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(widget.mobileNumber)),
              Visibility(
                child: Container(
                  padding: EdgeInsets.only(top: 24, left: 24, right: 24),
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: 'Enter your name',
                        hintStyle: TextStyle(color: CustomColor.hintColor)),
                  ),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 16, left: 24, right: 24, bottom: 8),
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: otpController,
                  decoration: InputDecoration(
                      hintText: 'Enter OTP here',
                      hintStyle: TextStyle(color: CustomColor.hintColor)),
                ),
              ),
              Text.rich(TextSpan(
                  text: 'Didn`t receive the OTP? ',
                  children: <TextSpan>[
                    TextSpan(
                        recognizer: tapRight,
                        text: 'Get Otp',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationThickness: 2,
                            decorationColor: Colors.redAccent)),
                  ])),
              Container(
                width: 200,
                padding: EdgeInsets.only(top: 24, bottom: 16),
                child: RaisedButton(
                  child: Text('Continue'),
                  onPressed: verifyOtpCall,
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Checkbox(
                      value: isAccepted,
                      onChanged: (bool value) {
                        setState(() {
                          isAccepted = value;
                        });
                      },
                      activeColor: Colors.pink,
                      checkColor: Colors.white,
                      tristate: false,
                    ),
                    Text.rich(
                      TextSpan(
                          text: 'By accepting, you agree to our\n',
                          children: <TextSpan>[
                            TextSpan(
                              recognizer: tapRight,
                              text: 'Terms and Conditions',
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                            TextSpan(text: ' of use'),
                          ]),
                      textAlign: TextAlign.center,
                    ),
                  ])
            ],
          ),
        ),
      ),
    );
  }
}
