import 'dart:developer';

import '../manger/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widget/custom_button.dart';
import '../../../checkout/presentation/view/my_card_view.dart';
import 'login_form_widget.dart';
import 'login_logo_widget.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const MyCardView()),
            (_) => false,
          );
        } else if (state is LoginErrorState) {
          log("LoginFailure", error: state.message);
          SnackBar snackBar = SnackBar(content: Text(state.message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        final cubit = LoginCubit.get(context);
        return SafeArea(
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: LoginLogoWidget(),
              ),
              const SliverToBoxAdapter(
                child: LoginFormWidget(),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: CustomButton(
                        text: "Login",
                        isLoading: state is LoginLoadingState,
                        onTap: () {
                          if (cubit.formKey.currentState?.validate() ?? false) {
                            cubit.formKey.currentState!.save();
                            cubit.login();
                          }
                        }),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
