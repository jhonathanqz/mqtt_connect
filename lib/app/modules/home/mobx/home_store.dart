import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart' as mqtt;
import 'package:typed_data/typed_buffers.dart' show Uint8Buffer;

import 'package:beer_mqtt/core/entities/connection.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store implements Disposable {
  @observable
  bool isLoading = false;

  @observable
  Connection connection = Connection();

  @action
  void setBroker(String value) =>
      connection = connection.copyWith(broker: value);

  @action
  void setPort(String value) =>
      connection = connection.copyWith(port: int.tryParse(value));

  @action
  void setTopic(String value) => connection = connection.copyWith(topic: value);

  @action
  void setClientIdentifier(String value) =>
      connection = connection.copyWith(clientIdentifier: value);

  @action
  void setSubtopic1(String value) =>
      connection = connection.copyWith(subtopic1: value);

  @action
  void setSubtopic2(String value) =>
      connection = connection.copyWith(subtopic2: value);

  @action
  void setSubtopic3(String value) =>
      connection = connection.copyWith(subtopic3: value);

  @computed
  bool get settingsValid =>
      connection.broker.trim() != '' &&
      connection.port > 0 &&
      connection.topic.trim() != '' &&
      connection.clientIdentifier.trim() != '';

  @action
  void wipeStore() {
    isLoading = false;
    connection = Connection();
  }

  @override
  void dispose() => wipeStore();
}
