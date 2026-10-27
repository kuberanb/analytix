import '../../../core/view_model/async_view_model.dart';
import '../../../service/api_service.dart';
import '../../partners/model/partner_model.dart';
import '../model/deal_model.dart';
import '../model/deal_status.dart';

class DealsViewModel extends AsyncViewModel {
  DealsViewModel(this._service);
  final ApiService _service;
  List<DealModel> _deals = const [];
  Map<String, PartnerModel> _partners = const {};
  String _searchQuery = '';
  DealStatus? _selectedStatus;

  String get searchQuery => _searchQuery;
  DealStatus? get selectedStatus => _selectedStatus;
  int get totalCount => _deals.length;
  int countFor(DealStatus status) =>
      _deals.where((d) => d.status == status).length;

  String companyName(DealModel deal) =>
      _partners[deal.partnerId]?.name ?? 'Company not assigned';

  List<DealModel> get filteredDeals {
    final query = _searchQuery.trim().toLowerCase();
    return List.unmodifiable(
      _deals.where((deal) {
        final matchesStatus =
            _selectedStatus == null || deal.status == _selectedStatus;
        final searchable =
            '${deal.title} ${deal.customerName} ${companyName(deal)}'
                .toLowerCase();
        return matchesStatus && (query.isEmpty || searchable.contains(query));
      }),
    );
  }

  void setSearchQuery(String value) {
    if (value == _searchQuery) return;
    _searchQuery = value;
    notifyListeners();
  }

  void selectStatus(DealStatus? status) {
    if (_selectedStatus == status) return;
    _selectedStatus = status;
    notifyListeners();
  }

  void resetFilters({DealStatus? status}) {
    _searchQuery = '';
    _selectedStatus = status;
    notifyListeners();
  }

  Future<void> loadDeals() => runLoad(() async {
    final deals = await _service.fetchDeals();
    final partners = await _service.fetchPartners();
    _deals = List.unmodifiable(
      [...deals]..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
    );
    _partners = {for (final partner in partners) partner.id: partner};
  }, failureMessage: 'We could not load your deals. Please try again.');
}
