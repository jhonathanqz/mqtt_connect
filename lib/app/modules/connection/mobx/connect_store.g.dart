// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connect_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ConnectStore on _ConnectStoreBase, Store {
  late final _$isLoadingAtom =
      Atom(name: '_ConnectStoreBase.isLoading', context: context);

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

  late final _$resultAtom =
      Atom(name: '_ConnectStoreBase.result', context: context);

  @override
  List<ResultTopic> get result {
    _$resultAtom.reportRead();
    return super.result;
  }

  @override
  set result(List<ResultTopic> value) {
    _$resultAtom.reportWrite(value, super.result, () {
      super.result = value;
    });
  }

  late final _$sendMessageAtom =
      Atom(name: '_ConnectStoreBase.sendMessage', context: context);

  @override
  String get sendMessage {
    _$sendMessageAtom.reportRead();
    return super.sendMessage;
  }

  @override
  set sendMessage(String value) {
    _$sendMessageAtom.reportWrite(value, super.sendMessage, () {
      super.sendMessage = value;
    });
  }

  late final _$isSendActiveAtom =
      Atom(name: '_ConnectStoreBase.isSendActive', context: context);

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

  late final _$isConnectionAtom =
      Atom(name: '_ConnectStoreBase.isConnection', context: context);

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
      Atom(name: '_ConnectStoreBase.connection', context: context);

  @override
  Connection? get connection {
    _$connectionAtom.reportRead();
    return super.connection;
  }

  @override
  set connection(Connection? value) {
    _$connectionAtom.reportWrite(value, super.connection, () {
      super.connection = value;
    });
  }

  late final _$isUpdatedAtom =
      Atom(name: '_ConnectStoreBase.isUpdated', context: context);

  @override
  bool get isUpdated {
    _$isUpdatedAtom.reportRead();
    return super.isUpdated;
  }

  @override
  set isUpdated(bool value) {
    _$isUpdatedAtom.reportWrite(value, super.isUpdated, () {
      super.isUpdated = value;
    });
  }

  late final _$subscriptionAtom =
      Atom(name: '_ConnectStoreBase.subscription', context: context);

  @override
  StreamSubscription<dynamic>? get subscription {
    _$subscriptionAtom.reportRead();
    return super.subscription;
  }

  @override
  set subscription(StreamSubscription<dynamic>? value) {
    _$subscriptionAtom.reportWrite(value, super.subscription, () {
      super.subscription = value;
    });
  }

  late final _$clientAtom =
      Atom(name: '_ConnectStoreBase.client', context: context);

  @override
  mqtt.MqttServerClient? get client {
    _$clientAtom.reportRead();
    return super.client;
  }

  @override
  set client(mqtt.MqttServerClient? value) {
    _$clientAtom.reportWrite(value, super.client, () {
      super.client = value;
    });
  }

  late final _$connectionStateAtom =
      Atom(name: '_ConnectStoreBase.connectionState', context: context);

  @override
  MqttConnectionState? get connectionState {
    _$connectionStateAtom.reportRead();
    return super.connectionState;
  }

  @override
  set connectionState(MqttConnectionState? value) {
    _$connectionStateAtom.reportWrite(value, super.connectionState, () {
      super.connectionState = value;
    });
  }

  late final _$connectAsyncAction =
      AsyncAction('_ConnectStoreBase.connect', context: context);

  @override
  Future<void> connect() {
    return _$connectAsyncAction.run(() => super.connect());
  }

  late final _$testePublishAsyncAction =
      AsyncAction('_ConnectStoreBase.testePublish', context: context);

  @override
  Future<void> testePublish() {
    return _$testePublishAsyncAction.run(() => super.testePublish());
  }

  late final _$_ConnectStoreBaseActionController =
      ActionController(name: '_ConnectStoreBase', context: context);

  @override
  void setMessage(String value) {
    final _$actionInfo = _$_ConnectStoreBaseActionController.startAction(
        name: '_ConnectStoreBase.setMessage');
    try {
      return super.setMessage(value);
    } finally {
      _$_ConnectStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConnection(Connection? value) {
    final _$actionInfo = _$_ConnectStoreBaseActionController.startAction(
        name: '_ConnectStoreBase.setConnection');
    try {
      return super.setConnection(value);
    } finally {
      _$_ConnectStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTopicMessage(String value) {
    final _$actionInfo = _$_ConnectStoreBaseActionController.startAction(
        name: '_ConnectStoreBase.setTopicMessage');
    try {
      return super.setTopicMessage(value);
    } finally {
      _$_ConnectStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void disconnectMqqt() {
    final _$actionInfo = _$_ConnectStoreBaseActionController.startAction(
        name: '_ConnectStoreBase.disconnectMqqt');
    try {
      return super.disconnectMqqt();
    } finally {
      _$_ConnectStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _disconnect() {
    final _$actionInfo = _$_ConnectStoreBaseActionController.startAction(
        name: '_ConnectStoreBase._disconnect');
    try {
      return super._disconnect();
    } finally {
      _$_ConnectStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _onDisconnected() {
    final _$actionInfo = _$_ConnectStoreBaseActionController.startAction(
        name: '_ConnectStoreBase._onDisconnected');
    try {
      return super._onDisconnected();
    } finally {
      _$_ConnectStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _onMessage(List<MqttReceivedMessage<dynamic>> event) {
    final _$actionInfo = _$_ConnectStoreBaseActionController.startAction(
        name: '_ConnectStoreBase._onMessage');
    try {
      return super._onMessage(event);
    } finally {
      _$_ConnectStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void insertMessage(ResultTopic res) {
    final _$actionInfo = _$_ConnectStoreBaseActionController.startAction(
        name: '_ConnectStoreBase.insertMessage');
    try {
      return super.insertMessage(res);
    } finally {
      _$_ConnectStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _subscribeToTopic(String topic) {
    final _$actionInfo = _$_ConnectStoreBaseActionController.startAction(
        name: '_ConnectStoreBase._subscribeToTopic');
    try {
      return super._subscribeToTopic(topic);
    } finally {
      _$_ConnectStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void wipeStore() {
    final _$actionInfo = _$_ConnectStoreBaseActionController.startAction(
        name: '_ConnectStoreBase.wipeStore');
    try {
      return super.wipeStore();
    } finally {
      _$_ConnectStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
result: ${result},
sendMessage: ${sendMessage},
isSendActive: ${isSendActive},
isConnection: ${isConnection},
connection: ${connection},
isUpdated: ${isUpdated},
subscription: ${subscription},
client: ${client},
connectionState: ${connectionState}
    ''';
  }
}
