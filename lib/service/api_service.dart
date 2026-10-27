import '../features/deals/model/deal_model.dart';
import '../features/home/model/activity_model.dart';
import '../features/partners/model/partner_model.dart';
import 'mock_data.dart';

/// Shared data boundary; replace fixture access here when the API is available.
class ApiService {
  ApiService({this.delay = const Duration(milliseconds: 250)});
  final Duration delay;
  bool get isSampleData => true;

  Future<List<DealModel>> fetchDeals() async {
    await Future<void>.delayed(delay);
    return MockData.deals;
  }

  Future<DealModel?> fetchDealById(String id) async {
    final deals = await fetchDeals();
    for (final deal in deals) {
      if (deal.id == id) return deal;
    }
    return null;
  }

  Future<List<PartnerModel>> fetchPartners() async {
    await Future<void>.delayed(delay);
    return List.unmodifiable(MockData.partners);
  }

  Future<PartnerModel?> fetchPartnerById(String id) async {
    final partners = await fetchPartners();
    for (final partner in partners) {
      if (partner.id == id) return partner;
    }
    return null;
  }

  Future<List<ActivityModel>> fetchActivities() async {
    await Future<void>.delayed(delay);
    return MockData.activities;
  }
}
