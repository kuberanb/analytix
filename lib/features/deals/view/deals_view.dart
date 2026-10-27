import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/app_color.dart';
import '../../../core/widgets/app_empty_state.dart';
import '../../../core/widgets/app_error_state.dart';
import '../../../core/widgets/app_loading_view.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/app_search_field.dart';
import '../../../core/widgets/screen_header.dart';
import '../model/deal_status.dart';
import '../view_model/deals_view_model.dart';
import '../widgets/deal_card.dart';
import 'deal_details_view.dart';

class DealsView extends StatelessWidget {
  const DealsView({super.key});
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<DealsViewModel>();
    final deals = vm.filteredDeals;
    return AppPage(
      storageKey: 'deals-page',
      onRefresh: vm.loadDeals,
      children: [
        const ScreenHeader(
          title: 'Deals',
          subtitle: 'Good connections. Bigger opportunities.',
          icon: Icons.work_outline_rounded,
        ),
        AppSearchField(
          key: const ValueKey('deals-search'),
          value: vm.searchQuery,
          hint: 'Search deals, customers, companies',
          onChanged: vm.setSearchQuery,
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final status in [null, ...DealStatus.values])
              ChoiceChip(
                key: ValueKey('filter-${status?.name ?? 'all'}'),
                label: Text(
                  '${status?.label ?? 'All'}  ${status == null ? vm.totalCount : vm.countFor(status)}',
                ),
                selected: vm.selectedStatus == status,
                onSelected: (_) => vm.selectStatus(status),
                showCheckmark: false,
                selectedColor: AppColor.primary,
                backgroundColor: AppColor.surface,
                side: BorderSide(
                  color: vm.selectedStatus == status
                      ? AppColor.primary
                      : AppColor.border,
                ),
                labelStyle: TextStyle(
                  color: vm.selectedStatus == status
                      ? AppColor.onPrimary
                      : AppColor.textSecondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
          ],
        ),
        const SizedBox(height: 26),
        if (vm.isLoading)
          const AppLoadingView()
        else if (vm.errorMessage != null)
          AppErrorState(message: vm.errorMessage!, onRetry: vm.loadDeals)
        else if (vm.totalCount == 0)
          const AppEmptyState(
            title: 'Your next opportunity is ahead',
            message: 'New leads will appear here when they are available.',
            icon: Icons.work_outline_rounded,
          )
        else if (deals.isEmpty)
          AppEmptyState(
            title: 'No matching deals',
            message: 'Try another search or choose a different status.',
            icon: Icons.search_off_rounded,
            actionLabel: 'Reset filters',
            onAction: vm.resetFilters,
          )
        else ...[
          Text(
            '${deals.length} ${deals.length == 1 ? 'opportunity' : 'opportunities'}',
            style: const TextStyle(
              color: AppColor.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 14),
          for (final deal in deals)
            DealCard(
              key: ValueKey(deal.id),
              deal: deal,
              companyName: vm.companyName(deal),
              onTap: () => DealDetailsView.open(context, deal.id),
            ),
        ],
      ],
    );
  }
}
