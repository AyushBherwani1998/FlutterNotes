import 'package:flutter/material.dart';
import './DataBase/notesModel.dart';
import './DataBase/database.dart';

class EditNote extends StatefulWidget {
  final String title;
  final String note;

  EditNote(this.title, this.note);

  @override
  State<StatefulWidget> createState() {
    return MyEditNote(title, note);
  }
}

class MyEditNote extends State<EditNote> {
  final String titleText;
  final String noteText;
  TextEditingController title;
  TextEditingController note;

  MyEditNote(this.titleText, this.noteText);

  @override
  void initState() {
    super.initState();
    title = TextEditingController(text: titleText);
    note = TextEditingController(text: noteText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.orange[800]),
          title: Text(
            "Edit Note",
            style: TextStyle(fontFamily: 'Oswald',color: Colors.black87),
          ),
          brightness: Brightness.light,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.save_alt,
                color: Colors.orange[800],
              ),
              onPressed: () {
                var s = saveNotes();
                print("Save Pressed");
                Navigator.pop(context);
              },
            )
          ],
          backgroundColor: Colors.white,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              SizedBox(
                height: 24.0,
              ),
              TextField(
                textCapitalization: TextCapitalization.sentences,
                controller: title,
                decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black87, width: 0.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black87, width: 0.0),
                    ),
                    border: OutlineInputBorder(),
                    labelText: "Title",
                    labelStyle: TextStyle(
                        color: Colors.orange[800], fontFamily: 'Oswald'),
                    helperText: "Give a Title",
                    helperStyle: TextStyle(
                        color: Colors.orange[800], fontFamily: 'Oswald')),
              ),
              SizedBox(height: 24.0),
              TextField(
                textCapitalization: TextCapitalization.sentences,
                controller: note,
                keyboardType: TextInputType.multiline,
                maxLines: 17,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black87, width: 0.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black87, width: 0.0),
                  ),
                  border: OutlineInputBorder(),
                  labelText: "Note",
                  labelStyle: TextStyle(
                      color: Colors.orange[800],
                      fontSize: 20.0,
                      fontFamily: 'Oswald'),
                  helperText: "Write your note",
                  helperStyle: TextStyle(
                      color: Colors.orange[800], fontFamily: 'Oswald'),
                ),
              ),
            ],
          ),
        ));
  }

  void saveNotes() async {
    if (title.text != titleText || note.text != noteText) {
      if (title.text.isNotEmpty || note.text.isNotEmpty) {
        var notes = Notes(title.text, note.text);
        var noteDataBase = NotesDataBase();
        noteDataBase.saveNotes(notes);
        noteDataBase.deleteNote(noteText);
        print("note delted");
        print("Note Saved");
      }
    }
  }
}
