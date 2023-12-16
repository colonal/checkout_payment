part of 'register_cubit.dart';

sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterSuccessState extends RegisterState {}

final class RegisterErrorState extends RegisterState {
  final String message;

  RegisterErrorState(this.message);
}

final class RegisterLoadingState extends RegisterState {}
