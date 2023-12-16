import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/auth_service.dart';
import '../../data/repo/auth_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../manger/login/login_cubit.dart';
import '../widget/login_view_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        authRepo:
            AuthRepoImpl(authService: AuthService(apiService: ApiService())),
        secureStorage: const FlutterSecureStorage(
            aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        )),
      ),
      child: const Scaffold(
        body: LoginViewBody(),
      ),
    );
  }
}
