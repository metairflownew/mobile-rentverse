import 'package:equatable/equatable.dart';
import 'package:rentverse/features/auth/domain/entity/user_entity.dart';

enum GetUserStatus { initial, loading, success, failure }

class GetUserState extends Equatable {
  final GetUserStatus status;
  final UserEntity? user;
  final String? error;

  const GetUserState({
    this.status = GetUserStatus.initial,
    this.user,
    this.error,
  });

  GetUserState copyWith({
    GetUserStatus? status,
    UserEntity? user,
    String? error,
  }) {
    return GetUserState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, user, error];
}
