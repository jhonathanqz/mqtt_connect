import 'package:flutter_modular/flutter_modular.dart';

import 'package:beer_mqtt/app/modules/connection/connection_module.dart';
import 'package:beer_mqtt/app/modules/home/mobx/home_store.dart';
import 'package:beer_mqtt/app/modules/home/pages/home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<HomeStore>(
      (i) => HomeStore(),
      export: true,
      onDispose: (e) => e.dispose(),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (context, args) => const HomePage()),
    //ChildRoute('/connection', child: (context, args) => const ConnectionPage()),
    ModuleRoute('/connection', module: ConnectionModule()),
  ];
}
