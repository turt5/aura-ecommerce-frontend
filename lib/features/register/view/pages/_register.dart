import 'package:attira/features/register/controller/_account_provider.dart';
import 'package:attira/features/register/view/widgets/_customDialog.dart';
import 'package:attira/features/register/view/widgets/_imagefield.dart';
import 'package:attira/features/register/view/widgets/_namefield.dart';
import 'package:attira/features/register/view/widgets/_phonefield.dart';
import 'package:attira/features/register/view/widgets/_signup_button.dart';
import 'package:attira/services/user/firebase/_user_service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../login/view/widgets/_email_field.dart';
import '../../../login/view/widgets/_password_field.dart';

class RegisterPage extends ConsumerWidget {
  RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;
    final read = ref.watch(accountProvider);
    final write = ref.watch(accountProvider);

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
              SignUpButton(onPressed: () async {
                XFile? image = ref.watch(accountProvider).imageFile;
                String name = nameController.text;
                String phone = phoneController.text;
                String email = emailController.text;
                String password = passwordController.text;
                String role = 'user';

                if (image != null &&
                    name.isNotEmpty &&
                    phone.isNotEmpty &&
                    email.isNotEmpty &&
                    EmailValidator.validate(email) &&
                    password.isNotEmpty) {
                  if (password.length < 6) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: const Duration(seconds: 2),
                      backgroundColor: theme.primary,
                      content: Text(
                        'Password must be at least 6 characters long',
                        style: TextStyle(color: theme.onPrimary),
                      ),
                    ));
                  } else {
                    showCustomDialog(context);

                    bool response = await _registerUser(
                        context, name, image, phone, email, password, role);

                    if (response) {
                      write.setImageFile(null);
                      nameController.clear();
                      phoneController.clear();
                      emailController.clear();
                      passwordController.clear();
                      closeCustomDialog();
                      Navigator.pop(context);

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: theme.primary,
                        duration: const Duration(seconds: 2),
                        content: Text(
                          'Account created successfully. Use your email and password to login!',
                          style: TextStyle(color: theme.onPrimary),
                        ),
                      ));
                    } else {
                      closeCustomDialog();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: theme.primary,
                        content: Text(
                          'Something went error, please try again!',
                          style: TextStyle(color: theme.onPrimary),
                        ),
                      ));
                    }
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: theme.primary,
                    duration: const Duration(seconds: 2),
                    content: Text(
                      'Please fill-up all the data to create your account!',
                      style: TextStyle(color: theme.onPrimary),
                    ),
                  ));
                }
              })
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

  Future<bool> _registerUser(BuildContext context, String name, XFile image,
      String phone, String email, String password, String role) async {
    final FirebaseService _firebaseService = FirebaseService();

    bool success = await _firebaseService.registerUser(
      name,
      image,
      phone,
      email,
      password,
      role,
    );

    return success;
  }
}
