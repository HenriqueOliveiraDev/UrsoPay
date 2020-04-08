import 'dart:math';

import 'package:app_pandapay/controller/user_controller.dart';
import 'package:app_pandapay/model/user.dart';
import 'package:app_pandapay/view/screen/home.dart';
import 'package:app_pandapay/view/screen/login.dart';
import 'package:flutter/material.dart';

class Introduction extends StatelessWidget {
  var random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            child: Opacity(
              opacity: 0.7,
              child: Image(
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                image: AssetImage('assets/fundo${random.nextInt(4)}.jpg'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 30, 16, 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image(
                  image: AssetImage('assets/panda_horizontal_white.png'),
                ),
                Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Evite dinheiro\nPague contas\nReceba pagamentos\nCom taxa zero.',
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
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
                          'Continuar',
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        onPressed: () async {
                          // User user = new User();
                          // user.cpf = '07881069376';
                          // user.password = '12345678';

                          UserController userController = new UserController();

                           (await userController.isAuth() != null)?
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => Home(),
                            ),(_) => false,
                          ) : 
                           Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => Login(),
                              
                            ),(_) => false,
                          );
                        },
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
