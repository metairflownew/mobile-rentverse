import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:rentverse/features/bookings/domain/entity/res/booking_list_entity.dart';
import 'package:rentverse/features/bookings/domain/usecase/get_bookings_usecase.dart';
import 'package:rentverse/features/midtrans/domain/entity/midtrans_entity.dart';
import 'package:rentverse/features/midtrans/domain/usecase/pay_invoice_usecase.dart';
import 'package:rentverse/role/tenant/presentation/cubit/rent/state.dart';

class RentCubit extends Cubit<RentState> {
  RentCubit(this._getBookingsUseCase, this._payInvoiceUseCase)
    : super(const RentState());

  final GetBookingsUseCase _getBookingsUseCase;
  final PayInvoiceUseCase _payInvoiceUseCase;

  Future<void> load({int limit = 10, String? cursor}) async {
    emit(state.copyWith(isLoading: true, resetError: true));
    try {
      final res = await _getBookingsUseCase(
        param: GetBookingsParams(limit: limit, cursor: cursor),
      );

      final pending = _filterByStatus(res.items, 'PENDING_PAYMENT');
      final active = _filterByStatus(res.items, 'ACTIVE');
      final completed = _filterByStatus(res.items, 'COMPLETED');
      final cancelled = _filterByStatus(res.items, 'CANCELLED');

      final paymentPending = _filterByPaymentStatus(res.items, 'PENDING');
      final paymentPaid = _filterByPaymentStatus(res.items, 'PAID');
      final paymentOverdue = _filterByPaymentStatus(res.items, 'OVERDUE');
      final paymentCanceled = _filterByPaymentStatus(res.items, 'CANCELED');

      emit(
        state.copyWith(
          isLoading: false,
          pendingPayment: pending,
          active: active,
          completed: completed,
          cancelled: cancelled,
          paymentPending: paymentPending,
          paymentPaid: paymentPaid,
          paymentOverdue: paymentOverdue,
          paymentCanceled: paymentCanceled,
          hasMore: res.meta.hasMore,
          nextCursor: res.meta.nextCursor,
        ),
      );
    } catch (e) {
      Logger().e('Load bookings failed', error: e);
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<MidtransPaymentEntity?> payInvoice(String invoiceId) async {
    emit(state.copyWith(isPaying: true, resetError: true));
    try {
      final res = await _payInvoiceUseCase(param: invoiceId);
      emit(state.copyWith(isPaying: false));
      return res;
    } catch (e) {
      Logger().e('Pay invoice failed', error: e);
      emit(state.copyWith(isPaying: false, error: e.toString()));
      return null;
    }
  }

  List<BookingListItemEntity> _filterByStatus(
    List<BookingListItemEntity> items,
    String status,
  ) {
    return items.where((e) => e.status == status).toList();
  }

  List<BookingListItemEntity> _filterByPaymentStatus(
    List<BookingListItemEntity> items,
    String status,
  ) {
    return items.where((e) => e.payment.status == status).toList();
  }
}
