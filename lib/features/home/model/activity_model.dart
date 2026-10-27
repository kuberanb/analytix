class ActivityModel {
  const ActivityModel({
    required this.id,
    required this.title,
    required this.occurredAt,
    this.description,
    this.dealId,
    this.partnerId,
  });

  final String id;
  final String title;
  final DateTime occurredAt;
  final String? description;
  final String? dealId;
  final String? partnerId;
}
