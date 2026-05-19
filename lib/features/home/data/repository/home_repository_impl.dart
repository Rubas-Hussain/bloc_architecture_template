import '../../../../data/exceptions/app_exceptions.dart';
import '../../../../services/service_response.dart';
import '../../../../utils/error_utls.dart';
import '../../domain/entities/product.dart';
import '../models/product_model.dart';
import '../../domain/repository/home_repository.dart';
import '../data_source/home_remote_data_source.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepositoryImpl(this.homeRemoteDataSource);

  @override
  Future<ServiceResponse<List<Product>>> getProducts() async {
    try{
      final json = await homeRemoteDataSource.getProducts();

      final List productsJson = json['products'];
      final List<Product> products = productsJson.map((e) {
        final model = ProductModel.fromJson(e);

        return Product(
          id: model.id ?? 0,
          title: model.title ?? "",
          description: model.description ?? '',
          category: model.category ?? '',
          price: model.price ?? 0,
          discountPercentage: model.discountPercentage ?? 0,
          rating: model.rating ?? 0,
          stock: model.stock ?? 0,
          tags: model.tags ?? [],
          brand: model.brand ?? '',
          sku: model.sku ?? '',
          weight: model.weight ?? 0,

          dimensions: model.dimensions == null
              ? null
              : Dimensions(
            width: model.dimensions!.width ?? 0,
            height: model.dimensions!.height ?? 0,
            depth: model.dimensions!.depth ?? 0,
          ),

          warrantyInformation: model.warrantyInformation ?? '',
          shippingInformation: model.shippingInformation ?? '',
          availabilityStatus: model.availabilityStatus ?? '',

          reviews: model.reviews?.map((e) {
            return Reviews(
              rating: e.rating ?? 0,
              comment: e.comment ?? '',
              date: e.date ?? '',
              reviewerName: e.reviewerName ?? '',
              reviewerEmail: e.reviewerEmail ?? '',
            );
          }).toList() ??
              [],

          returnPolicy: model.returnPolicy ?? '',
          minimumOrderQuantity: model.minimumOrderQuantity ?? 0,

          meta: model.meta == null
              ? Meta(
            createdAt: '',
            updatedAt: '',
            barcode: '',
            qrCode: '',
          )
              : Meta(
            createdAt: model.meta!.createdAt ?? '',
            updatedAt: model.meta!.updatedAt ?? '',
            barcode: model.meta!.barcode ?? '',
            qrCode: model.meta!.qrCode ?? '',
          ),

          images: model.images ?? [],
          thumbnail: model.thumbnail ?? '',
        );
      }).toList();
      return ServiceResponse.success(
          data: products,
          message: "Success",
      );
    }catch(e){
      final message = ErrorUtils.messageFromException(e as AppException);
      return ServiceResponse.error(message: message);
    }
  }
}