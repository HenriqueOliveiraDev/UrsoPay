import 'package:app_pandapay/controller/user_controller.dart';
import 'package:app_pandapay/view/screen/login_password.dart';
import 'package:app_pandapay/view/screen/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mask_shifter/mask_shifter.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final String _required = 'Campo obrigatório';
  bool loading = true;
  String cpf;
  UserController userController = new UserController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Image(
          width: 200,
          image: AssetImage('assets/panda_horizontal_black.png'),
        ),
      ),
      body: (loading)
          ? Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FormBuilder(
                    key: _fbKey,
                    autovalidate: false,
                    child: FormBuilderTextField(
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
                        FormBuilderValidators.required(errorText: _required),
                        //ignore: missing_return
                        (text) {
                          if (Validator.cpf(text)) {
                            return "CPF Inválido";
                          }
                        }
                      ],
                    ),
                  ),
                  Container(
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
                      onPressed: () async {
                        if (_fbKey.currentState.saveAndValidate()) {
                          setState(() {
                            loading = false;
                          });
                          cpf = _fbKey.currentState.value['cpf'];
                          cpf = cpf.replaceAll('.', '');
                          cpf = cpf.replaceAll('-', '');
                          if (await userController.isUser(cpf)) {
                            setState(() {
                              loading = true;
                            });

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => LoginPassword(cpf: cpf,),
                              ),
                            );
                          } else {
                            setState(() {
                              loading = true;
                            });

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    SignUp(initialValue: {'cpf': cpf}),
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
