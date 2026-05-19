import '../../../../services/service_response.dart';
import '../entities/product.dart';

abstract class HomeRepository{
  Future<ServiceResponse<List<Product>>> getProducts();
}