import 'package:anime_db/styles/fontStyle.dart';
import 'package:anime_db/styles/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.only(top: 50),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(children: [
              Text(
                'Setting',
                style: header,
              )
            ]),
          ),
          SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Dark Mode'),
              ChangeThemeButtonWidget(),
            ],
          ),
        ],
      ),
    );
  }
}

class ChangeThemeButtonWidget extends StatelessWidget {
  const ChangeThemeButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Switch.adaptive(
        value: themeProvider.isDarkMode,
        onChanged: (value) {
          final provider = Provider.of<ThemeProvider>(context, listen: false);
          provider.toggleTheme(value);
        });
  }
}
