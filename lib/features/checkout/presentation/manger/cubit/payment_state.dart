part of 'payment_cubit.dart';

sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class PaymentLoading extends PaymentState {}

final class Payment extends PaymentState {}

final class PaymentFailure extends PaymentState {
  final String message;

  PaymentFailure({required this.message});
}
