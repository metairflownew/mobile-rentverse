import 'package:rentverse/features/rental/domain/entity/rent_references_entity_response.dart';
import 'package:rentverse/features/rental/domain/repository/rental_repository.dart';

class GetRentReferencesUseCase {
  final RentalRepository _repository;

  GetRentReferencesUseCase(this._repository);

  Future<RentReferencesEntity> call() {
    return _repository.getReferences();
  }
}
