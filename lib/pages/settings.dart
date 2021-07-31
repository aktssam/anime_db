import 'package:anime_db/styles/fontStyle.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(children: [
          Text(
            'Setting',
            style: header,
          )
        ]),
      ),
    );
  }
}
