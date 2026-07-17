class CalculationHistoryItem {
  final DateTime createdAt;
  final String title;
  final String details;
  final String result;

  const CalculationHistoryItem({
    required this.createdAt,
    required this.title,
    required this.details,
    required this.result,
  });

  Map<String, dynamic> toJson() => {
    'createdAt': createdAt.toIso8601String(),
    'title': title,
    'details': details,
    'result': result,
  };

  factory CalculationHistoryItem.fromJson(Map<String, dynamic> json) {
    return CalculationHistoryItem(
      createdAt: DateTime.parse(json['createdAt'] as String),
      title: json['title'] as String,
      details: json['details'] as String,
      result: json['result'] as String,
    );
  }
}
