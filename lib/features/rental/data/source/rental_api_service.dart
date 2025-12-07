import 'package:rentverse/core/network/dio_client.dart';
import 'package:rentverse/features/rental/data/models/rent_references_response_model.dart';

abstract class RentalApiService {
  Future<RentReferencesResponseModel> getReferences();
}

class RentalApiServiceImpl implements RentalApiService {
  final DioClient _dioClient;

  RentalApiServiceImpl(this._dioClient);

  @override
  Future<RentReferencesResponseModel> getReferences() async {
    try {
      final response = await _dioClient.get('/rental/references');
      return RentReferencesResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      rethrow;
    }
  }
}
