import 'package:flutter/material.dart';
import 'package:notesdbisar/models/note.dart';
import 'package:notesdbisar/models/note_database.dart';
import 'package:notesdbisar/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  //text controller to access what the user typed in
  final textController = TextEditingController();

  //ititialstate with rnotes listed
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readNotes();
  }

  //create a note
  void createNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Note'),
        content: TextField(
          controller: textController,
          decoration: InputDecoration(
            hintText: 'Add Note',
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                child: Text('cancel'),
                onPressed: () {
                  Navigator.pop(context);
                  textController.clear();
                },
              ),
              MaterialButton(
                child: Text('create'),
                onPressed: () {
                  //add to db
                  context.read<NoteDatabase>().addNote(textController.text);

                  //pop dialog box
                  Navigator.pop(context);

                  //clear controller
                  textController.clear();
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  //read notes
  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  //update note
  void updateNote(Note note) {
    //prefill current note text into text controller
    textController.text = note.text;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Note'),
        content: TextField(
          controller: textController,
          decoration: InputDecoration(
            hintText: 'Add Note',
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                child: Text('cancel'),
                onPressed: () {
                  Navigator.pop(context);
                  textController.clear();
                },
              ),
              MaterialButton(
                child: Text('update'),
                onPressed: () {
                  //add to db
                  context
                      .read<NoteDatabase>()
                      .updateNote(note.id, textController.text);

                  //pop dialog box
                  Navigator.pop(context);

                  //clear controller
                  textController.clear();
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  //delete note
  void deleteNote(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Note Delete'),
        content: Text('Are you sure you want to delete this Note?'),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'no',
                  )),
              MaterialButton(
                  onPressed: () {
                    context.read<NoteDatabase>().deleteNote(id);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'yes',
                  )),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //note Database
    final noteDatabase = context.watch<NoteDatabase>();

    List<Note> currentNotes = noteDatabase.currentNotes;

    return Consumer<ThemeProvider>(
      builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: Text('Notes'),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: createNote,
            child: Icon(Icons.add),
          ),
          body: ListView.builder(
            itemCount: currentNotes.length,
            itemBuilder: (context, index) {
              //individual note
              final note = currentNotes[index];

              //return a tile;
              return ListTile(
                title: Text(note.text),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //edit button
                    IconButton(
                        onPressed: () => updateNote(note),
                        icon: Icon(
                          Icons.edit,
                          color: value.theme.colorScheme.inversePrimary,
                        )),

                    //delete button
                    IconButton(
                        onPressed: () => deleteNote(note.id),
                        icon: Icon(
                          Icons.delete,
                          color: value.theme.colorScheme.inversePrimary,
                        )),
                  ],
                ),
              );
            },
          )),
    );
  }
}
