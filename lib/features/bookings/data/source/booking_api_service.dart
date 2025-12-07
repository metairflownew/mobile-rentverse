import 'package:rentverse/core/network/dio_client.dart';
import 'package:rentverse/features/bookings/data/models/booking_response_model.dart';
import 'package:rentverse/features/bookings/data/models/request_booking_model.dart';

abstract class BookingApiService {
  Future<BookingResponseModel> createBooking(RequestBookingModel request);
}

class BookingApiServiceImpl implements BookingApiService {
  final DioClient _dioClient;

  BookingApiServiceImpl(this._dioClient);

  @override
  Future<BookingResponseModel> createBooking(
    RequestBookingModel request,
  ) async {
    try {
      final response = await _dioClient.post(
        '/bookings',
        data: request.toJson(),
      );
      return BookingResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      rethrow;
    }
  }
}
