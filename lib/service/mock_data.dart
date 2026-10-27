import '../features/deals/model/deal_model.dart';
import '../features/deals/model/deal_status.dart';
import '../features/home/model/activity_model.dart';
import '../features/partners/model/partner_model.dart';

/// Illustrative records only. Replace data access in ApiService for integration.
abstract final class MockData {
  static const partners = [
    PartnerModel(
      id: 'analytix-tech',
      name: 'Analytix Tech',
      description:
          'Technology that moves business forward. Explore digital '
          'products, software solutions, and opportunities to build smarter.',
    ),
    PartnerModel(
      id: 'analytix-infra',
      name: 'Analytix Infra',
      description:
          'Building the foundations for what comes next. Discover '
          'infrastructure, development, and project opportunities.',
    ),
  ];

  static final deals = List<DealModel>.unmodifiable([
    DealModel(
      id: 'deal-001',
      title: 'Digital transformation',
      customerName: 'Riyadh Tech Solutions',
      status: DealStatus.newLead,
      partnerId: 'analytix-tech',
      description:
          'An introductory opportunity to modernize internal systems '
          'and create a connected digital workspace.',
      createdAt: DateTime(2026, 10, 25),
      updatedAt: DateTime(2026, 10, 27, 9),
    ),
    DealModel(
      id: 'deal-002',
      title: 'Commercial space development',
      customerName: 'Horizon Properties',
      status: DealStatus.proposal,
      partnerId: 'analytix-infra',
      description:
          'A proposal for planning and developing a new commercial '
          'space, with delivery requirements under review.',
      createdAt: DateTime(2026, 10, 20),
      updatedAt: DateTime(2026, 10, 26, 15),
    ),
    DealModel(
      id: 'deal-003',
      title: 'Customer experience platform',
      customerName: 'Nexa Retail',
      status: DealStatus.negotiation,
      partnerId: 'analytix-tech',
      description:
          'Discussing the scope and delivery of a customer platform '
          'that brings retail touchpoints together.',
      createdAt: DateTime(2026, 10, 14),
      updatedAt: DateTime(2026, 10, 26, 11),
    ),
    DealModel(
      id: 'deal-004',
      title: 'Smart warehouse project',
      customerName: 'Gulf Logistics',
      status: DealStatus.newLead,
      partnerId: 'analytix-infra',
      description:
          'An early-stage conversation about infrastructure for a '
          'more efficient warehouse operation.',
      createdAt: DateTime(2026, 10, 24),
    ),
    DealModel(
      id: 'deal-005',
      title: 'Business analytics suite',
      customerName: 'Crescent Enterprises',
      status: DealStatus.proposal,
      partnerId: 'analytix-tech',
      description:
          'A proposed reporting workspace to help teams understand '
          'performance and make informed decisions.',
      createdAt: DateTime(2026, 10, 18),
      updatedAt: DateTime(2026, 10, 25),
    ),
    DealModel(
      id: 'deal-006',
      title: 'Office infrastructure upgrade',
      customerName: 'Summit Group',
      status: DealStatus.negotiation,
      partnerId: 'analytix-infra',
      description:
          'Finalizing the requirements and scope of an office '
          'infrastructure improvement project.',
      createdAt: DateTime(2026, 10, 12),
      updatedAt: DateTime(2026, 10, 24),
    ),
  ]);

  static final activities = List<ActivityModel>.unmodifiable([
    ActivityModel(
      id: 'activity-001',
      title: 'A new opportunity',
      description: 'Riyadh Tech Solutions · Analytix Tech',
      occurredAt: DateTime(2026, 10, 27, 9),
      dealId: 'deal-001',
    ),
    ActivityModel(
      id: 'activity-002',
      title: 'Proposal ready for review',
      description: 'Horizon Properties · Analytix Infra',
      occurredAt: DateTime(2026, 10, 26, 15),
      dealId: 'deal-002',
    ),
    ActivityModel(
      id: 'activity-003',
      title: 'Moving the conversation forward',
      description: 'Nexa Retail · Negotiation',
      occurredAt: DateTime(2026, 10, 26, 11),
      dealId: 'deal-003',
    ),
  ]);
}
