import 'package:flutter/foundation.dart';

/// A request may finish after its route is disposed.
abstract class AsyncViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool _hasLoaded = false;
  bool _disposed = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  bool get hasLoaded => _hasLoaded;
  String? get errorMessage => _errorMessage;

  @protected
  Future<void> runLoad(
    Future<void> Function() action, {
    required String failureMessage,
  }) async {
    if (_isLoading || _disposed) return;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      await action();
      _hasLoaded = true;
    } catch (_) {
      _errorMessage = failureMessage;
    } finally {
      _isLoading = false;
      if (!_disposed) notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
