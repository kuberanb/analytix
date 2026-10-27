import 'package:flutter/material.dart';
import '../../../core/app_color.dart';
import '../model/deal_status.dart';

extension DealStatusStyle on DealStatus {
  Color get foreground => switch (this) {
    DealStatus.newLead => AppColor.dealNew,
    DealStatus.proposal => AppColor.dealProposal,
    DealStatus.negotiation => AppColor.dealNegotiation,
  };
  Color get background => switch (this) {
    DealStatus.newLead => AppColor.dealNewBackground,
    DealStatus.proposal => AppColor.dealProposalBackground,
    DealStatus.negotiation => AppColor.dealNegotiationBackground,
  };
}

class DealStatusChip extends StatelessWidget {
  const DealStatusChip({super.key, required this.status});
  final DealStatus status;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: status.background,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      status.label,
      style: TextStyle(
        color: status.foreground,
        fontSize: 12,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
