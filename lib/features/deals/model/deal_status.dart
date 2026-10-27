enum DealStatus {
  newLead('New'),
  proposal('Proposal'),
  negotiation('Negotiation');

  const DealStatus(this.label);
  final String label;

  static DealStatus fromApi(String value) =>
      switch (value.trim().toLowerCase()) {
        'new' => DealStatus.newLead,
        'proposal' => DealStatus.proposal,
        'negotiation' => DealStatus.negotiation,
        _ => throw FormatException('Unsupported deal status: $value'),
      };
}
