import '../../../../core/utils/stripe_service.dart';
import '../manger/register/register_cubit.dart';
import '../widget/register_view_body.dart';
import '../../../checkout/data/repos/checkout_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/auth_service.dart';
import '../../data/repo/auth_repo_impl.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(
        authRepo:
            AuthRepoImpl(authService: AuthService(apiService: ApiService())),
        checkoutRepo:
            CheckoutRepoImpl(service: StripeService(apiService: ApiService())),
        secureStorage: const FlutterSecureStorage(
          aOptions: AndroidOptions(
            encryptedSharedPreferences: true,
          ),
        ),
      ),
      child: const Scaffold(
        body: RegisterViewBody(),
      ),
    );
  }
}
