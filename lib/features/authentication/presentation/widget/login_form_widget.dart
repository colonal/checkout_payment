import '../manger/login/login_cubit.dart';
import '../view/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widget/custom_app_text_form_field.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        LoginCubit cubit = LoginCubit.get(context);
        return Form(
          key: cubit.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Login",
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 40),
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
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  validator: (text) {
                    if (text?.isEmpty ?? false) {
                      return "The field required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const RegisterScreen()),
                    );
                  },
                  child: Text(
                    "create account now?",
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
