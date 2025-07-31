class HistoryItem {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final String timeString;
  final bool isToday;
  final String? imageUrl;

  const HistoryItem({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.timeString,
    required this.isToday,
    this.imageUrl,
  });

  HistoryItem copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    String? timeString,
    bool? isToday,
    String? imageUrl,
  }) {
    return HistoryItem(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      timeString: timeString ?? this.timeString,
      isToday: isToday ?? this.isToday,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
