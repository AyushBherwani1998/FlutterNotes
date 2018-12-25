import 'package:flutter/material.dart';
import 'package:share/share.dart';
import './edit.dart';

class ViewNote extends StatelessWidget {
  final String title;
  final String note;

  ViewNote(this.title, this.note);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.orange[800]),
        brightness: Brightness.light,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.orange[800],
            ),
            onPressed: () {
              print("Edit pressed");
              Navigator.push(context, MaterialPageRoute(builder: (context)=>EditNote(title, note)));
            },
          ),
          IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.orange[800],
            ),
            onPressed: () {
              print("share pressed");
              Share.share(title+"\n"+note);

            },
          )
        ],
        title: Text(
          "Flutter Notes",
          style: TextStyle(color: Colors.black87, fontFamily: 'Oswald'),
        ),
      ),
      body: HomePage(title, note),
    );
  }
}

class HomePage extends StatelessWidget {
  final String title;
  final String note;

  HomePage(this.title, this.note);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          SizedBox(height: 8.0),
          Text(
            title,
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Oswald',
                fontSize: 18.0,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 16.0),
          Text(
            note,
            style: TextStyle(
                color: Colors.grey.shade700, fontFamily: 'Oswald', fontSize: 15.0),
          )
        ],
      ),
    );
  }
}
