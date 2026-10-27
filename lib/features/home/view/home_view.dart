import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/app_color.dart';
import '../../../core/widgets/app_empty_state.dart';
import '../../../core/widgets/app_error_state.dart';
import '../../../core/widgets/app_loading_view.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/screen_header.dart';
import '../../deals/model/deal_status.dart';
import '../../deals/view/deal_details_view.dart';
import '../../partners/view/partner_details_view.dart';
import '../view_model/home_view_model.dart';
import '../widgets/activity_tile.dart';
import '../widgets/dashboard_summary_card.dart';
import '../widgets/deal_status_summary.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
    required this.onOpenDeals,
    required this.onOpenPartners,
  });
  final ValueChanged<DealStatus?> onOpenDeals;
  final VoidCallback onOpenPartners;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();
    return AppPage(
      storageKey: 'home-page',
      onRefresh: vm.loadHome,
      children: [
        const _BrandHeader(),
        const SizedBox(height: 30),
        const SampleDataBadge(),
        const SizedBox(height: 12),
        Text(
          '${vm.greeting}\npartner.',
          style: const TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w800,
            height: 1.15,
            letterSpacing: -1.2,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Together, we build bigger opportunities.',
          style: TextStyle(
            fontSize: 15,
            color: AppColor.textSecondary,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 28),
        if (vm.isLoading)
          const AppLoadingView()
        else if (vm.errorMessage != null)
          AppErrorState(message: vm.errorMessage!, onRetry: vm.loadHome)
        else ...[
          LayoutBuilder(
            builder: (context, constraints) {
              final cards = [
                DashboardSummaryCard(
                  key: const ValueKey('home-deals'),
                  label: 'Deals',
                  value: '${vm.totalDeals} active',
                  icon: Icons.work_outline_rounded,
                  background: AppColor.mintSurface,
                  iconBackground: AppColor.mintAccent,
                  onTap: () => onOpenDeals(null),
                  children: [
                    for (final status in DealStatus.values)
                      DealStatusSummary(
                        status: status,
                        count: vm.countFor(status),
                        proportion: vm.proportionFor(status),
                        onTap: () => onOpenDeals(status),
                      ),
                  ],
                ),
                DashboardSummaryCard(
                  key: const ValueKey('home-partners'),
                  label: 'Partners',
                  value: '${vm.totalPartners}',
                  icon: Icons.business_outlined,
                  background: AppColor.amberSurface,
                  iconBackground: AppColor.amberAccent,
                  onTap: onOpenPartners,
                  children: [
                    Text(
                      '${vm.totalPartners == 1 ? 'Company' : 'Companies'} in the Analytix group.',
                      style: const TextStyle(
                        color: AppColor.textSecondary,
                        height: 1.6,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 20),
                    for (final partner in vm.partners.take(2))
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.check_circle_outline_rounded,
                              size: 15,
                              color: AppColor.dealNegotiation,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                partner.name,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (vm.partners.isEmpty)
                      const Text(
                        'Your company directory will appear here.',
                        style: TextStyle(
                          color: AppColor.textSecondary,
                          height: 1.5,
                        ),
                      ),
                  ],
                ),
              ];
              final largeText = MediaQuery.textScalerOf(context).scale(14) > 18;
              if (constraints.maxWidth < 340 || largeText) {
                return Column(
                  children: [cards[0], const SizedBox(height: 16), cards[1]],
                );
              }
              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: cards[0]),
                    const SizedBox(width: 14),
                    Expanded(child: cards[1]),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 18),
          Material(
            color: AppColor.blueSurface,
            borderRadius: BorderRadius.circular(24),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              key: const ValueKey('home-new-leads'),
              onTap: () => onOpenDeals(DealStatus.newLead),
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColor.dealProposalBackground,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.auto_awesome_outlined,
                        color: AppColor.dealProposal,
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${vm.countFor(DealStatus.newLead)} new opportunities',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'A conversation can change everything.',
                            style: TextStyle(
                              color: AppColor.textSecondary,
                              fontSize: 12,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColor.dealProposal,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Latest activity',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              letterSpacing: -.5,
            ),
          ),
          const SizedBox(height: 4),
          if (vm.activities.isEmpty)
            const AppEmptyState(
              title: 'A fresh start',
              message: 'Your latest workspace activity will appear here.',
            )
          else
            for (final activity in vm.activities) ...[
              ActivityTile(
                activity: activity,
                onTap: activity.dealId != null
                    ? () => DealDetailsView.open(context, activity.dealId!)
                    : activity.partnerId != null
                    ? () =>
                          PartnerDetailsView.open(context, activity.partnerId!)
                    : null,
              ),
              const Divider(height: 1),
            ],
        ],
      ],
    );
  }
}

class _BrandHeader extends StatelessWidget {
  const _BrandHeader();
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Semantics(
          label: 'Analytix Connect',
          child: ExcludeSemantics(
            child: Row(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (final height in [12.0, 22.0, 32.0])
                      Container(
                        width: 8,
                        height: height,
                        margin: const EdgeInsets.only(right: 4),
                        decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Analytix',
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -.8,
                          ),
                        ),
                        Text(
                          'C O N N E C T',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: AppColor.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(width: 20),
      const CircleAvatar(
        radius: 23,
        backgroundColor: AppColor.mintSurface,
        child: Icon(Icons.person_outline_rounded, color: AppColor.primaryDark),
      ),
    ],
  );
}
