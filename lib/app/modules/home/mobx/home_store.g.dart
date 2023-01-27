// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStoreBase, Store {
  Computed<bool>? _$settingsValidComputed;

  @override
  bool get settingsValid =>
      (_$settingsValidComputed ??= Computed<bool>(() => super.settingsValid,
              name: '_HomeStoreBase.settingsValid'))
          .value;

  late final _$isLoadingAtom =
      Atom(name: '_HomeStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$isConnectionAtom =
      Atom(name: '_HomeStoreBase.isConnection', context: context);

  @override
  bool get isConnection {
    _$isConnectionAtom.reportRead();
    return super.isConnection;
  }

  @override
  set isConnection(bool value) {
    _$isConnectionAtom.reportWrite(value, super.isConnection, () {
      super.isConnection = value;
    });
  }

  late final _$connectionAtom =
      Atom(name: '_HomeStoreBase.connection', context: context);

  @override
  Connection get connection {
    _$connectionAtom.reportRead();
    return super.connection;
  }

  @override
  set connection(Connection value) {
    _$connectionAtom.reportWrite(value, super.connection, () {
      super.connection = value;
    });
  }

  late final _$loopAtom = Atom(name: '_HomeStoreBase.loop', context: context);

  @override
  int get loop {
    _$loopAtom.reportRead();
    return super.loop;
  }

  @override
  set loop(int value) {
    _$loopAtom.reportWrite(value, super.loop, () {
      super.loop = value;
    });
  }

  late final _$isSendActiveAtom =
      Atom(name: '_HomeStoreBase.isSendActive', context: context);

  @override
  bool get isSendActive {
    _$isSendActiveAtom.reportRead();
    return super.isSendActive;
  }

  @override
  set isSendActive(bool value) {
    _$isSendActiveAtom.reportWrite(value, super.isSendActive, () {
      super.isSendActive = value;
    });
  }

  late final _$resultAtom =
      Atom(name: '_HomeStoreBase.result', context: context);

  @override
  String get result {
    _$resultAtom.reportRead();
    return super.result;
  }

  @override
  set result(String value) {
    _$resultAtom.reportWrite(value, super.result, () {
      super.result = value;
    });
  }

  late final _$connectAsyncAction =
      AsyncAction('_HomeStoreBase.connect', context: context);

  @override
  Future<void> connect() {
    return _$connectAsyncAction.run(() => super.connect());
  }

  late final _$_HomeStoreBaseActionController =
      ActionController(name: '_HomeStoreBase', context: context);

  @override
  void setBroker(String value) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.setBroker');
    try {
      return super.setBroker(value);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPort(String value) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.setPort');
    try {
      return super.setPort(value);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTopic(String value) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.setTopic');
    try {
      return super.setTopic(value);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setClientIdentifier(String value) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.setClientIdentifier');
    try {
      return super.setClientIdentifier(value);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoop(String value) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.setLoop');
    try {
      return super.setLoop(value);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void wipeStore() {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.wipeStore');
    try {
      return super.wipeStore();
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isConnection: ${isConnection},
connection: ${connection},
loop: ${loop},
isSendActive: ${isSendActive},
result: ${result},
settingsValid: ${settingsValid}
    ''';
  }
}
