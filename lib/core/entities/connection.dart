class Connection {
  final String broker;
  final int port;
  final String clientIdentifier;
  final String topic;

  Connection({
    this.broker = '',
    this.clientIdentifier = '',
    this.port = 0,
    this.topic = '',
  });

  Connection copyWith({
    String? broker,
    int? port,
    String? topic,
    String? clientIdentifier,
  }) =>
      Connection(
        port: port ?? this.port,
        topic: topic ?? this.topic,
        clientIdentifier: clientIdentifier ?? this.clientIdentifier,
        broker: broker ?? this.broker,
      );
}
