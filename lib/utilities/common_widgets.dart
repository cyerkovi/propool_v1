import 'package:flutter/material.dart';
import 'package:propool_v1/utilities/constants.dart';
import 'package:propool_v1/utilities/conf_pool_result.dart';

AppBar wAppBar = AppBar(
  backgroundColor: Colors.blue,
  title: Text(kTitleText),
);

/*
Drawer wMainDrawer = Drawer(
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
);
*/
