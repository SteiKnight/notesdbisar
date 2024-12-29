import 'package:flutter/material.dart';
import 'package:notesdbisar/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class MyListTile extends StatelessWidget {
  final Widget icon;
  final String text;
  void Function()? onTap;

  MyListTile({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: ListTile(
        leading: icon,
        title: Text(
          text,
          style: TextStyle(
            color: Provider.of<ThemeProvider>(context)
                .theme
                .colorScheme
                .inversePrimary,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
