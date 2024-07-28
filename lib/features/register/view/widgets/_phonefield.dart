import 'package:attira/features/splash/view/widgets/_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneField extends StatelessWidget {
  const PhoneField({
    super.key,
    required this.phoneController,
  });

  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: phoneController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[350],
        hintText: 'Phone',
        prefixIcon: Icon(
          Icons.phone_outlined,
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
