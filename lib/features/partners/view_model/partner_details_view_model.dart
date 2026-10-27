import '../../../core/view_model/async_view_model.dart';
import '../../../service/api_service.dart';
import '../../deals/model/deal_model.dart';
import '../model/partner_model.dart';

class PartnerDetailsViewModel extends AsyncViewModel {
  PartnerDetailsViewModel(this._service, this.partnerId);
  final ApiService _service;
  final String partnerId;
  PartnerModel? _partner;
  List<DealModel> _deals = const [];

  PartnerModel? get partner => _partner;
  List<DealModel> get deals => _deals;

  Future<void> loadPartner() => runLoad(() async {
    final partner = await _service.fetchPartnerById(partnerId);
    final deals = partner == null ? <DealModel>[] : await _service.fetchDeals();
    _partner = partner;
    _deals = List.unmodifiable(
      deals.where((deal) => deal.partnerId == partnerId),
    );
  }, failureMessage: 'We could not load this company. Please try again.');
}
