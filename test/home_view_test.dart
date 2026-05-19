import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_todo_app/data/network/api_status.dart';
import 'package:bloc_todo_app/features/home/data/models/product_model.dart';
import 'package:bloc_todo_app/features/home/domain/entities/product.dart';
import 'package:bloc_todo_app/features/home/domain/use_case/home_use_case.dart';
import 'package:bloc_todo_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:bloc_todo_app/features/home/presentation/bloc/home_event.dart';
import 'package:bloc_todo_app/features/home/presentation/bloc/home_state.dart';
import 'package:bloc_todo_app/services/service_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeUseCase extends Mock implements HomeUseCase {}

void main() {
  final fakeProductsResponse = ServiceResponse.success(
    message: 'Success',
    data: [
      Product(
        title: 'iPhone',
        id: 123,
        description: 'ASDASDA',
        category: 'Aasdasd',
        price: 123,
        discountPercentage: 123,
        rating: 123,
        stock: 123,
        tags: [],
        brand: 'adsas',
        sku: 'asd',
        weight: 123,
        dimensions: Dimensions(width: 123, height: 123, depth: 123),
        warrantyInformation: 'asd',
        shippingInformation: 'asd',
        availabilityStatus: 'das',
        reviews: [],
        returnPolicy: 'asd',
        minimumOrderQuantity: 123,
        meta: Meta(createdAt: '1', updatedAt: '1', barcode: '1', qrCode: '1'),
        images: [],
        thumbnail: 'asda',
      ),
    ],
  );
  late MockHomeUseCase mockHomeUseCase;

  setUp(() {
    mockHomeUseCase = MockHomeUseCase();
  });

  blocTest<HomeBloc, HomeState>(
    'emits loading then success',

    build: () {
      when(
        () => mockHomeUseCase(),
      ).thenAnswer((_) async => fakeProductsResponse);

      return HomeBloc(mockHomeUseCase);
    },

    act: (bloc) => bloc.add(GetProductsEvent()),

    expect: () => [
      HomeState(apiStatus: ApiStatus.idle),
      HomeState(apiStatus: ApiStatus.success),
    ],
  );
}
