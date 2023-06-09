import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'splash_store.g.dart';

class SplashStore = _SplashStoreBase with _$SplashStore;

abstract class _SplashStoreBase with Store {
  @observable
  bool isLoading = false;

  @action
  Future<void> dismissSplash() async {
    await Future.delayed(const Duration(seconds: 3));

    Modular.to.navigate('/home/');
  }
}
