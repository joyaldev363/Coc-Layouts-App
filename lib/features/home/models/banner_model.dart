class BannerModel {
  final String id;
  final String title;
  final String imageUrl;
  final String? targetUrl;
  final bool isActive;
  final int sortOrder;

  BannerModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.targetUrl,
    required this.isActive,
    required this.sortOrder,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      imageUrl: json['image_url'] ?? json['imageUrl'] ?? '',
      targetUrl: json['target_url'] ?? json['targetUrl'],
      isActive: json['is_active'] ?? json['isActive'] ?? true,
      sortOrder: int.tryParse(json['sort_order']?.toString() ?? json['sortOrder']?.toString() ?? '') ?? 0,
    );
  }
}
