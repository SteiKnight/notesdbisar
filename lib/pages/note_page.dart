import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesdbisar/components/my_drawer.dart';
import 'package:notesdbisar/components/note_tile.dart';
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
          foregroundColor: value.theme.colorScheme.inversePrimary,
          //title: Text('Notes'),
          //centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNote,
          child: Icon(
            Icons.add,
            color: value.theme.colorScheme.inversePrimary,
          ),
        ),
        //backgroundColor: value.theme.colorScheme.surface,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Title
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Text(
                'Notes',
                style: GoogleFonts.dmSerifText(
                  fontSize: 48,
                ),
              ),
            ),
            //List of notes
            Expanded(
              child: ListView.builder(
                itemCount: currentNotes.length,
                itemBuilder: (context, index) {
                  //individual note
                  final note = currentNotes[index];

                  //return a tile;
                  return NoteTile(
                      text: note.text,
                      onDeletePressed: ()=>deleteNote(note.id) ,
                      onEditPressed:()=>updateNote(note),);
                },
              ),
            ),
          ],
        ),
        drawer: MyDrawer(),
      ),
    );
  }
}
