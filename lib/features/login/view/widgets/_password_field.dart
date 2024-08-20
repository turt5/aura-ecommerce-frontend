import 'package:attira/features/splash/view/widgets/_logo.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({super.key, required this.passwordController});

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context).colorScheme;

    return TextField(
      controller: passwordController,
      obscureText: true,
      style: TextStyle(
        color: theme.onSurface
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: theme.primary.withOpacity(.1),
        hintText: 'Password',
        prefixIcon: Icon(
          Icons.lock_outline,
          color: Colors.grey[700],
        ),
        hintStyle: TextStyle(color: Colors.grey[700], fontSize: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 0, color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 0, color: Colors.transparent),
        ),
      ),
    );
  }
}
