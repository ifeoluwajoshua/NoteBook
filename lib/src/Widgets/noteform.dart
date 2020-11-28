

import 'package:flutter/material.dart';
import 'package:noteapp/src/Widgets/customtextfield.dart';

import 'borderfield.dart';

class NoteForm extends StatelessWidget {
  const NoteForm({
    Key key,
    @required GlobalKey<FormState> formKey,
      @required this.title,
    @required TextEditingController body,
    @required this.style,
  })  : formKey = formKey,
        _body = body,
       
        super(key: key);

  final GlobalKey<FormState> formKey;
    final TextEditingController title;
  final TextEditingController _body;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          BorderField(
            child: CustomField(
             controller:title,
              style: style,
              hint: 'Title',
              maxline: null,
              type: TextInputType.multiline,
              head: 'Title',
            ),
          ),
          SizedBox(height: 20),
          BorderField(
                      child: CustomField(
             controller: _body,
              style: style,
              hint: 'Body',
              maxline: 20,
              type: TextInputType.multiline,
              head: 'Body',
            ),
          ),
        ],
      ),
    );
  }
}
