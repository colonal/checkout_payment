import 'dart:developer';

import '../../../data/model/payment_intent_input_model/payment_intent_input_model.dart';
import '../../../data/repos/checkout_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final CheckoutRepo _checkoutRepo;
  PaymentCubit({required CheckoutRepo checkoutRepo})
      : _checkoutRepo = checkoutRepo,
        super(PaymentInitial());

  factory PaymentCubit.get(context) => BlocProvider.of<PaymentCubit>(context);

  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    emit(PaymentLoading());
    final either = await _checkoutRepo.makePayment(
        paymentIntentInputModel: paymentIntentInputModel);

    either.fold((l) {
      emit(PaymentFailure(message: l.message));
    }, (r) {
      emit(Payment());
    });
  }

  @override
  void onChange(Change<PaymentState> change) {
    log(change.toString());
    super.onChange(change);
  }
}
