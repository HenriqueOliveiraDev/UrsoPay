import 'package:app_pandapay/view/widgets/two_itens_col.dart';
import 'package:flutter/material.dart';

class ItensGrid extends StatelessWidget {
  IconData icon;
  String title;
  Color color;
  Function onTap;

  ItensGrid(this.icon, this.title, this.color, this.onTap) : super();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        color: this.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          width: 150,
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.only(right: 10),
          child: TwoItensCol(
            Icon(
              this.icon,
              size: 50,
              color: Colors.white,
            ),
            Text(
              this.title,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      onTap: this.onTap,
    );
  }
}
