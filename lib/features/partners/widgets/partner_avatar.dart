import 'package:flutter/material.dart';
import '../../../core/app_color.dart';
import '../model/partner_model.dart';

class PartnerAvatar extends StatelessWidget {
  const PartnerAvatar({super.key, required this.partner, this.size = 52});
  final PartnerModel partner;
  final double size;
  @override
  Widget build(BuildContext context) {
    final fallback = Center(
      child: Text(
        partner.initials,
        style: TextStyle(
          color: AppColor.primaryDark,
          fontSize: size * .31,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColor.mintAccent,
        borderRadius: BorderRadius.circular(size * .28),
      ),
      child: partner.logoUrl == null || partner.logoUrl!.trim().isEmpty
          ? fallback
          : Image.network(
              partner.logoUrl!,
              fit: BoxFit.cover,
              errorBuilder: (_, error, stackTrace) => fallback,
            ),
    );
  }
}
