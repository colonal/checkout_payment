import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widget/custom_button.dart';
import '../../../checkout/presentation/view/my_card_view.dart';
import '../manger/register/register_cubit.dart';
import 'register_form_widget.dart';
import 'register_logo_widget.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const MyCardView()),
            (_) => false,
          );
        } else if (state is RegisterErrorState) {
          log("RegisterFailure", error: state.message);
          SnackBar snackBar = SnackBar(content: Text(state.message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        RegisterCubit cubit = RegisterCubit.get(context);
        return CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: RegisterLogoWidget(),
            ),
            const SliverToBoxAdapter(
              child: RegisterFormWidget(),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: CustomButton(
                    text: "Register",
                    isLoading: state is RegisterLoadingState,
                    onTap: () {
                      if (cubit.formKey.currentState?.validate() ?? false) {
                        cubit.formKey.currentState!.save();
                        cubit.register();
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
