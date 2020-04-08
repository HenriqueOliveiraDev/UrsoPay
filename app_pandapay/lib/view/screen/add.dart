import 'package:app_pandapay/controller/payment_controller.dart';
import 'package:app_pandapay/controller/user_controller.dart';
import 'package:app_pandapay/model/payment.dart';
import 'package:app_pandapay/view/screen/check.dart';
import 'package:app_pandapay/view/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class Add extends StatefulWidget {

  String type;
  String title;

  Add({
    this.title,
    this.type,
  }):super();

  @override
  _AddState createState() => _AddState();
}

PaymentController paymentController = PaymentController();
Payment payment;
UserController userController = UserController();
final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
bool loading = true;

class _AddState extends State<Add> {
  @override
  Widget build(BuildContext context) {
    return (loading)
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              title: Text(
                widget.title,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            body: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 100,
                child: FormBuilder(
                  key: _fbKey,
                  child: FormBuilderTextField(
                    style: TextStyle(
                      fontSize: 30,
                    ),
                    attribute: 'add',
                    textAlign: TextAlign.center,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.number,
                    validators: [
                      FormBuilderValidators.required(errorText: 'R\$\ '),
                    ],
                  ),
                ),
              ),
            ),
            bottomSheet: Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                color: Colors.black,
                child: Text(
                  'Continuar',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
                onPressed: () async {
                  if (_fbKey.currentState.saveAndValidate()) {

                    setState(() {
                      loading = false;
                    });
                    payment = new Payment();
                    payment.type = widget.type;
                    payment.value = _fbKey.currentState.value['add'];

                    if (await paymentController.create(payment)) {
                        loading = true;
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => Check(
                                    animation: 'assets/check_white.flr',
                                    route: MaterialPageRoute(
                                      builder: (context) => Home(),
                                    ), 
                                  ),
                        ),(_)=>false
                      );
                    } else {
                      print('error on create');
                    }
                  }
                },
              ),
            ),
          )
        : Container(
          color: Colors.white,
          child:Center(
            child: CircularProgressIndicator(),
          ),);
  }
}
