import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../service/api_service.dart';
import '../app_color.dart';

class SampleDataBadge extends StatelessWidget {
  const SampleDataBadge({super.key});
  @override
  Widget build(BuildContext context) {
    if (!context.read<ApiService>().isSampleData) {
      return const SizedBox.shrink();
    }
    return const Text(
      'SAMPLE WORKSPACE',
      style: TextStyle(
        color: AppColor.textSecondary,
        fontSize: 10,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.7,
      ),
    );
  }
}

class ScreenHeader extends StatelessWidget {
  const ScreenHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SampleDataBadge(),
      const SizedBox(height: 16),
      Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w800,
                letterSpacing: -1,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: AppColor.mintSurface,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, color: AppColor.primary, size: 26),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Text(
        subtitle,
        style: const TextStyle(
          color: AppColor.textSecondary,
          height: 1.5,
          fontSize: 15,
        ),
      ),
      const SizedBox(height: 24),
    ],
  );
}
