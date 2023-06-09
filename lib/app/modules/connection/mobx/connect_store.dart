import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart' as mqtt;
import 'package:typed_data/typed_buffers.dart' show Uint8Buffer;

import 'package:beer_mqtt/core/entities/connection.dart';
import 'package:beer_mqtt/core/entities/result_topic.dart';

part 'connect_store.g.dart';

class ConnectStore = _ConnectStoreBase with _$ConnectStore;

abstract class _ConnectStoreBase with Store implements Disposable {
  @observable
  bool isLoading = false;

  @observable
  List<ResultTopic> result = [];

  @observable
  String sendMessage = '';

  @action
  void setMessage(String value) => sendMessage = value;

  @observable
  bool isSendActive = false;

  @observable
  bool isConnection = false;

  @observable
  Connection? connection;

  @observable
  bool isUpdated = false;

  @action
  void setConnection(Connection? value) => connection = value;

  @action
  void setTopicMessage(String value) =>
      connection = connection?.copyWith(topic: value);

  @observable
  StreamSubscription? subscription;
  @observable
  mqtt.MqttServerClient? client;
  @observable
  MqttConnectionState? connectionState;

  @action
  Future<void> connect() async {
    if (connection == null) {
      return;
    }
    isLoading = true;
    isConnection = false;
    client = mqtt.MqttServerClient(connection!.broker, '');
    client?.port = connection!.port;
    client?.logging(on: true);
    client?.keepAlivePeriod = 30;
    client?.onDisconnected = _onDisconnected;

    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier(connection!.clientIdentifier)
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

    _subscribeToTopic(connection!.topic);
    subscription = client?.updates?.listen(_onMessage);

    isLoading = false;
  }

  @action
  void disconnectMqqt() => _disconnect();

  /*
  Desconecta do servidor MQTT
   */
  @action
  void _disconnect() {
    print('*******[MQTT client] _disconnect()');
    client?.disconnect();
    _onDisconnected();
  }

  /*
  Executa algo quando desconectado, no caso, zera as variáveis e imprime msg no console
   */
  @action
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
  @action
  void _onMessage(List<MqttReceivedMessage> event) {
    print(event.length);
    final MqttPublishMessage recMess = event[0].payload as MqttPublishMessage;
    final messageString =
        MqttPublishPayload.bytesToString(recMess.payload.message);
    final String message =
        MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
    final _topic = event[0].topic;
    print('*******[MQTT client] MQTT message: topic is <$_topic>, '
        '*******payload is <-- ${message} -->');
    print(client?.connectionState);
    print("*******[MQTT client] message with topic: ${event[0].topic}");
    print("*******[MQTT client] message with message: ${message}");
    print('******MESSAGE_CONVERT: $message');
    print('******TESTE_CONVERT: $messageString');
    //result = message;
    insertMessage(
      ResultTopic(
        topic: _topic,
        message: message,
      ),
    );
  }

  @action
  void insertMessage(ResultTopic res) {
    result.add(res);
    isUpdated = true;
  }

  /*
  Assina o tópico onde virão os dados de temperatura
   */
  @action
  void _subscribeToTopic(String topic) {
    if (connectionState == MqttConnectionState.connected) {
      print('*******[MQTT client] Subscribing topic: ${topic.trim()}');
      client?.subscribe(topic, MqttQos.exactlyOnce);
      if (connection != null) {
        if (connection!.subtopic1 != null) {
          client?.subscribe(connection!.subtopic1!, MqttQos.exactlyOnce);
        }
        if (connection!.subtopic2 != null) {
          client?.subscribe(connection!.subtopic2!, MqttQos.exactlyOnce);
        }
        if (connection!.subtopic3 != null) {
          client?.subscribe(connection!.subtopic3!, MqttQos.exactlyOnce);
        }
      }
      // client?.subscribe('stat/testtopic/1/RESULT', MqttQos.exactlyOnce);
      // client?.subscribe('stat/testtopic/1/STATUS11', MqttQos.exactlyOnce);
    }
  }

  @action
  Future<void> testePublish() async {
    print('**iniciando envio, loop: $sendMessage');
    isLoading = true;
    isSendActive = true;
    result = [];

    final builder = MqttClientPayloadBuilder();
    builder.addString(sendMessage);
    client?.publishMessage(
        connection!.topic, MqttQos.exactlyOnce, builder.payload!);
    await Future.delayed(const Duration(milliseconds: 500));
    isSendActive = false;
    isLoading = false;
  }

  @action
  void wipeStore() {
    isLoading = false;
    connection = null;
  }

  @override
  void dispose() => wipeStore();
}
