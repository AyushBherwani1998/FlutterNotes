import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import './newNote.dart';
import './DataBase/database.dart';
import './DataBase/notesModel.dart';
import 'dart:async';
import './viewNote.dart';

void main() => runApp(new MaterialApp(
      title: "Flutter Notes",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyHomePage();
  }
}

class MyHomePage extends State<HomePage> {
  void deleteNote(String text) {
    var notesDatabase = NotesDataBase();
    notesDatabase.deleteNote(text);
    print("note delted");
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.orange[800],
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => NewNotes()));
            print("FloatingActionButton Pressed");
          },
        ),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.orange[800]),
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.orange[800],
              ),
              onPressed: () {
                print("search pressed");
              },
            ),
            IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.orange[800],
              ),
              onPressed: () {
                print("End menu pressed");
              },
            )
          ],
          title: Text(
            "All Notes",
            style: TextStyle(color: Colors.black87, fontFamily: 'Oswald'),
          ),
        ),
        drawer: Drawer(),
        backgroundColor: Colors.grey[200],
        body: Container(
            padding: EdgeInsets.all(4.0),
            child: FutureBuilder<List<Notes>>(
                future: fetchNotes(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return new ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return new Card(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.orange[800],
                                    ),
                                    onPressed: () {
                                      deleteNote(snapshot.data[index].notes);
                                      setState(() {
                                        snapshot.data.remove(index);
                                      });
                                    },
                                  ),
                                  title: Text(
                                    snapshot.data[index].title,
                                    style: TextStyle(
                                        fontFamily: 'Oswald',
                                        fontWeight: FontWeight.w400),
                                  ),
                                  subtitle: Text(
                                    snapshot.data[index].notes,
                                    style: TextStyle(fontFamily: 'Oswald'),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ViewNote(
                                                snapshot.data[index].title,
                                                snapshot.data[index].notes)));
                                  },
                                  contentPadding:
                                      EdgeInsets.fromLTRB(16.0, 8.0, 4.0, 4.0),
                                  isThreeLine: true,
                                )
                              ],
                            ),
                          );
                        });
                  }
                })));
  }
}

Future<List<Notes>> fetchNotes() async {
  var notesDatabase = NotesDataBase();
  Future<List<Notes>> notes = notesDatabase.getNotes();
  return notes;
}
