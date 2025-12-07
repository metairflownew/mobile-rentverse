import 'package:rentverse/features/bookings/domain/entity/res/booking_response_entity.dart';
import 'package:rentverse/features/rental/domain/entity/rent_references_entity_response.dart';

class BookingState {
  final bool isLoading;
  final bool isBillingPeriodsLoading;
  final String? error;
  final BookingResponseEntity? result;
  final int billingPeriodId;
  final List<BillingPeriodEntity> billingPeriods;
  final DateTime startDate;

  const BookingState({
    required this.isLoading,
    required this.isBillingPeriodsLoading,
    this.error,
    this.result,
    required this.billingPeriodId,
    required this.billingPeriods,
    required this.startDate,
  });

  factory BookingState.initial() => BookingState(
    isLoading: false,
    isBillingPeriodsLoading: false,
    error: null,
    result: null,
    billingPeriodId: 1,
    billingPeriods: const [],
    startDate: DateTime.now(),
  );

  BookingState copyWith({
    bool? isLoading,
    bool? isBillingPeriodsLoading,
    String? error,
    BookingResponseEntity? result,
    int? billingPeriodId,
    List<BillingPeriodEntity>? billingPeriods,
    DateTime? startDate,
    bool resetResult = false,
    bool resetError = false,
  }) {
    return BookingState(
      isLoading: isLoading ?? this.isLoading,
      isBillingPeriodsLoading:
          isBillingPeriodsLoading ?? this.isBillingPeriodsLoading,
      error: resetError ? null : error ?? this.error,
      result: resetResult ? null : result ?? this.result,
      billingPeriodId: billingPeriodId ?? this.billingPeriodId,
      billingPeriods: billingPeriods ?? this.billingPeriods,
      startDate: startDate ?? this.startDate,
    );
  }
}
