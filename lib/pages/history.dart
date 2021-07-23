import 'package:anime_db/styles/fontStyle.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.only(top: 50),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // title
                Text(
                  'History',
                  style: header,
                ),
                Icon(Icons.search, size: 32,),
                // search bar
                // SearchBar(setState: setState, buildDefaultAppBar: buildDefaultAppBar)
              ],
            ),
          ),
        ),
        body: HistoryList(),
      ),
    );
  }
}

class HistoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}