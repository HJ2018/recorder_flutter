import 'package:flutter/material.dart';
import 'colors.dart';

class JhButton extends StatelessWidget {

  const JhButton({
    Key key,
    this.text: '',
    @required this.onPressed,
  }): super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
//      textColor: Colors.white,
//      color: Theme.of(context).primaryColor ,
      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      textColor: Colors.white,
      color: KColor.NavMainColor,
      disabledTextColor: Colors.white54,
      disabledColor: Color(0xa03BB815),

      child: Container(
        height: 50,
        width: double.infinity,
        alignment: Alignment.center,
        child: Text(text, style: TextStyle(fontSize: 18),),
      ),
    );
  }
}
