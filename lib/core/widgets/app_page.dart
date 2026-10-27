import 'package:flutter/material.dart';

class AppPage extends StatelessWidget {
  const AppPage({
    super.key,
    required this.children,
    required this.onRefresh,
    this.storageKey,
  });
  final List<Widget> children;
  final Future<void> Function() onRefresh;
  final String? storageKey;

  @override
  Widget build(BuildContext context) => SafeArea(
    bottom: false,
    child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 760),
        child: RefreshIndicator(
          onRefresh: onRefresh,
          child: ListView(
            key: storageKey == null
                ? null
                : PageStorageKey<String>(storageKey!),
            physics: const AlwaysScrollableScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 36),
            children: children,
          ),
        ),
      ),
    ),
  );
}
