import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/app_color.dart';
import '../../../core/widgets/app_empty_state.dart';
import '../../../core/widgets/app_error_state.dart';
import '../../../core/widgets/app_loading_view.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/app_search_field.dart';
import '../../../core/widgets/screen_header.dart';
import '../view_model/partners_view_model.dart';
import '../widgets/partner_card.dart';
import 'partner_details_view.dart';

class PartnersView extends StatelessWidget {
  const PartnersView({super.key});
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PartnersViewModel>();
    final partners = vm.filteredPartners;
    return AppPage(
      storageKey: 'partners-page',
      onRefresh: vm.loadPartners,
      children: [
        const ScreenHeader(
          title: 'Partners',
          subtitle: 'Our companies. A world of possibilities.',
          icon: Icons.business_outlined,
        ),
        AppSearchField(
          key: const ValueKey('partners-search'),
          value: vm.searchQuery,
          hint: 'Search our companies',
          onChanged: vm.setSearchQuery,
        ),
        const SizedBox(height: 26),
        if (vm.isLoading)
          const AppLoadingView()
        else if (vm.errorMessage != null)
          AppErrorState(message: vm.errorMessage!, onRetry: vm.loadPartners)
        else if (vm.totalCount == 0)
          const AppEmptyState(
            title: 'Companies are on their way',
            message: 'Our company directory will appear here.',
            icon: Icons.business_outlined,
          )
        else if (partners.isEmpty)
          AppEmptyState(
            title: 'No companies found',
            message: 'Try searching for another company name.',
            icon: Icons.search_off_rounded,
            actionLabel: 'Clear search',
            onAction: () => vm.setSearchQuery(''),
          )
        else ...[
          Text(
            '${partners.length} ${partners.length == 1 ? 'company' : 'companies'} to explore',
            style: const TextStyle(
              color: AppColor.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          for (final partner in partners)
            PartnerCard(
              key: ValueKey(partner.id),
              partner: partner,
              onTap: () => PartnerDetailsView.open(context, partner.id),
            ),
        ],
      ],
    );
  }
}
