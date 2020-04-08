import 'package:flutter/material.dart';
import 'package:flare_flutter/asset_provider.dart';
import 'package:flare_flutter/cache.dart';
import 'package:flare_flutter/cache_asset.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_cache.dart';
import 'package:flare_flutter/flare_cache_asset.dart';
import 'package:flare_flutter/flare_cache_builder.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flare_flutter/flare_render_box.dart';
import 'package:flare_flutter/flare_testing.dart';
import 'package:flare_flutter/provider/asset_flare.dart';

import 'package:flutter/services.dart';

class Check extends StatefulWidget {
  String title;
  String animation;
  MaterialPageRoute route;

  Check({Key key, this.title, this.animation, this.route}) : super(key: key);

  @override
  _CheckState createState() => _CheckState();
}

class _CheckState extends State<Check> {
  @override
  void initState() {
    new Future.delayed(const Duration(milliseconds: 1500), () {
      print('Fechou');
      Navigator.of(context).pushAndRemoveUntil(widget.route, (_) => false);
    }); //recommend
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF7AE3D0),
      child: FlareActor(
        widget.animation,
        animation: 'check_icon',
      ),
    );
  }
}
