class ChatMessage {
  final String text;
  final bool isBot;
  final DateTime timestamp;
  final List<String>? suggestions; // Quick reply suggestions

  ChatMessage({
    required this.text,
    required this.isBot,
    DateTime? timestamp,
    this.suggestions,
  }) : timestamp = timestamp ?? DateTime.now();
}
