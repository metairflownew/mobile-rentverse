import 'package:rentverse/core/usecase/usecase.dart';
import 'package:rentverse/features/auth/domain/repository/auth_repository.dart';

class LogoutUseCase implements UseCase<void, void> {
  final AuthRepository _repo;

  LogoutUseCase(this._repo);

  @override
  Future<void> call({void param}) async {
    await _repo.logout();
  }
}
