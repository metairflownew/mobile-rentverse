import '../entity/list_property_by_owner.dart';
import '../repository/property_repository.dart';

class GetLandlordPropertiesUseCase {
  final PropertyRepository _repository;

  GetLandlordPropertiesUseCase(this._repository);

  Future<ListPropertyByOwnerEntity> call({int? limit, String? cursor}) {
    return _repository.getLandlordProperties(limit: limit, cursor: cursor);
  }
}
