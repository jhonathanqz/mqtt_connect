class ResultTopic {
  final String topic;
  final String message;

  ResultTopic({
    this.topic = '',
    this.message = '',
  });

  ResultTopic copyWith({
    String? topic,
    String? message,
  }) =>
      ResultTopic(
        topic: topic ?? this.topic,
        message: message ?? this.message,
      );
}
