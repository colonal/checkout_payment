import '../model/payment_intent_input_model/payment_intent_input_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../model/customer_model/customer_model.dart';
import '../model/customers_input/customers_input.dart';

abstract class CheckoutRepo {
  Future<Either<Failure, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel});

  Future<Either<Failure, CustomerModel>> createCustomers(
      {required CustomerInputModel customerInputModel});
}
