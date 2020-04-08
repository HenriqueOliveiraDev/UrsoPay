import 'package:app_pandapay/model/payment.dart';
import 'package:app_pandapay/view/widgets/item_history.dart';
import 'package:app_pandapay/view/widgets/two_itens_col.dart';
import 'package:flutter/material.dart';

class History extends StatelessWidget {
  List<dynamic> data;

  History({
    this.data,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, index) {
        print(this.data[index]);
        Payment payment = Payment.fromJson(this.data[index]);

        return ItemHistory(
          type: payment.type,
          value: '${payment.value}',
        );
      },
      itemCount: this.data.length,
    );
  }
}
