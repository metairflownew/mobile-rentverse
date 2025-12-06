import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentverse/features/auth/domain/usecase/get_local_user_usecase.dart';

import 'state.dart';

class GetUserCubit extends Cubit<GetUserState> {
  final GetLocalUserUseCase _getLocalUserUseCase;

  GetUserCubit(this._getLocalUserUseCase) : super(const GetUserState());

  Future<void> load() async {
    emit(state.copyWith(status: GetUserStatus.loading));
    try {
      final user = await _getLocalUserUseCase();
      if (user != null) {
        emit(state.copyWith(status: GetUserStatus.success, user: user));
      } else {
        emit(
          state.copyWith(
            status: GetUserStatus.failure,
            error: 'User not found',
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(status: GetUserStatus.failure, error: e.toString()));
    }
  }
}
