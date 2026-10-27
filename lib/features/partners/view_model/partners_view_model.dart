import '../../../core/view_model/async_view_model.dart';
import '../../../service/api_service.dart';
import '../model/partner_model.dart';

class PartnersViewModel extends AsyncViewModel {
  PartnersViewModel(this._service);
  final ApiService _service;
  List<PartnerModel> _partners = const [];
  String _searchQuery = '';

  String get searchQuery => _searchQuery;
  int get totalCount => _partners.length;
  List<PartnerModel> get filteredPartners {
    final query = _searchQuery.trim().toLowerCase();
    return List.unmodifiable(
      _partners.where(
        (partner) => '${partner.name} ${partner.description ?? ''}'
            .toLowerCase()
            .contains(query),
      ),
    );
  }

  void setSearchQuery(String value) {
    if (value == _searchQuery) return;
    _searchQuery = value;
    notifyListeners();
  }

  Future<void> loadPartners() => runLoad(() async {
    _partners = List.unmodifiable(await _service.fetchPartners());
  }, failureMessage: 'We could not load our companies. Please try again.');
}
