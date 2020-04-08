import 'package:app_pandapay/controller/user_controller.dart';
import 'package:app_pandapay/model/user.dart';
import 'package:app_pandapay/view/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mask_shifter/mask_shifter.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';

class LoginPassword extends StatefulWidget {
  String cpf;

  LoginPassword({this.cpf});

  @override
  _LoginPasswordState createState() => _LoginPasswordState();
}

class _LoginPasswordState extends State<LoginPassword> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final GlobalKey<ScaffoldState> _scKey = GlobalKey<ScaffoldState>();
  final String _required = 'Campo obrigatório';
  bool loading = true;
  bool obscureText = true;
  UserController userController = UserController();
  User user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scKey,
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
                      attribute: "password",
                      obscureText: obscureText,
                      decoration: InputDecoration(
                        labelText: "Senha",
                        suffixIcon: IconButton(
                          icon: (obscureText)
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      validators: [
                        FormBuilderValidators.required(errorText: _required),
                        FormBuilderValidators.minLength(6,
                            errorText: 'Senha curta'),
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
                        'Entrar',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      onPressed: () async {
                        if (_fbKey.currentState.saveAndValidate()) {
                          user.cpf = widget.cpf;
                          user.password = _fbKey.currentState.value['password'];

                          setState(() {
                            loading = false;
                          });

                          if (await userController.login(user)) {
                            loading = true;
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => Home(),
                                ),
                                (_) => false);
                          } else {
                            setState(() {
                              loading = true;
                            });

                            final snackBar = SnackBar(
                              content: Text('Senhas diferentes'),
                              backgroundColor: Colors.red,
                              duration: Duration(milliseconds: 1000),
                            );
                            _scKey.currentState.showSnackBar(snackBar);
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
