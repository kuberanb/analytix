class PartnerModel {
  const PartnerModel({
    required this.id,
    required this.name,
    this.description,
    this.logoUrl,
    this.website,
    this.email,
    this.phone,
  });

  final String id;
  final String name;
  final String? description;
  final String? logoUrl;
  final String? website;
  final String? email;
  final String? phone;

  String get initials {
    final words = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty);
    if (words.isEmpty) return '?';
    return words
        .take(2)
        .map((word) => word.substring(0, 1))
        .join()
        .toUpperCase();
  }
}
