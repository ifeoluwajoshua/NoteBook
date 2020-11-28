import 'package:flutter/material.dart';
import 'package:noteapp/src/Helpers/colorfont.dart';
import 'package:noteapp/src/Helpers/mode.dart';
import 'package:noteapp/src/Widgets/borderfield.dart';
import 'package:noteapp/src/viewmodel/note_database.dart';

import 'home.dart';

class AddorEditNote extends StatefulWidget {
  final NoteMode noteMode;
  final Map<String, dynamic> note;

  AddorEditNote(this.noteMode, this.note);

  @override
  _AddorEditNoteHometate createState() => _AddorEditNoteHometate();
}

class _AddorEditNoteHometate extends State<AddorEditNote> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // List<Map<String, String>> get _NoteHome => NoteInheritedWidget.of(context).NoteHome;

  @override
  void didChangeDependencies() {
    if (widget.noteMode == NoteMode.Editing) {
      _titleController.text = widget.note['title'];
      _textController.text = widget.note['text'];
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            actionButton('Cancel', () {
              Navigator.pop(context);
            }, ccolor),
            //  Spacer(),
            actionButton('Save', _validateandSubmit, gcolor),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        SizedBox(
          height: height * 0.03,
        ),
        noteForm()
      ])),
    );
  }

  Widget noteForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          BorderField(
            child: customField(
                'Title', _titleController, 'Enter title here', null),
          ),
          SizedBox(height: 20),
          BorderField(
            child: customField('Body', _textController, 'Enter Notes Here', 20),
          ),
        ],
      ),
    );
  }

  Widget customField(
      String head, TextEditingController controller, String hint, int maxline) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            head,
            style: style.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          TextFormField(
            controller: controller,
            validator: (value) =>
                value.isEmpty ? 'Field can not be empty' : null,
            // onSaved: (value) => controller = value.trim(),
            keyboardType: TextInputType.multiline,
            autofocus: false,
            decoration: InputDecoration(
                labelText: hint,
                contentPadding: EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                )),
            style: style,

            maxLines: maxline,
          ),
        ],
      ),
    );
  }

  _validateandSubmit() async {
    final title = _titleController.text;
    final text = _textController.text;
    if (_validateAndSave()) {
      if (widget?.noteMode == NoteMode.Adding) {
       await  NoteProvider.insertData({'title': title, 'text': text});
       goTo();
      } else if (widget?.noteMode == NoteMode.Editing) {
       await NoteProvider.updateNote({
          'id': widget.note['id'],
          'title': _titleController.text,
          'text': _textController.text
        });
         goTo();
      }
    }
  }

  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void goTo() {
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (BuildContext context, _, __) => NoteHome(),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return new FadeTransition(opacity: animation, child: child);
            }));
  }

  MaterialButton actionButton(String text, Function tap, Color color) {
    return MaterialButton(
      onPressed: tap,
      child: Text(
        text,
        style: style.copyWith(color: Colors.white, fontSize: 20),
      ),
      color: color,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    );
  }
}
