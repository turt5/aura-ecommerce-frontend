import 'package:attira/features/register/view/widgets/_imagefield.dart';
import 'package:attira/features/register/view/widgets/_namefield.dart';
import 'package:attira/features/register/view/widgets/_phonefield.dart';
import 'package:attira/features/register/view/widgets/_signup_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../login/view/widgets/_email_field.dart';
import '../../../login/view/widgets/_password_field.dart';

class RegisterPage extends ConsumerWidget {
  RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: theme.surface,
      appBar: AppBar(
        backgroundColor: theme.surface,
        elevation: 1,
        title: Text('Create a new account',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: theme.primary,
            )),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: theme.primary,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              Text(
                'Profile Details',
                style: TextStyle(
                  color: theme.primary,
                ),
              ),
              const SizedBox(height: 10),
              NameField(
                  nameController: nameController,
                  hint: "Full name",
                  icon: Icons.person),
              const SizedBox(height: 10),
              ImageField(
                ref: ref,
              ),
              const SizedBox(height: 20),
              Text(
                'Account Details',
                style: TextStyle(
                  color: theme.primary,
                ),
              ),
              const SizedBox(height: 10),
              PhoneField(phoneController: phoneController),
              const SizedBox(height: 10),
              EmailField(emailController: emailController),
              const SizedBox(height: 10),
              PasswordField(passwordController: passwordController),
              const SizedBox(height: 20),
              SignUpButton(onPressed: () {})
            ],
          ),
        ),
      )),
    );
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
}
