import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'connect_store.g.dart';

class ConnectStore = _ConnectStoreBase with _$ConnectStore;

abstract class _ConnectStoreBase with Store implements Disposable {
  @observable
  bool isLoading = false;

  @action
  void wipeStore() {
    isLoading = false;
  }

  @override
  void dispose() => wipeStore();
}
