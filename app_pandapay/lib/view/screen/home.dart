import 'package:app_pandapay/controller/payment_controller.dart';
import 'package:app_pandapay/controller/user_controller.dart';
import 'package:app_pandapay/model/payment.dart';
import 'package:app_pandapay/view/screen/add.dart';
import 'package:app_pandapay/view/widgets/alert_dialog.dart';
import 'package:app_pandapay/view/widgets/history.dart';
import 'package:app_pandapay/view/widgets/item_history.dart';
import 'package:app_pandapay/view/widgets/itens_grid.dart';
import 'package:app_pandapay/view/widgets/two_itens_col.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String name = 'Henrique';
  Payment payment;
  List<BottomNavigationBarItem> itens = List<BottomNavigationBarItem>();
  PaymentController paymentController = PaymentController();
  UserController userController = UserController();

  List loadItens() {
    itens.add(new BottomNavigationBarItem(
        icon: new Icon(Icons.account_balance_wallet),
        title: new Text('Carteira')));
    itens.add(new BottomNavigationBarItem(
        icon: new Icon(Icons.attach_money), title: new Text('Pagar')));
    itens.add(new BottomNavigationBarItem(
        icon: new Icon(Icons.import_export), title: new Text('Tranferir')));
    itens.add(new BottomNavigationBarItem(
        icon: new Icon(Icons.folder_open), title: new Text('Blockchain')));

    return itens;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: <Widget>[
            Image(
              width: 40,
              height: 40,
              image: AssetImage('assets/icone.png'),
            ),
            Padding(
              padding: EdgeInsets.all(5),
            ),
            FutureBuilder(
                future: userController.getUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Text(
                      'Olá ${snapshot.data.name}!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(16, 20, 16, 16),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TwoItensCol(
                  Text('Retirar'),
                  InkWell(
                    child: Image(
                      width: 60,
                      height: 60,
                      image: AssetImage('assets/minus.png'),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (contex) => Add(
                            title: 'Quanto deseja retirar?',
                            type: 'take_out',
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                ),
                FutureBuilder(
                  future: userController.getBalance(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return (snapshot.data != null)?
                      TwoItensCol(
                        Text('Saldo total:'),
                        RichText(
                          text: TextSpan(
                            text: 'R\$\ ${snapshot.data},',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '00',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ):  TwoItensCol(
                        Text('Saldo total:'),
                        RichText(
                          text: TextSpan(
                            text: 'R\$\ 0,',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '00',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return TwoItensCol(
                        Text('Saldo total:'),
                        RichText(
                          text: TextSpan(
                            text: 'R\$\ 0',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '00',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                ),
                TwoItensCol(
                  Text('Adicionar'),
                  InkWell(
                    child: Image(
                      width: 60,
                      height: 60,
                      image: AssetImage('assets/add.png'),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (contex) => Add(
                            title: 'Quanto quer adicionar?',
                            type: 'add',
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(15),
            ),
            Column(
              children: <Widget>[
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ItensGrid(
                        Icons.credit_card,
                        'Peça seu cartão',
                        Color(0xFF707070),
                        () {},
                      ),
                      ItensGrid(Icons.phone_android, 'Recarga de celular',
                          Color(0xFF1192F1), () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (contex) => Add(
                              title: 'Quanto deseja recarregar?',
                              type: 'phone',
                            ),
                          ),
                        );
                      }),
                      ItensGrid(
                        Icons.local_activity,
                        'Voucher',
                        Color(0xFFB7D80F),
                        () {},
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ItensGrid(
                          Icons.people, 'Indique amigos', Color(0xFFDA0F0F),
                          () {
                        Share.share(
                            'Divulgue o Panda na sua escola ou universidade e ganhe parte da receita de conversão. Você ganha, seus colegas ganham, os lojistas ganham e o Panda ganha. E aí, partiu? \n https://play.google.com/store/apps/details?id=br.com.pandapay');
                      }),
                      ItensGrid(Icons.directions_bus, 'Carregar trasporte',
                          Color(0xFFDA870F), () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (contex) => Add(
                              title: 'Quanto deseja recarregar?',
                              type: 'transport',
                            ),
                          ),
                        );
                      }),
                      ItensGrid(Icons.chat, 'Fale conosco', Color(0xFFA00FDA),
                          () {
                        launch("whatsapp://send?phone=+5521995150525");
                      }),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(15),
            ),
            Text(
              'Histórico',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
            ),
            FutureBuilder(
              future: paymentController.allPayment(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return (snapshot.data != null)
                      ? Expanded(
                          child: Container(
                            child: History(
                              data: snapshot.data,
                            ),
                          ),
                        )
                      : Text(
                          'Sem transações',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        );
                } else {
                  return Text('Carregando');
                }
              },
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 50),
            ),
          ],
        ),
      ),
      bottomSheet: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF707070),
        items: loadItens(),
      ),
    );
  }
}
