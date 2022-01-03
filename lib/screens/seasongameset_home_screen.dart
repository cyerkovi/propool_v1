import 'package:flutter/material.dart';
import 'package:propool_v1/utilities/common_widgets.dart';

class SeasongamesetHomeScreen extends StatefulWidget {
  const SeasongamesetHomeScreen({Key key}) : super(key: key);
  // SeasongamesetHomeScreen(this.seasongamesetData);

  @override
  _SeasongamesetHomeScreenState createState() =>
      _SeasongamesetHomeScreenState();
}

class _SeasongamesetHomeScreenState extends State<SeasongamesetHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wAppBar,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.topCenter,
          child: Column(children: [
            Text('Seasongameset is '),
          ]),
        ),
      ),
    );
  }
}
