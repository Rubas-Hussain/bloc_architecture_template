import 'package:bloc_todo_app/services/service_response.dart';

import '../entities/product.dart';
import '../repository/home_repository.dart';

class HomeUseCase {
  final HomeRepository homeRepository;

  HomeUseCase(this.homeRepository);

  Future<ServiceResponse<List<Product>>> call() {
    return homeRepository.getProducts();
  }
}