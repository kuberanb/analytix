import 'package:flutter/material.dart';
import '../../../core/app_color.dart';
import '../../../core/formatters.dart';
import '../model/activity_model.dart';

class ActivityTile extends StatelessWidget {
  const ActivityTile({super.key, required this.activity, this.onTap});
  final ActivityModel activity;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => Material(
    color: AppColor.transparent,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColor.blueSurface,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(
                Icons.timeline_rounded,
                size: 21,
                color: AppColor.dealProposal,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activity.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      height: 1.4,
                    ),
                  ),
                  if (activity.description != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      activity.description!,
                      style: const TextStyle(
                        color: AppColor.textSecondary,
                        fontSize: 12,
                        height: 1.5,
                      ),
                    ),
                  ],
                  const SizedBox(height: 6),
                  Text(
                    AppFormatters.relativeTime(activity.occurredAt),
                    style: const TextStyle(
                      color: AppColor.textSecondary,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              const Padding(
                padding: EdgeInsets.only(left: 8, top: 3),
                child: Icon(
                  Icons.chevron_right_rounded,
                  color: AppColor.textSecondary,
                  size: 18,
                ),
              ),
          ],
        ),
      ),
    ),
  );
}
