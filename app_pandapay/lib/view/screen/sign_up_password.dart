import 'package:app_pandapay/controller/user_controller.dart';
import 'package:app_pandapay/model/user.dart';
import 'package:app_pandapay/view/screen/check.dart';
import 'package:app_pandapay/view/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SignUpPassword extends StatefulWidget {
  User user;

  SignUpPassword({
    this.user,
  }) : super();

  @override
  _SignUpPasswordState createState() => _SignUpPasswordState();
}

class _SignUpPasswordState extends State<SignUpPassword> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final GlobalKey<ScaffoldState> _scKey = GlobalKey<ScaffoldState>();

  final String _required = 'Campo obrigatório';
  bool loading = true;
  bool obscureText = true;
  String password = '';
  UserController userController = UserController();

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
                    child: Column(
                      children: <Widget>[
                        FormBuilderTextField(
                          attribute: "password",
                          obscureText: obscureText,
                          onChanged: (event) {
                            _fbKey.currentState.save();
                            print(_fbKey.currentState.value['password']);
                            setState(() {
                              password = _fbKey.currentState.value['password'];
                            });
                          },
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
                            FormBuilderValidators.required(
                                errorText: _required),
                            FormBuilderValidators.minLength(6,
                                errorText: 'Senha curta'),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                        ),
                        (password.length > 5)
                            ? FormBuilderTextField(
                                attribute: "confirm_password",
                                obscureText: obscureText,
                                decoration: InputDecoration(
                                  labelText: "Confirmar senha",
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
                                  FormBuilderValidators.required(
                                      errorText: _required),
                                  FormBuilderValidators.minLength(6,
                                      errorText: 'Senha curta'),
                                ],
                              )
                            : Container(),
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
                        'Cadastrar',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      onPressed: () async {
                        if (_fbKey.currentState.saveAndValidate()) {
                          password =
                              _fbKey.currentState.value['password'];
                          String confirmPassword =
                              _fbKey.currentState.value['confirm_password'];

                          if (password == confirmPassword) {
                            widget.user.password = password;

                            setState(() {
                              loading = false;
                            });

                            if (await userController.create(widget.user)) {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => Check(
                                    animation: 'assets/check_white.flr',
                                    route: MaterialPageRoute(
                                      builder: (context) => Home(),
                                    ), 
                                  ),
                                ), (_) => false
                              );
                            } else {
                              print('error on create');
                            }
                          } else {
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
