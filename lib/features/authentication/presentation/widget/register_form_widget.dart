import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widget/custom_app_text_form_field.dart';
import '../manger/register/register_cubit.dart';

class RegisterFormWidget extends StatelessWidget {
  const RegisterFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        RegisterCubit cubit = RegisterCubit.get(context);
        return Form(
          key: cubit.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Register",
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 40),
                Text(
                  "Name",
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                CustomAppTextFormField(
                  controller: cubit.nameController,
                  hintText: "Name",
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text?.isEmpty ?? false) {
                      return "The field required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                Text(
                  "Phone",
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                CustomAppTextFormField(
                  controller: cubit.phoneController,
                  hintText: "Phone",
                  keyboardType: TextInputType.phone,
                  validator: (text) {
                    if (text?.isEmpty ?? false) {
                      return "The field required";
                    } else if ((text?.length ?? 0) == 0) {
                      return "Wrong phone number";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                Text(
                  "Email",
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                CustomAppTextFormField(
                  controller: cubit.emailController,
                  hintText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text?.isEmpty ?? false) {
                      return "The field required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                Text(
                  "Password",
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                CustomAppTextFormField(
                  controller: cubit.passwordController,
                  hintText: "Password",
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (text) {
                    if (text?.isEmpty ?? false) {
                      return "The field required";
                    } else if ((text?.length ?? 0) < 6) {
                      return "The password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                Text(
                  "Confirmation password",
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                CustomAppTextFormField(
                  controller: cubit.confirmationPasswordController,
                  hintText: "Confirmation password",
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  validator: (text) {
                    if (text?.isEmpty ?? false) {
                      return "The field required";
                    } else if (cubit.passwordController.text !=
                        cubit.confirmationPasswordController.text) {
                      return "Not Matching";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
