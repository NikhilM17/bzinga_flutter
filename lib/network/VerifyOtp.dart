import 'package:flutter/material.dart';

class VerifyOtp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Success',
              style: TextStyle(
                fontSize: 18,
                color: Colors.deepPurple
              ),
            )
          ],
        ),
      ),
    );
  }
}
