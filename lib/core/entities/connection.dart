class Connection {
  final String broker;
  final int port;
  final String clientIdentifier;
  final String topic;
  final String? subtopic1;
  final String? subtopic2;
  final String? subtopic3;

  Connection({
    this.broker = '',
    this.clientIdentifier = '',
    this.port = 0,
    this.topic = '',
    this.subtopic1,
    this.subtopic2,
    this.subtopic3,
  });

  Connection copyWith({
    String? broker,
    int? port,
    String? topic,
    String? clientIdentifier,
    String? subtopic1,
    String? subtopic2,
    String? subtopic3,
  }) =>
      Connection(
        port: port ?? this.port,
        topic: topic ?? this.topic,
        clientIdentifier: clientIdentifier ?? this.clientIdentifier,
        broker: broker ?? this.broker,
        subtopic1: subtopic1 ?? this.subtopic1,
        subtopic2: subtopic2 ?? this.subtopic2,
        subtopic3: subtopic3 ?? this.subtopic3,
      );
}
