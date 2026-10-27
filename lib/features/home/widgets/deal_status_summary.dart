import 'package:flutter/material.dart';
import '../../../core/app_color.dart';
import '../../deals/model/deal_status.dart';
import '../../deals/widgets/deal_status_chip.dart';

class DealStatusSummary extends StatelessWidget {
  const DealStatusSummary({
    super.key,
    required this.status,
    required this.count,
    required this.proportion,
    required this.onTap,
  });
  final DealStatus status;
  final int count;
  final double proportion;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: 'View ${status.label} deals: $count',
    child: InkWell(
      key: ValueKey('home-status-${status.name}'),
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    status.label,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                Text(
                  '$count',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: proportion,
                minHeight: 6,
                color: status.foreground,
                backgroundColor: AppColor.progressTrack,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
