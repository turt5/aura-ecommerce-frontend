import 'package:attira/features/splash/view/widgets/_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NameField extends StatelessWidget {
  const NameField({
    super.key,
    required this.nameController,
    required this.hint,
    required this.icon,
  });

  final TextEditingController nameController;
  final String hint;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return TextField(
      controller: nameController,
      style: TextStyle(
        color: theme.onSurface
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: theme.primary.withOpacity(.1),
        hintText: hint,
        prefixIcon: Icon(
          icon,
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
