import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: Scaffold(
        body: Body(),
      ),
    );
  }
}
