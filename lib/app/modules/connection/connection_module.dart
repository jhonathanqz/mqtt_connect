import 'package:flutter_modular/flutter_modular.dart';

import 'package:beer_mqtt/app/modules/connection/mobx/connect_store.dart';

class ConnectionModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<ConnectStore>(
      (i) => ConnectStore(),
      export: true,
      onDispose: (e) => e.dispose(),
    ),
  ];

  @override
  final List<ModularRoute> routes = [];
}
