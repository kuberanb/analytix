import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/app_theme.dart';
import 'features/bottom_nav/view/bottom_nav_view.dart';
import 'features/bottom_nav/view_model/bottom_nav_view_model.dart';
import 'features/deals/view_model/deals_view_model.dart';
import 'features/home/view_model/home_view_model.dart';
import 'features/partners/view_model/partners_view_model.dart';
import 'service/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.apiService});

  /// Allows a real service or a controlled test service to be injected.
  final ApiService? apiService;

  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      Provider<ApiService>(create: (_) => apiService ?? ApiService()),
      ChangeNotifierProvider(create: (_) => BottomNavViewModel()),
      ChangeNotifierProvider(
        create: (context) =>
            HomeViewModel(context.read<ApiService>())..loadHome(),
      ),
      ChangeNotifierProvider(
        create: (context) =>
            DealsViewModel(context.read<ApiService>())..loadDeals(),
      ),
      ChangeNotifierProvider(
        create: (context) =>
            PartnersViewModel(context.read<ApiService>())..loadPartners(),
      ),
    ],
    child: MaterialApp(
      title: 'Analytix Connect',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const BottomNavView(),
    ),
  );
}
