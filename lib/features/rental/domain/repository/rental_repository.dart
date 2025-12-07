import 'package:rentverse/features/rental/domain/entity/rent_references_entity_response.dart';

abstract class RentalRepository {
  Future<RentReferencesEntity> getReferences();
}
