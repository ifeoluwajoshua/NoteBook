import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  const CustomField(
      {Key key,
      @required this.controller,
      @required this.style,
         @required this.head,
      @required this.type,
      @required this.maxline,
      @required this.hint})
      :
        super(key: key);

  final TextEditingController controller;
  final TextStyle style;
  final TextInputType type;
  final int maxline;
  final String hint;
  final String head;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right:25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(head, style: style.copyWith(fontSize: 20, fontWeight: FontWeight.bold),),
           SizedBox(height: 15),
          TextFormField(
            controller: controller,
            validator:(value) =>
                value.isEmpty ? 'Field can not be empty' : null,
                 // onSaved: (value) => controller = value.trim(),
             keyboardType: type,
                autofocus: false,
            decoration: InputDecoration(
                  labelText: hint,
              contentPadding: EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 20.0),
               border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      )
            ),
            style: style,
           
            maxLines: maxline,
          ),
        ],
      ),
    );
  }
}
