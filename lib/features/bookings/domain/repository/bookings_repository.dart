import 'package:rentverse/features/bookings/domain/entity/req/request_booking_entity.dart';
import 'package:rentverse/features/bookings/domain/entity/res/booking_response_entity.dart';

abstract class BookingsRepository {
  Future<BookingResponseEntity> createBooking(RequestBookingEntity request);
}
