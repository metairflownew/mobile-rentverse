import 'package:rentverse/features/bookings/data/models/request_booking_model.dart';
import 'package:rentverse/features/bookings/data/source/booking_api_service.dart';
import 'package:rentverse/features/bookings/domain/entity/req/request_booking_entity.dart';
import 'package:rentverse/features/bookings/domain/entity/res/booking_response_entity.dart';
import 'package:rentverse/features/bookings/domain/repository/bookings_repository.dart';

class BookingsRepositoryImpl implements BookingsRepository {
  final BookingApiService _apiService;

  BookingsRepositoryImpl(this._apiService);

  @override
  Future<BookingResponseEntity> createBooking(
    RequestBookingEntity request,
  ) async {
    final model = RequestBookingModel.fromEntity(request);
    final response = await _apiService.createBooking(model);
    return response.toEntity();
  }
}
