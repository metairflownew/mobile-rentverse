import 'package:rentverse/core/usecase/usecase.dart';
import 'package:rentverse/features/bookings/domain/entity/req/request_booking_entity.dart';
import 'package:rentverse/features/bookings/domain/entity/res/booking_response_entity.dart';
import 'package:rentverse/features/bookings/domain/repository/bookings_repository.dart';

class CreateBookingUseCase
    implements UseCase<BookingResponseEntity, RequestBookingEntity> {
  final BookingsRepository _repository;

  CreateBookingUseCase(this._repository);

  @override
  Future<BookingResponseEntity> call({RequestBookingEntity? param}) {
    if (param == null) {
      throw ArgumentError('RequestBookingEntity cannot be null');
    }
    return _repository.createBooking(param);
  }
}
