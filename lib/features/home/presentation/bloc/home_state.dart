// part of 'home_bloc.dart';
//
// @immutable
// sealed class HomeState {
//   final int counter;
//
//   const HomeState({required this.counter});
// }
//
// final class HomeInitial extends HomeState {
//   const HomeInitial({required int counter}) : super(counter: counter);
//
// }

import 'package:bloc_todo_app/features/home/domain/entities/product.dart';
import 'package:bloc_todo_app/services/service_response.dart';
import 'package:equatable/equatable.dart';
import '../../../../data/network/api_status.dart';
import '../../../../models/post_models/post_model.dart';

class HomeState extends Equatable {
  final int counter;
  final List<PostModel> posts;
  final ServiceResponse <List<Product>> products;
  final String apiMessage;
  final ApiStatus apiStatus;

  const HomeState({
    this.counter = 0,
    this.posts = const [],
    this.products = const ServiceResponse<List<Product>>(message: ''),
    this.apiMessage = '',
    this.apiStatus = ApiStatus.idle,
  });

  HomeState copyWith({int? counter, List<PostModel>? posts, ServiceResponse <List<
      Product>>? products, String? apiMessage,
    ApiStatus? apiStatus,}) {
    return HomeState(
        counter: counter ?? this.counter,
        posts: posts ?? this.posts,
        products: products ?? this.products,
        apiMessage: apiMessage ?? this.apiMessage,
        apiStatus: apiStatus ?? this.apiStatus
    );
  }

  @override
  List<Object?> get props =>
      [counter, posts, products, apiMessage,
        apiStatus,
      ];
}