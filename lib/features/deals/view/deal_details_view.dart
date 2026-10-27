import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/app_color.dart';
import '../../../core/formatters.dart';
import '../../../core/widgets/app_detail_panel.dart';
import '../../../core/widgets/app_empty_state.dart';
import '../../../core/widgets/app_error_state.dart';
import '../../../core/widgets/app_loading_view.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/screen_header.dart';
import '../../../service/api_service.dart';
import '../../partners/view/partner_details_view.dart';
import '../view_model/deal_details_view_model.dart';
import '../widgets/deal_status_chip.dart';

class DealDetailsView extends StatelessWidget {
  const DealDetailsView({super.key});

  static void open(BuildContext context, String id) {
    final service = context.read<ApiService>();
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ChangeNotifierProvider(
          create: (_) => DealDetailsViewModel(service, id)..loadDeal(),
          child: const DealDetailsView(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<DealDetailsViewModel>();
    final deal = vm.deal;
    return Scaffold(
      appBar: AppBar(title: const Text('Deal details')),
      body: AppPage(
        onRefresh: vm.loadDeal,
        children: [
          const SampleDataBadge(),
          const SizedBox(height: 24),
          if (vm.isLoading)
            const AppLoadingView()
          else if (vm.errorMessage != null)
            AppErrorState(message: vm.errorMessage!, onRetry: vm.loadDeal)
          else if (deal == null)
            const AppEmptyState(
              title: 'Deal not found',
              message:
                  'This lead is no longer available. Go back to explore other deals.',
            )
          else ...[
            Align(
              alignment: Alignment.centerLeft,
              child: DealStatusChip(status: deal.status),
            ),
            const SizedBox(height: 20),
            Text(
              deal.title,
              style: const TextStyle(
                fontSize: 30,
                letterSpacing: -.8,
                fontWeight: FontWeight.w800,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              deal.customerName,
              style: const TextStyle(
                color: AppColor.textSecondary,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 28),
            AppDetailPanel(
              children: [
                const Text(
                  'The opportunity',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                Text(
                  deal.description ?? 'No description has been added yet.',
                  style: const TextStyle(
                    color: AppColor.textSecondary,
                    height: 1.7,
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(),
                AppDetailField(label: 'Customer', value: deal.customerName),
                AppDetailField(
                  label: 'Created',
                  value: AppFormatters.date(deal.createdAt),
                ),
                if (deal.updatedAt != null)
                  AppDetailField(
                    label: 'Last updated',
                    value: AppFormatters.date(deal.updatedAt!),
                  ),
                if (deal.amount != null && deal.currencyCode != null)
                  AppDetailField(
                    label: 'Deal value',
                    value: AppFormatters.amount(
                      deal.amount!,
                      deal.currencyCode!,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            AppDetailPanel(
              children: [
                const Text(
                  'Our company',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                Text(
                  vm.partner?.name ?? 'Company not assigned',
                  style: const TextStyle(
                    color: AppColor.textSecondary,
                    fontSize: 16,
                  ),
                ),
                if (vm.partner != null) ...[
                  const SizedBox(height: 16),
                  TextButton.icon(
                    onPressed: () =>
                        PartnerDetailsView.open(context, vm.partner!.id),
                    icon: const Icon(Icons.business_outlined),
                    label: const Text('View company'),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}
