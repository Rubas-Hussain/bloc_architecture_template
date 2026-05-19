import '../../../../configs/api_constants/api_endpoints.dart';
import '../../../../data/network/api_types.dart';
import '../../../../data/network/dio_api_client.dart';

class HomeRemoteDataSource {
  static final DioApiClient _client = DioApiClient();


  Future<Map<String, dynamic>> getProducts() async {
    final response = await _client.callApi(
      endPoint: ApiEndpoints.productsEndPoint,
      method: ApiHTTPMethod.get,
    );

    if (response is Map<String, dynamic>) {
      return response;
    } else {
      throw response;
    }
  }
}