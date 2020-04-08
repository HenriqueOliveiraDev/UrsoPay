import 'package:flutter/material.dart';

class ItemHistory extends StatelessWidget {
  String type;
  String value;
  String message;
  IconData iconData;

  ItemHistory({
    this.type,
    this.value,
  }) : super();

  @override
  Widget build(BuildContext context) {
    switch (this.type) {
      case 'add':
        {
          message = 'Você adicionou créditos';
          iconData = Icons.attach_money;
        }
        break;
      case 'take_out':
        {
          message = 'Você retirou créditos';
          iconData = Icons.payment;
        }
        break;
      case 'phone':
        {
          message = 'Você realizou uma recarga';
          iconData = Icons.phone_android;
        }
        break;
      case 'transport':
        {
          message = 'Você carregou seu cartão de transporte';
          iconData = Icons.train;
        }
        break;

      default:
    }
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Icon(
              iconData,
              color: Color(0XFF707070),
              size: 40,
            ),
            Padding(
              padding: EdgeInsets.all(5),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${message}'),
                Text(
                  'Concluida',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(3),
                ),
                Text(
                  'R\$\ ${double.parse(value)}0',
                  style: TextStyle(
                    fontSize: 20,
                    color: (type == 'add') ? Colors.green : Colors.red,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
