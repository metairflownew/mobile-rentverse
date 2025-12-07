import 'package:rentverse/features/rental/data/source/rental_api_service.dart';
import 'package:rentverse/features/rental/domain/entity/rent_references_entity_response.dart';
import 'package:rentverse/features/rental/domain/repository/rental_repository.dart';

class RentalRepositoryImpl implements RentalRepository {
  final RentalApiService _apiService;

  RentalRepositoryImpl(this._apiService);

  @override
  Future<RentReferencesEntity> getReferences() async {
    final res = await _apiService.getReferences();
    return res.toEntity();
  }
}
