class TownhallModel {
  final String id;
  final String name;
  final String imageUrl;
  final String category; // 'Home Village', 'Builder Base', etc.
  final String status; // 'Published', 'Blocked'

  TownhallModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.status,
  });

  factory TownhallModel.fromJson(Map<String, dynamic> json) {
    return TownhallModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      imageUrl: json['imageUrl'] ?? json['image_url'] ?? '',
      category: json['category']?.toString() ?? '',
      status: json['status']?.toString() ?? 'Published',
    );
  }
}
