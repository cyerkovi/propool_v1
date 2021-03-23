import 'package:flutter/material.dart';
import 'package:propool_v1/utilities/constants.dart';
import 'package:propool_v1/screens/sign_in_screen.dart';
import 'package:propool_v1/services/propool_server_api.dart';

class HomeScreen extends StatelessWidget {
  @override
  void logOutUser(context) async {
    // first revoke the auth token
    String logOutStatus = await ProPoolServer().logout();
    if (logOutStatus == 'Success') {
      // next clear the navigator stack and navigate to the login page
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => SignInScreen()),
          (route) => false);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar,
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: SafeArea(
          child: Container(),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                logOutUser(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
