import 'package:flutter/material.dart';

class AlertSimple extends StatefulWidget {
  String title;
  String description;
  String textAction;


  AlertSimple({Key key, this.title, this.description, this.textAction}) : super(key: key);

  @override
  _AlertSimpleState createState() => _AlertSimpleState();
}

class _AlertSimpleState extends State<AlertSimple> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:Text(
        widget.title,
        style: TextStyle(),
      ),
      content: Text(
        widget.description,
        style: TextStyle(),
        ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            widget.textAction,
            
            ),
          onPressed: (){
            Navigator.of(context).pop();
          },
        )
      ],

    );
        
  }
}