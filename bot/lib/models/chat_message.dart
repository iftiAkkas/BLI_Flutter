class ChatMessage {
  final String id;
  final String sender;
  final String content;
  final DateTime timestamp;

  ChatMessage({
    String? id,
    required this.sender,
    required this.content,
    DateTime? timestamp,
  }) : id = id ?? DateTime.now().toIso8601String(),
       timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    'id': id,
    'sender': sender,
    'content': content,
    'timestamp': timestamp.toIso8601String(),
  };

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
    id: json['id'] as String,
    sender: json['sender'] as String,
    content: json['content'] as String,
    timestamp: DateTime.parse(json['timestamp'] as String),
  );
}