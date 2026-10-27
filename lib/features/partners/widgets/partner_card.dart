import 'package:flutter/material.dart';
import '../../../core/app_color.dart';
import '../model/partner_model.dart';
import 'partner_avatar.dart';

class PartnerCard extends StatelessWidget {
  const PartnerCard({super.key, required this.partner, required this.onTap});
  final PartnerModel partner;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Material(
      color: AppColor.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: const BorderSide(color: AppColor.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  PartnerAvatar(partner: partner),
                  const Spacer(),
                  const Icon(
                    Icons.north_east_rounded,
                    color: AppColor.primary,
                    size: 22,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                partner.name,
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -.5,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                partner.description ??
                    'Explore this company and its opportunities.',
                style: const TextStyle(
                  color: AppColor.textSecondary,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 22),
              const Text(
                'Explore company',
                style: TextStyle(
                  color: AppColor.primaryDark,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
