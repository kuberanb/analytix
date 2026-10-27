import 'package:flutter/material.dart';
import '../../../core/app_color.dart';

class DashboardSummaryCard extends StatelessWidget {
  const DashboardSummaryCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.background,
    required this.iconBackground,
    required this.onTap,
    required this.children,
  });
  final String label;
  final String value;
  final IconData icon;
  final Color background;
  final Color iconBackground;
  final VoidCallback onTap;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Material(
    color: background,
    borderRadius: BorderRadius.circular(24),
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: iconBackground,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, size: 23, color: AppColor.textPrimary),
                ),
                const Spacer(),
                const Icon(
                  Icons.north_east_rounded,
                  size: 18,
                  color: AppColor.textSecondary,
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.w800,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 22),
            ...children,
          ],
        ),
      ),
    ),
  );
}
