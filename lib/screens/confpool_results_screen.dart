import 'package:flutter/material.dart';
import 'package:propool_v1/utilities/conf_pool_result.dart';
import 'package:propool_v1/utilities/styles.dart';
import 'package:propool_v1/utilities/common_widgets.dart';
import 'package:propool_v1/utilities/constants.dart';

class ConfpoolResultsScreen extends StatelessWidget {
  ConfpoolResultsScreen(this.resultsData);

  ConfPoolResult resultsData;

  Widget _body() {
    if (resultsData.results != null) {
      return Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(
              resultsData.title,
              style: kTitleTextStyle,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            Text(resultsData.message),
            if (resultsData.results.length != 0)
              DataTable(
                columns: [
                  DataColumn(
                    label: Text('Rank'),
                  ),
                  DataColumn(
                    label: Text('Name'),
                  ),
                  DataColumn(
                    label: Text('Score'),
                  ),
                ],
                rows: resultsData.results
                    .map(
                      (item) => DataRow(cells: [
                        DataCell(Text(item.rank_dsply)),
                        DataCell(Text(item.name + item.name_appendage)),
                        DataCell(Text(item.points.toString()))
                      ]),
                    )
                    .toList(),
              ),
          ]),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Column(children: [
          Text(
            resultsData.title,
            style: kTitleTextStyle,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
          if (resultsData.message != null) Text(resultsData.message),
        ]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wAppBar,
      // endDrawer: wMainDrawer,
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: SafeArea(child: _body()),
      ),
    );
  }
}
