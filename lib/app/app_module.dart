import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';

import 'package:beer_mqtt/app/app_widget.dart';
import 'package:beer_mqtt/app/modules/connection/connection_module.dart';
import 'package:beer_mqtt/app/modules/home/home_module.dart';
import 'package:beer_mqtt/app/modules/splash/splash_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
        SplashModule(),
        HomeModule(),
        ConnectionModule(),
      ];

  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(Modular.initialRoute, module: SplashModule()),
        ModuleRoute('/home', module: HomeModule()),
        // ModuleRoute(Modular.initialRoute, module: SplashModule()),
        // ModuleRoute('/home', module: HomeModule()),
        // ModuleRoute('/settings', module: SettingsModule()),
      ];

  @override
  // ignore: override_on_non_overriding_member
  Widget get bootstrap => const AppWidget();
}
