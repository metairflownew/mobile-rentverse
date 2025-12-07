import 'package:rentverse/features/bookings/domain/entity/res/booking_response_entity.dart';

class BookingResponseModel {
  final String bookingId;
  final String invoiceId;
  final String status;
  final int amount;
  final String? message;

  const BookingResponseModel({
    required this.bookingId,
    required this.invoiceId,
    required this.status,
    required this.amount,
    this.message,
  });

  factory BookingResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};
    return BookingResponseModel(
      bookingId: data['bookingId'] as String? ?? '',
      invoiceId: data['invoiceId'] as String? ?? '',
      status: data['status'] as String? ?? '',
      amount: (data['amount'] as num?)?.toInt() ?? 0,
      message: json['message'] as String?,
    );
  }

  BookingResponseEntity toEntity() {
    return BookingResponseEntity(
      bookingId: bookingId,
      invoiceId: invoiceId,
      status: status,
      amount: amount,
      message: message,
    );
  }
}
