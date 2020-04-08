import 'package:flutter/material.dart';

class TwoItensCol extends StatelessWidget {
  Widget itemOne;
  Widget itemTwo;

  TwoItensCol(
    @required this.itemOne,
    @required this.itemTwo,
  ) : super();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        this.itemOne,
        this.itemTwo,
      ],
    );
  }
}
