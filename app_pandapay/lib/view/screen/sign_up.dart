import 'package:app_pandapay/model/user.dart';
import 'package:app_pandapay/view/screen/sign_up_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mask_shifter/mask_shifter.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';

class SignUp extends StatefulWidget {
  Map<String, dynamic> initialValue;
  SignUp({
    this.initialValue,
  }) : super();

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String obrigatorio = "Campo obrigatório";
  String date = 'Data de vencimento';

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final GlobalKey _tabKey = GlobalKey<FormBuilderState>();

  final String _required = 'Campo obrigatório';
  final bool isValid = true;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      key: _tabKey,
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Image(
            width: 200,
            image: AssetImage('assets/panda_horizontal_black.png'),
          ),
          bottom: TabBar(
            indicatorColor: Colors.black,
            labelPadding: EdgeInsets.all(10),
            tabs: [
              Text(
                'Para você',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              Text(
                'Para sua empresa',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          Container(
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FormBuilder(
                      key: _fbKey,
                      initialValue: widget.initialValue,
                      autovalidate: false,
                      child: Column(
                        children: <Widget>[
                          FormBuilderTextField(
                            attribute: "name",
                            decoration: InputDecoration(
                              labelText: "Nome",
                            ),
                            keyboardType: TextInputType.text,
                            maxLines: 1,
                            validators: [
                              FormBuilderValidators.required(
                                  errorText: _required),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                          ),
                          FormBuilderTextField(
                            inputFormatters: [
                              MaskedTextInputFormatterShifter(
                                  maskONE: "(XX)XXXXX-XXXX",
                                  maskTWO: "(XX)XXXXX-XXXX"),
                            ],
                            attribute: "phone",
                            decoration: InputDecoration(
                              labelText: "Telefone",
                            ),
                            keyboardType: TextInputType.number,
                            maxLines: 1,
                            validators: [
                              FormBuilderValidators.required(
                                  errorText: _required),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                          ),
                          FormBuilderTextField(
                            attribute: "email",
                            decoration: InputDecoration(
                              labelText: "Email",
                            ),
                            keyboardType: TextInputType.emailAddress,
                            maxLines: 1,
                            validators: [
                              FormBuilderValidators.required(
                                  errorText: _required),
                              FormBuilderValidators.email(
                                  errorText: 'Email Inválido')
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                          ),
                          FormBuilderTextField(
                            inputFormatters: [
                              MaskedTextInputFormatterShifter(
                                  maskONE: "XXX.XXX.XXX-XX",
                                  maskTWO: "XXX.XXX.XXX-XX")
                            ],
                            attribute: "cpf",
                            decoration: InputDecoration(
                              labelText: "CPF",
                            ),
                            keyboardType: TextInputType.number,
                            maxLines: 1,
                            validators: [
                              FormBuilderValidators.required(
                                  errorText: _required),
                              //ignore: missing_return
                              (text) {
                                if (Validator.cpf(text)) {
                                  return "CPF Inválido";
                                }
                              }
                            ],
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FormBuilder(
                      key: _fbKey,
                      initialValue: widget.initialValue,
                      autovalidate: false,
                      child: Column(
                        children: <Widget>[
                          FormBuilderTextField(
                            attribute: "name",
                            decoration: InputDecoration(
                              labelText: "Nome da empresa",
                            ),
                            keyboardType: TextInputType.text,
                            maxLines: 1,
                            validators: [
                              FormBuilderValidators.required(
                                  errorText: _required),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                          ),
                          FormBuilderTextField(
                            inputFormatters: [
                              MaskedTextInputFormatterShifter(
                                  maskONE: "(XX)XXXXX-XXXX",
                                  maskTWO: "(XX)XXXXX-XXXX"),
                            ],
                            attribute: "phone",
                            decoration: InputDecoration(
                              labelText: "Telefone",
                            ),
                            keyboardType: TextInputType.number,
                            maxLines: 1,
                            validators: [
                              FormBuilderValidators.required(
                                  errorText: _required),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                          ),
                          FormBuilderTextField(
                            attribute: "email",
                            decoration: InputDecoration(
                              labelText: "Email comercial",
                            ),
                            keyboardType: TextInputType.emailAddress,
                            maxLines: 1,
                            validators: [
                              FormBuilderValidators.required(
                                  errorText: _required),
                              FormBuilderValidators.email(
                                  errorText: 'Email Inválido')
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                          ),
                          FormBuilderTextField(
                            inputFormatters: [
                              MaskedTextInputFormatterShifter(
                                  maskONE: "XXX.XXX.XXX-XX",
                                  maskTWO: "XXX.XXX.XXX-XX")
                            ],
                            attribute: "cpf",
                            decoration: InputDecoration(
                              labelText: "Cnpj",
                            ),
                            keyboardType: TextInputType.number,
                            maxLines: 1,
                            validators: [
                              FormBuilderValidators.required(
                                  errorText: _required),
                              //ignore: missing_return
                              (text) {
                                if (Validator.cpf(text)) {
                                  return "CPF Inválido";
                                }
                              }
                            ],
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ]),
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
              'Avançar',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            onPressed: () {
              if (_fbKey.currentState.saveAndValidate()) {
                User user = User.fromJson(_fbKey.currentState.value);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SignUpPassword(user: user),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
