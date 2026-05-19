import 'package:equatable/equatable.dart';
// part of 'home_bloc.dart';
//
// @immutable
// sealed class HomeEvent {}


abstract class HomeEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class IncrementEvent extends HomeEvent{}

class DecrementEvent extends HomeEvent{}

class GetPostsEvent extends HomeEvent{}

class GetProductsEvent extends HomeEvent{}
