import '../../../core/view_model/async_view_model.dart';
import '../../../service/api_service.dart';
import '../../deals/model/deal_model.dart';
import '../../deals/model/deal_status.dart';
import '../../partners/model/partner_model.dart';
import '../model/activity_model.dart';

class HomeViewModel extends AsyncViewModel {
  HomeViewModel(this._service);
  final ApiService _service;
  List<DealModel> _deals = const [];
  List<PartnerModel> _partners = const [];
  List<ActivityModel> _activities = const [];

  int get totalDeals => _deals.length;
  int get totalPartners => _partners.length;
  List<PartnerModel> get partners => _partners;
  List<ActivityModel> get activities => _activities;
  int countFor(DealStatus status) =>
      _deals.where((d) => d.status == status).length;
  double proportionFor(DealStatus status) =>
      totalDeals == 0 ? 0 : countFor(status) / totalDeals;

  String get greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning,';
    if (hour < 17) return 'Good afternoon,';
    return 'Good evening,';
  }

  Future<void> loadHome() => runLoad(() async {
    final deals = await _service.fetchDeals();
    final partners = await _service.fetchPartners();
    final activities = await _service.fetchActivities();
    _deals = List.unmodifiable(deals);
    _partners = List.unmodifiable(partners);
    _activities = List.unmodifiable(
      [...activities]..sort((a, b) => b.occurredAt.compareTo(a.occurredAt)),
    );
  }, failureMessage: 'We could not load your dashboard. Please try again.');
}
