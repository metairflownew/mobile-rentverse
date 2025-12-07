class RequestBookingEntity {
  final String propertyId;
  final int billingPeriodId;
  final DateTime startDate;

  const RequestBookingEntity({
    required this.propertyId,
    required this.billingPeriodId,
    required this.startDate,
  });
}
