import '../../../core/view_model/async_view_model.dart';
import '../../../service/api_service.dart';
import '../../partners/model/partner_model.dart';
import '../model/deal_model.dart';

class DealDetailsViewModel extends AsyncViewModel {
  DealDetailsViewModel(this._service, this.dealId);
  final ApiService _service;
  final String dealId;
  DealModel? _deal;
  PartnerModel? _partner;

  DealModel? get deal => _deal;
  PartnerModel? get partner => _partner;

  Future<void> loadDeal() => runLoad(() async {
    final deal = await _service.fetchDealById(dealId);
    final partner = deal?.partnerId == null
        ? null
        : await _service.fetchPartnerById(deal!.partnerId!);
    _deal = deal;
    _partner = partner;
  }, failureMessage: 'We could not load this deal. Please try again.');
}
