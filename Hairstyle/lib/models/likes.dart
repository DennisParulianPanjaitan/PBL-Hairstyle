class Like {
  final int id;
  final int userId;
  final String entityType;
  final int entityId;
  final DateTime createdAt;

  Like({
    required this.id,
    required this.userId,
    required this.entityType,
    required this.entityId,
    required this.createdAt,
  });

  // Factory constructor untuk membuat instance dari JSON
  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      id: json['id'],
      userId: json['user_id'],
      entityType: json['entity_type'],
      entityId: json['entity_id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  // Method untuk mengubah instance menjadi Map (untuk dikirim sebagai JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'entity_type': entityType,
      'entity_id': entityId,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
