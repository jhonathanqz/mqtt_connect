import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';

import 'package:beer_mqtt/app/modules/splash/splash_store.dart';
import 'package:beer_mqtt/shared/style/app_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  final SplashStore store = Modular.get<SplashStore>();

  @override
  void initState() {
    store.dismissSplash();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: AppColors.primaryColorButton,
              child: const Center(
                child: Image(image: AssetImage('assets/logo.png')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
