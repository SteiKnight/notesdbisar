import 'package:flutter/material.dart';
import 'package:notesdbisar/components/note_settings.dart';
import 'package:notesdbisar/models/note.dart';
import 'package:popover/popover.dart';

class NoteTile extends StatelessWidget {
  final String text;
  final void Function()? onDeletePressed;
  final void Function()? onEditPressed;
  NoteTile({
    super.key,
    required this.text,
    required this.onDeletePressed,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:10, left:20, right:20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        title: Text(text),
        trailing: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () => showPopover(
              width: 80,
              height: 80,
              backgroundColor: Theme.of(context).colorScheme.surface,
              context: context,
              bodyBuilder: (context) => NoteSettings(
                  onDeleteTap: onDeletePressed, onEditTap: onEditPressed),
            ),
          );
        }),
      ),
    );
  }
}
