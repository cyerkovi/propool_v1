import 'package:flutter/material.dart';
import 'package:propool_v1/screens/confpool_results_screen.dart';
import 'package:propool_v1/utilities/constants.dart';
import 'package:propool_v1/utilities/common_widgets.dart';
import 'package:propool_v1/utilities/conf_pool_result.dart';
import 'package:propool_v1/screens/sign_in_screen.dart';
import 'package:propool_v1/services/propool_server_api.dart';

class HomeScreen extends StatelessWidget {
  @override
  void getConfPoolResults(context, endPoint) async {
    ConfPoolResult resultsData =
        await ProPoolServer().getConfPoolResults(endPoint);

    // navigate to the weekly results page, passing in the json
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ConfpoolResultsScreen(resultsData);
    }));
  }

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
        appBar: wAppBar,
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: SafeArea(
            child: Container(),
          ),
        ),
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: <Widget>[
              DrawerHeader(
                child: Text(kDrawerHeaderText),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text(kConfPoolSeasonGameSetResultsText),
                onTap: () {
                  getConfPoolResults(context, kConfpoolSeasongamesetResults);
                },
              ),
              ListTile(
                title: Text(kConfPoolSeasonResultsText),
                onTap: () {
                  getConfPoolResults(context, kConfpoolSeasonResults);
                },
              ),
              ListTile(
                title: Text(kSignOutLabelText),
                onTap: () {
                  logOutUser(context);
                },
              ),
            ],
          ),
        ));
  }
}
