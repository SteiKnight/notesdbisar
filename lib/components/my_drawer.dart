import 'package:flutter/material.dart';
import 'package:notesdbisar/components/my_list_tile.dart';
import 'package:notesdbisar/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        DrawerHeader(
          child: Icon(
            Icons.note,
            size: 80,
          ),
        ),

        //notes
        MyListTile(
          icon: Icon(
            Icons.home,
            color: Provider.of<ThemeProvider>(context)
                .theme
                .colorScheme
                .inversePrimary,
          ),
          text: 'Notes',
          onTap: () => Navigator.pop(context),
        ),

        //settings
        MyListTile(
          icon: Icon(
            Icons.settings,
            color: Provider.of<ThemeProvider>(context)
                .theme
                .colorScheme
                .inversePrimary,
          ),
          text: 'Settings',
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/settings_page');
          },
        ),
      ],
    ));
  }
}
