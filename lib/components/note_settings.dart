import 'package:flutter/material.dart';

class NoteSettings extends StatelessWidget {
  final void Function()? onEditTap;
  final void Function()? onDeleteTap;
  const NoteSettings({
    super.key,
    required this.onDeleteTap,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //edit button
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              onEditTap!();
            },
            child: Container(
              margin: EdgeInsets.only(top: 10),
              height: 20,
              //color: Theme.of(context).colorScheme.surface,
              child: Text(
                'edit',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),

          Divider(
            color: Theme.of(context).colorScheme.secondary,
            indent: 15,
            endIndent: 15,
          ),

          //delete button
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              onDeleteTap!();
            },
            child: Container(
              height: 30,
              child: Text(
                'delete',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
