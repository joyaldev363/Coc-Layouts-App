class LayoutModel {
  final String id;
  final String name;
  final String imageUrl;
  final String category;
  final String type;
  final String thLevel;
  final String status;
  final int views;
  final int downloads;
  final List<String> tags;
  final String? recommendedCC;
  final double? winRate;
  final List<String> featuredBadges;
  final String? copyLink;
  final String? imageHash;
  final String? description;
  final DateTime createdAt;

  LayoutModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.type,
    required this.thLevel,
    required this.status,
    required this.views,
    required this.downloads,
    required this.tags,
    this.recommendedCC,
    this.winRate,
    required this.featuredBadges,
    this.copyLink,
    this.imageHash,
    this.description,
    required this.createdAt,
  });

  factory LayoutModel.fromJson(Map<String, dynamic> json) {
    return LayoutModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      imageUrl: json['imageUrl'] ?? json['image_url'] ?? '',
      category: json['category']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      thLevel: json['thLevel'] ?? json['th_level'] ?? json['thLevel']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      views: int.tryParse(json['views']?.toString() ?? '') ?? 0,
      downloads: int.tryParse(json['downloads']?.toString() ?? '') ?? 0,
      tags: json['tags'] != null ? List<String>.from(json['tags']) : [],
      recommendedCC: json['recommendedCC'] ?? json['recommended_cc'],
      winRate: double.tryParse(json['winRate']?.toString() ?? json['win_rate']?.toString() ?? ''),
      featuredBadges: json['featuredBadges'] != null
          ? List<String>.from(json['featuredBadges'])
          : (json['featured_badges'] != null ? List<String>.from(json['featured_badges']) : []),
      copyLink: json['copyLink'] ?? json['copy_link'],
      imageHash: json['imageHash'] ?? json['image_hash'],
      description: json['description'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
    );
  }
}
