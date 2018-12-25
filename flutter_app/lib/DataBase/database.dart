import 'dart:async';
import 'dart:io' as io;
import './notesModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class NotesDataBase {
  static Database _db;

  Future<Database> get db async {
    //return database if already created
    if (_db != null) return _db;
    //else create the database
    _db = await initDataBase();
    return _db;
  }

  initDataBase() async {
    //to get the application document directory
    io.Directory applicationDocumentsDirectory =
        await getApplicationDocumentsDirectory();
    //joins the path as applicationDocumentsDirectory.path/notes.db
    String path = join(applicationDocumentsDirectory.path, "notes.db");
    //create the database and return it to get db
    var database = await openDatabase(path, version: 1, onCreate: _onCreate);
    return database;
  }

  //Things to be done when the database is open
  void _onCreate(Database db, int version) async {
    //create the table name Notes
    await db.execute("Create Table Notes(title TEXT,note TEXT)");
    print("Notes Table Created");
  }

  //Retrieve Notes from Table
  Future<List<Notes>> getNotes() async {
    var databaseClient = await db;
    List<Map> list = await databaseClient.rawQuery('Select * from Notes Order by ROWID DESC');
    List<Notes> notes = new List();
    for (int i = 0; i < list.length; i++) {
      notes.add(new Notes(list[i]["title"], list[i]["note"]));
    }

    print(notes.length);
    return notes;
  }

  //saveNotes in Database
  void saveNotes(Notes notes) async {
    var databaseClient = await db;
    await databaseClient.transaction((transaction) async {
      return await transaction.rawInsert(
          'INSERT INTO Notes(title, note ) VALUES(' +
              '\'' +
              notes.title +
              '\'' +
              ',' +
              '\'' +
              notes.notes +
              '\'' +
              ')');
    });
  }

  //Delete a note
  void deleteNote(String note) async {
    var databaseClient = await db;
    await databaseClient.rawDelete('Delete FROM Notes WHERE note = ?', [note]);
  }
}
