import 'package:flutter/material.dart';
import 'app_empty_state.dart';

class AppErrorState extends StatelessWidget {
  const AppErrorState({
    super.key,
    required this.message,
    required this.onRetry,
  });
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => AppEmptyState(
    icon: Icons.cloud_off_outlined,
    title: 'Let’s try that again',
    message: message,
    actionLabel: 'Try again',
    onAction: onRetry,
  );
}
