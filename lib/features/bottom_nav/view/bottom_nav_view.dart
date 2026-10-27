import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/app_color.dart';
import '../../deals/model/deal_status.dart';
import '../../deals/view/deals_view.dart';
import '../../deals/view_model/deals_view_model.dart';
import '../../home/view/home_view.dart';
import '../../home/view_model/home_view_model.dart';
import '../../partners/view/partners_view.dart';
import '../view_model/bottom_nav_view_model.dart';

class BottomNavView extends StatelessWidget {
  const BottomNavView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BottomNavViewModel>();
    return Scaffold(
      body: IndexedStack(
        index: vm.selectedIndex,
        children: [
          HomeView(
            onOpenDeals: (DealStatus? status) {
              context.read<DealsViewModel>().resetFilters(status: status);
              vm.selectTab(1);
            },
            onOpenPartners: () => vm.selectTab(2),
          ),
          if (vm.hasVisited(1)) const DealsView() else const SizedBox.shrink(),
          if (vm.hasVisited(2))
            const PartnersView()
          else
            const SizedBox.shrink(),
        ],
      ),
      bottomNavigationBar: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColor.surface,
          border: Border(top: BorderSide(color: AppColor.border)),
        ),
        child: NavigationBar(
          selectedIndex: vm.selectedIndex,
          onDestinationSelected: (index) {
            FocusManager.instance.primaryFocus?.unfocus();
            final returningHome = index == 0 && vm.selectedIndex != 0;
            vm.selectTab(index);
            if (returningHome) context.read<HomeViewModel>().loadHome();
          },
          destinations: const [
            NavigationDestination(
              key: ValueKey('nav-home'),
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            NavigationDestination(
              key: ValueKey('nav-deals'),
              icon: Icon(Icons.work_outline_rounded),
              selectedIcon: Icon(Icons.work_rounded),
              label: 'Deals',
            ),
            NavigationDestination(
              key: ValueKey('nav-partners'),
              icon: Icon(Icons.business_outlined),
              selectedIcon: Icon(Icons.business_rounded),
              label: 'Partners',
            ),
          ],
        ),
      ),
    );
  }
}
