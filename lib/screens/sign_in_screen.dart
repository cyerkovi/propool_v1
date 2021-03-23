import 'package:flutter/material.dart';
import 'package:propool_v1/utilities/constants.dart';
import 'package:propool_v1/utilities/styles.dart';
import 'package:propool_v1/screens/home_screen.dart';
import 'package:propool_v1/services/propool_server_api.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String email;
  String password;
  String messageToScreen = '';

  void authenticateUser() async {
    String loginStatus = await ProPoolServer().login(email, password);
    // status can be:
    // Success
    // Invalid User/Password
    // Service Unavailable
    // Access Denied
    //
    if (loginStatus == 'Success') {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomeScreen();
      }));
    } else if (loginStatus == "") {
      setState(() {
        messageToScreen = 'Unknown Login Error';
      });
    } else {
      setState(() {
        messageToScreen = loginStatus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                width: 350.0,
                child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: kEmailLabelText),
                    style: kInputTextStyle,
                    onChanged: (value) {
                      email = value;
                    }),
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: 350.0,
                child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: kPasswordLabelText,
                    ),
                    style: kInputTextStyle,
                    onChanged: (value) {
                      password = value;
                    }),
              ),
              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    // print(email);
                    // print(password);
                    authenticateUser();
                  },
                  child: Text(
                    kSignInLabelText,
                    style: kButtonTextStyle,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Text(
                  '$messageToScreen',
                  style: kInputTextStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
