import 'package:rentverse/features/bookings/domain/entity/res/booking_list_entity.dart';

class RentState {
  final bool isLoading;
  final bool isPaying;
  final String? error;
  final List<BookingListItemEntity> pendingPayment;
  final List<BookingListItemEntity> active;
  final List<BookingListItemEntity> completed;
  final List<BookingListItemEntity> cancelled;
  final List<BookingListItemEntity> paymentPending;
  final List<BookingListItemEntity> paymentPaid;
  final List<BookingListItemEntity> paymentOverdue;
  final List<BookingListItemEntity> paymentCanceled;
  final bool hasMore;
  final String? nextCursor;

  const RentState({
    this.isLoading = false,
    this.isPaying = false,
    this.error,
    this.pendingPayment = const [],
    this.active = const [],
    this.completed = const [],
    this.cancelled = const [],
    this.paymentPending = const [],
    this.paymentPaid = const [],
    this.paymentOverdue = const [],
    this.paymentCanceled = const [],
    this.hasMore = false,
    this.nextCursor,
  });

  RentState copyWith({
    bool? isLoading,
    bool? isPaying,
    String? error,
    List<BookingListItemEntity>? pendingPayment,
    List<BookingListItemEntity>? active,
    List<BookingListItemEntity>? completed,
    List<BookingListItemEntity>? cancelled,
    List<BookingListItemEntity>? paymentPending,
    List<BookingListItemEntity>? paymentPaid,
    List<BookingListItemEntity>? paymentOverdue,
    List<BookingListItemEntity>? paymentCanceled,
    bool? hasMore,
    String? nextCursor,
    bool resetError = false,
  }) {
    return RentState(
      isLoading: isLoading ?? this.isLoading,
      isPaying: isPaying ?? this.isPaying,
      error: resetError ? null : error ?? this.error,
      pendingPayment: pendingPayment ?? this.pendingPayment,
      active: active ?? this.active,
      completed: completed ?? this.completed,
      cancelled: cancelled ?? this.cancelled,
      paymentPending: paymentPending ?? this.paymentPending,
      paymentPaid: paymentPaid ?? this.paymentPaid,
      paymentOverdue: paymentOverdue ?? this.paymentOverdue,
      paymentCanceled: paymentCanceled ?? this.paymentCanceled,
      hasMore: hasMore ?? this.hasMore,
      nextCursor: nextCursor ?? this.nextCursor,
    );
  }
}
