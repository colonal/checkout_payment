import '../../../../core/errors/failures.dart';
import '../../../../core/utils/stripe_service.dart';
import '../model/customer_model/customer_model.dart';
import '../model/customers_input/customers_input.dart';
import '../model/payment_intent_input_model/payment_intent_input_model.dart';
import 'checkout_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class CheckoutRepoImpl extends CheckoutRepo {
  final StripeService _service;

  CheckoutRepoImpl({required StripeService service}) : _service = service;

  @override
  Future<Either<Failure, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    try {
      await _service.makePayment(paymentIntentInputModel);
      return right(null);
    } on StripeException catch (e) {
      return left(
          ServerFailure(message: e.error.localizedMessage ?? e.toString()));
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CustomerModel>> createCustomers(
      {required CustomerInputModel customerInputModel}) async {
    try {
      final data = await _service.createCustomers(customerInputModel);
      return right(data);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
