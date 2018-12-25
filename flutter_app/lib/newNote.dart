import 'package:flutter/material.dart';
import './DataBase/database.dart';
import './DataBase/notesModel.dart';
import 'package:share/share.dart';

class NewNotes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyNewNotes();
  }
}

class MyNewNotes extends State<NewNotes> {
  String notes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.orange[800]),
        title: Text(
          "New Note",
          style: TextStyle(
              color: Colors.black, fontFamily: 'Oswald', fontSize: 18.0),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save_alt, color: Colors.orange[800]),
            onPressed: () {
              var input =  MyHomePage.saveNotes();
              print(MyHomePage._title.text);
              print(MyHomePage._notes.text);
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.orange[800],
            ),
            onPressed: () {
              MyHomePage.sharePressed();
              print("share pressed");
            },
          )
        ],
      ),
      body: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyHomePage();
  }
}

class MyHomePage extends State<HomePage> {
  static TextEditingController _title = new TextEditingController();
  static TextEditingController _notes = new TextEditingController();

  @override
  void dispose() {
    _title.clear();
    _notes.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
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
            controller: _title,
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
                labelStyle:
                    TextStyle(color: Colors.orange[800], fontFamily: 'Oswald'),
                helperText: "Give a Title",
                helperStyle:
                    TextStyle(color: Colors.orange[800], fontFamily: 'Oswald')),
          ),
          SizedBox(height: 24.0),
          TextField(
            textCapitalization: TextCapitalization.sentences,
            controller: _notes,
            keyboardType: TextInputType.multiline,
            maxLines: 17,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black87, width: 0.0),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black87, width: 0.0),
              ),
              border: OutlineInputBorder(),
              labelText: "Note",
              labelStyle: TextStyle(
                  color: Colors.orange[800],
                  fontSize: 20.0,
                  fontFamily: 'Oswald'),
              helperText: "Write your note",
              helperStyle:
                  TextStyle(color: Colors.orange[800], fontFamily: 'Oswald'),
            ),
          ),
        ],
      ),
    );
  }

  static void saveNotes() async {
    var note = Notes(_title.text, _notes.text);
    if(_title.text.isNotEmpty || _notes.text.isNotEmpty){
      var noteDataBase = NotesDataBase();
      noteDataBase.saveNotes(note);
      print("Note Saved");
      _title.clear();
      _notes.clear();
    }
  }

  static sharePressed(){
    if(_title.text.isNotEmpty || _notes.text.isNotEmpty){
      if(_title.text.isEmpty){
        Share.share(_notes.text);
      }else if(_notes.text.isEmpty){
        Share.share(_title.text);
      }else{
        Share.share(_title.text+"\n"+_notes.text);
      }
    }
  }
}
