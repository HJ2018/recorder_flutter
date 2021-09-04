import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final String hint;
  final double height;
  final Function(String) onChanged;

  TextInput({
    this.hint,
    this.onChanged,
    this.height,
  });

  @override
  State createState() {
    return MyTextInputState(this.hint ,this.onChanged,this.height);
  }
}


class MyTextInputState extends State
    with SingleTickerProviderStateMixin {


  final String hint;
  final double height;
  final Function(String) onChanged;
  MyTextInputState(this.hint ,this.onChanged,this.height);
  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      child: _textInput(this.hint),
    );
  }

  String result = "";

  _textInput(String hint) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Container(
          height: this.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(4.0),
            ),
              // border: Border.all(color: Color.fromARGB(100, 192, 192, 192)),
          ),
          alignment: AlignmentDirectional.topStart,
          margin: EdgeInsets.only(bottom: 15,left: 10,right: 10),
          child: CupertinoTextField(
            placeholder: hint,
            style: TextStyle(fontSize: 15, color: Colors.grey.shade900),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
            maxLines: 20,
//            maxLength: 150,
            maxLengthEnforced: true,
            textInputAction: TextInputAction.unspecified,
            onChanged: (str) {
              result = str;
              this.onChanged(result);
              setState(() {
              });
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 15, right: 10),
//          child: Text(
//            result.length.toString() + "/150",
//            style: TextStyle(color: Colors.grey),
//          ),
        )
      ],
    );
  }
}