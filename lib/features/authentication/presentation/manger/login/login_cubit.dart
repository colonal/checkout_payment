import 'dart:developer';

import '../../../data/model/login_model.dart';
import '../../../data/repo/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo _authRepo;
  final FlutterSecureStorage _secureStorage;
  LoginCubit(
      {required AuthRepo authRepo, required FlutterSecureStorage secureStorage})
      : _authRepo = authRepo,
        _secureStorage = secureStorage,
        super(LoginInitial());

  factory LoginCubit.get(context) => BlocProvider.of<LoginCubit>(context);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future login() async {
    emit(LoginLoadingState());
    final either = await _authRepo.login(LoginModel(
        email: emailController.text, password: passwordController.text));
    either.fold((l) {
      emit(LoginErrorState(l.message));
    }, (r) async {
      log("token: $r");
      await _secureStorage.write(key: "token", value: r);
      emit(LoginSuccessState());
    });
  }
}
