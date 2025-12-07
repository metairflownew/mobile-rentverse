import 'package:rentverse/features/bookings/domain/entity/req/request_booking_entity.dart';

class RequestBookingModel {
  final String propertyId;
  final int billingPeriodId;
  final DateTime startDate;

  const RequestBookingModel({
    required this.propertyId,
    required this.billingPeriodId,
    required this.startDate,
  });

  factory RequestBookingModel.fromEntity(RequestBookingEntity entity) {
    return RequestBookingModel(
      propertyId: entity.propertyId,
      billingPeriodId: entity.billingPeriodId,
      startDate: entity.startDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'propertyId': propertyId,
      'billingPeriodId': billingPeriodId,
      'startDate': startDate.toUtc().toIso8601String(),
    };
  }
}
