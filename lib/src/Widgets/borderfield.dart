
import 'package:flutter/material.dart';

class BorderField extends StatelessWidget {
  const BorderField({
    Key key,
    @required Widget child
  }) : _child = child, super(key: key);

  final Widget _child;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Container(
       padding: const EdgeInsets.only(top: 30, bottom: 30),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border:   Border.all(color: Colors.blue, width: 3)
        ),
        child: _child
      ),
    );
  }
}
