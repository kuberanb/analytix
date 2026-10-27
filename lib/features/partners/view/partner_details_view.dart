import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/app_color.dart';
import '../../../core/widgets/app_detail_panel.dart';
import '../../../core/widgets/app_empty_state.dart';
import '../../../core/widgets/app_error_state.dart';
import '../../../core/widgets/app_loading_view.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/screen_header.dart';
import '../../../service/api_service.dart';
import '../../deals/view/deal_details_view.dart';
import '../../deals/widgets/deal_card.dart';
import '../view_model/partner_details_view_model.dart';
import '../widgets/partner_avatar.dart';

class PartnerDetailsView extends StatelessWidget {
  const PartnerDetailsView({super.key});

  static void open(BuildContext context, String id) {
    final service = context.read<ApiService>();
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ChangeNotifierProvider(
          create: (_) => PartnerDetailsViewModel(service, id)..loadPartner(),
          child: const PartnerDetailsView(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PartnerDetailsViewModel>();
    final partner = vm.partner;
    return Scaffold(
      appBar: AppBar(title: const Text('Company details')),
      body: AppPage(
        onRefresh: vm.loadPartner,
        children: [
          const SampleDataBadge(),
          const SizedBox(height: 24),
          if (vm.isLoading)
            const AppLoadingView()
          else if (vm.errorMessage != null)
            AppErrorState(message: vm.errorMessage!, onRetry: vm.loadPartner)
          else if (partner == null)
            const AppEmptyState(
              title: 'Company not found',
              message: 'This company is no longer available in the directory.',
            )
          else ...[
            Align(
              alignment: Alignment.centerLeft,
              child: PartnerAvatar(partner: partner, size: 72),
            ),
            const SizedBox(height: 22),
            Text(
              partner.name,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                letterSpacing: -.8,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'PART OF ANALYTIX',
              style: TextStyle(
                color: AppColor.primary,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 28),
            AppDetailPanel(
              children: [
                const Text(
                  'About the company',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                Text(
                  partner.description ??
                      'More information will be available soon.',
                  style: const TextStyle(
                    color: AppColor.textSecondary,
                    height: 1.7,
                  ),
                ),
                if (partner.website != null)
                  AppDetailField(label: 'Website', value: partner.website!),
                if (partner.email != null)
                  AppDetailField(label: 'Email', value: partner.email!),
                if (partner.phone != null)
                  AppDetailField(label: 'Phone', value: partner.phone!),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              'Related deals (${vm.deals.length})',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            if (vm.deals.isEmpty)
              const AppEmptyState(
                title: 'No deals here yet',
                message: 'Leads associated with this company will appear here.',
              )
            else
              for (final deal in vm.deals)
                DealCard(
                  deal: deal,
                  companyName: partner.name,
                  onTap: () => DealDetailsView.open(context, deal.id),
                ),
          ],
        ],
      ),
    );
  }
}
