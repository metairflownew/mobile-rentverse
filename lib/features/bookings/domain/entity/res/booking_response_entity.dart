class BookingResponseEntity {
  final String bookingId;
  final String invoiceId;
  final String status;
  final int amount;
  final String? message;

  const BookingResponseEntity({
    required this.bookingId,
    required this.invoiceId,
    required this.status,
    required this.amount,
    this.message,
  });
}
