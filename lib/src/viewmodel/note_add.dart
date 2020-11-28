import 'note_database.dart';

class AddNote {
  AddNote(this.title, this.body, this.id);
  final String title;
  final String body;
  var id;
   
  void saveNote() {
    NoteProvider.insertData({'title': title, 'text': body});
  }

  void updateNote() {
    NoteProvider.updateNote({'id': id, 'title': title, 'text': body});
  }
}
