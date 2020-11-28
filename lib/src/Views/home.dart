import 'package:flutter/material.dart';

import 'package:noteapp/src/Helpers/colorfont.dart';
import 'package:noteapp/src/Helpers/mode.dart';
import 'package:noteapp/src/Views/addoredit.dart';
import 'package:noteapp/src/viewmodel/note_database.dart';

class NoteHome extends StatefulWidget {
  @override
  _NoteHomeState createState() => _NoteHomeState();
}

class _NoteHomeState extends State<NoteHome> {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text(
          "My Notes",
          style: style,
        ),
        backgroundColor: ncolor,
      ),
      body: FutureBuilder(
          future: NoteProvider.getNoteList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final notes = snapshot.data;
              return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (BuildContext context, _, __) =>
                                    AddorEditNote(NoteMode.Editing, notes[index]),
                                transitionsBuilder: (_,
                                    Animation<double> animation,
                                    __,
                                    Widget child) {
                                  return new FadeTransition(
                                      opacity: animation, child: child);
                                }));
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 10.0, left: 13.0, right: 13.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundColor: Colors.blue,
                                        radius: 3.0,
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      _NoteTitle(notes[index]['title']),
                                    ],
                                  ),
                                  _TimeTitle("09-10-2019")
                                ],
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              // ignore: missing_return
                              _NoteText(notes[index]['text'])
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: ncolor,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                PageRouteBuilder(
                    pageBuilder: (BuildContext context, _, __) =>
                        AddorEditNote(NoteMode.Adding, null),
                    transitionsBuilder:
                        (_, Animation<double> animation, __, Widget child) {
                      return new FadeTransition(
                          opacity: animation, child: child);
                    }));
          }),
    );
  }
}

class _NoteText extends StatelessWidget {
  final String _text;

  _NoteText(this._text);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: style,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _NoteTitle extends StatelessWidget {
  final String _title;

  _NoteTitle(this._title);

  @override
  Widget build(BuildContext context) {
    return Text(
      _title,
      style: style,
    );
  }
}

class _TimeTitle extends StatelessWidget {
  final String _time;

  _TimeTitle(this._time);

  @override
  Widget build(BuildContext context) {
    return Text(
      _time,
      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
    );
  }
}
