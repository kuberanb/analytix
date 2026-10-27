import 'deal_status.dart';

class DealModel {
  const DealModel({
    required this.id,
    required this.title,
    required this.customerName,
    required this.status,
    required this.createdAt,
    this.partnerId,
    this.description,
    this.updatedAt,
    this.amount,
    this.currencyCode,
  });

  final String id;
  final String title;
  final String customerName;
  final DealStatus status;
  final DateTime createdAt;
  final String? partnerId;
  final String? description;
  final DateTime? updatedAt;
  final double? amount;
  final String? currencyCode;
}
