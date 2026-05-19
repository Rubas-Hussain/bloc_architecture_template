// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
//
// part 'home_event.dart';
// part 'home_state.dart';
//
// class HomeBloc extends Bloc<HomeEvent, HomeState> {
//   HomeBloc() : super(const HomeCounterState(counter: 0)) {
//
//     on<IncrementEvent>((event, emit) {
//       emit(HomeCounterState(counter: state.counter + 1));
//     });
//   }
// }

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_todo_app/data/network/api_status.dart';
import 'package:bloc_todo_app/features/home/domain/use_case/home_use_case.dart';
import 'package:bloc_todo_app/models/post_models/post_model.dart';
import 'package:http/http.dart' as http;

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUseCase homeUseCase;

  HomeBloc(this.homeUseCase) : super(HomeState()) {
    on<IncrementEvent>(_increment);
    on<DecrementEvent>(_decrement);
    on<GetPostsEvent>(_getPosts);
    on<GetProductsEvent>(_getProducts);
  }

  void _increment(IncrementEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(counter: state.counter + 1));
  }

  void _decrement(DecrementEvent event, Emitter<HomeState> emit) {
    if (state.counter <= 0) return;
    emit(state.copyWith(counter: state.counter - 1));
  }

  Future<void> _getPosts(GetPostsEvent event, Emitter<HomeState> emit) async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: {'content-type': 'application/json'},
    );
    final decodedResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      List<PostModel> posts = [];
      for (var i in decodedResponse) {
        posts.add(PostModel.fromJson(i));
      }
      emit(state.copyWith(posts: posts));
    }
  }

  Future<void> _getProducts(
    GetProductsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(apiStatus: ApiStatus.idle));

    try {
      final products = await homeUseCase();
      if (products.success) {
        emit(state.copyWith(products: products, apiStatus: ApiStatus.success));
      } else {
        emit(state.copyWith(products: products, apiStatus: ApiStatus.error,apiMessage: products.message));
      }
    } catch (e, s) {
      print('$e, $s');
      emit(state.copyWith(apiStatus: ApiStatus.error));
    }
  }
}
