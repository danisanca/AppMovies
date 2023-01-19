import 'package:equatable/equatable.dart';

abstract class BlocBaseState extends Equatable {}

class IdleState extends BlocBaseState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends BlocBaseState {
  @override
  List<Object?> get props => [];
}

class SuccessState<T> extends BlocBaseState {
  final T? data;

  SuccessState({this.data});

  @override
  List<Object?> get props => [data];
}

class ErrorState<T> extends BlocBaseState {
  final T? error;

  ErrorState({this.error});

  @override
  List<Object?> get props => [error];
}
