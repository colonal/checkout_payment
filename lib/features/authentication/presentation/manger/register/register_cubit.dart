import '../../../data/model/register_model.dart';
import '../../../../checkout/data/model/customers_input/customers_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../checkout/data/repos/checkout_repo.dart';
import '../../../data/repo/auth_repo.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepo _authRepo;
  final CheckoutRepo _checkoutRepo;
  final FlutterSecureStorage _secureStorage;
  RegisterCubit(
      {required AuthRepo authRepo,
      required CheckoutRepo checkoutRepo,
      required FlutterSecureStorage secureStorage})
      : _authRepo = authRepo,
        _secureStorage = secureStorage,
        _checkoutRepo = checkoutRepo,
        super(RegisterInitial());

  factory RegisterCubit.get(context) => BlocProvider.of<RegisterCubit>(context);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmationPasswordController =
      TextEditingController();

  void register() async {
    emit(RegisterLoadingState());
    final either = await _authRepo.register(
      RegisterModel(
        name: nameController.text,
        phone: phoneController.text,
        email: emailController.text,
        password: passwordController.text,
        confirmation: confirmationPasswordController.text,
      ),
    );

    either.fold((l) {
      emit(RegisterErrorState(l.message));
    }, (token) async {
      final either = await _checkoutRepo.createCustomers(
        customerInputModel: CustomerInputModel(
            name: nameController.text,
            email: emailController.text,
            phone: phoneController.text),
      );
      either.fold((l) {
        emit(RegisterErrorState(l.message));
      }, (r) async {
        await _secureStorage.write(key: "token", value: token);
        await _secureStorage.write(key: "customerId", value: r.id);
        emit(RegisterSuccessState());
      });
    });
  }
}
