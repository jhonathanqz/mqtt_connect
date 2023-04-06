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
  bool isConnection = false;

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

  @observable
  String sendMessage = '';

  @action
  void setLoop(String value) => sendMessage = value;

  @action
  void setSubtopic1(String value) =>
      connection = connection.copyWith(subtopic1: value);

  @action
  void setSubtopic2(String value) =>
      connection = connection.copyWith(subtopic2: value);

  @action
  void setSubtopic3(String value) =>
      connection = connection.copyWith(subtopic3: value);

  @observable
  bool isSendActive = false;

  @computed
  bool get settingsValid =>
      connection.broker.trim() != '' &&
      connection.port > 0 &&
      connection.topic.trim() != '' &&
      connection.clientIdentifier.trim() != '';

  @observable
  String result = '';

  StreamSubscription? subscription;

  mqtt.MqttServerClient? client;
  MqttConnectionState? connectionState;

  @action
  Future<void> connect() async {
    isLoading = true;
    isConnection = false;
    client = mqtt.MqttServerClient(connection.broker, '');
    client?.port = connection.port;
    client?.logging(on: true);
    client?.keepAlivePeriod = 30;
    client?.onDisconnected = _onDisconnected;

    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier(connection.clientIdentifier)
        .startClean() // Non persistent session for testing
        .keepAliveFor(30)
        .withWillQos(MqttQos.atMostOnce);
    print('*******[MQTT client] MQTT client connecting....');
    client?.connectionMessage = connMess;

    try {
      await client?.connect();
      print('*****Conectado com sucesso....');
    } catch (e) {
      print('*****Erro ao realizar conexão: $e');
      _disconnect();
    }

    /// Check if we are connected
    if (client?.connectionState == MqttConnectionState.connected) {
      isConnection = true;
      print('*******[MQTT client] connected');
      connectionState = client?.connectionState;
    } else {
      print('*******[MQTT client] ERROR: MQTT client connection failed - '
          '*******disconnecting, state is ${client?.connectionState}');
      _disconnect();
    }

    _subscribeToTopic(connection.topic);
    subscription = client?.updates?.listen(_onMessage);

    isLoading = false;
  }

  @action
  void disconnectMqqt() => _disconnect();

  /*
  Desconecta do servidor MQTT
   */
  void _disconnect() {
    print('*******[MQTT client] _disconnect()');
    client?.disconnect();
    _onDisconnected();
  }

  /*
  Executa algo quando desconectado, no caso, zera as variáveis e imprime msg no console
   */
  void _onDisconnected() {
    print('*******[MQTT client] _onDisconnected');
    connectionState = client?.connectionState;
    client = null;
    subscription?.cancel();
    subscription = null;
    isConnection = false;
    print('*******[MQTT client] MQTT client disconnected');
  }

  /*
  Escuta quando mensagens são escritas no tópico. É aqui que lê os dados do servidor MQTT e modifica o valor do termômetro
   */
  void _onMessage(List<MqttReceivedMessage> event) {
    print(event.length);
    final MqttPublishMessage recMess = event[0].payload as MqttPublishMessage;
    final messageString =
        MqttPublishPayload.bytesToString(recMess.payload.message);
    final String message =
        MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
    print('*******[MQTT client] MQTT message: topic is <${event[0].topic}>, '
        '*******payload is <-- ${message} -->');
    print(client?.connectionState);
    print("*******[MQTT client] message with topic: ${event[0].topic}");
    print("*******[MQTT client] message with message: ${message}");
    print('******MESSAGE_CONVERT: $message');
    print('******TESTE_CONVERT: $messageString');
    result = message;
  }

  /*
  Assina o tópico onde virão os dados de temperatura
   */
  void _subscribeToTopic(String topic) {
    if (connectionState == MqttConnectionState.connected) {
      print('*******[MQTT client] Subscribing topic: ${topic.trim()}');
      client?.subscribe(topic, MqttQos.exactlyOnce);
      if (connection.subtopic1 != null) {
        client?.subscribe(connection.subtopic1!, MqttQos.exactlyOnce);
      }
      if (connection.subtopic2 != null) {
        client?.subscribe(connection.subtopic2!, MqttQos.exactlyOnce);
      }
      if (connection.subtopic3 != null) {
        client?.subscribe(connection.subtopic3!, MqttQos.exactlyOnce);
      }
      // client?.subscribe('stat/testtopic/1/RESULT', MqttQos.exactlyOnce);
      // client?.subscribe('stat/testtopic/1/STATUS11', MqttQos.exactlyOnce);
    }
  }

  void testePublish() async {
    print('**iniciando envio, loop: $sendMessage');
    isSendActive = true;
    //Uint8Buffer value = Uint8Buffer();
    //value.add(i);
    final builder = MqttClientPayloadBuilder();
    builder.addString(sendMessage);
    client?.publishMessage(
        connection.topic, MqttQos.exactlyOnce, builder.payload!);
    await Future.delayed(const Duration(milliseconds: 500));
    isSendActive = false;
  }

  @action
  void wipeStore() {
    isLoading = false;
    isSendActive = false;
    isConnection = false;
    connection = Connection();
  }

  @override
  void dispose() => wipeStore();
}
