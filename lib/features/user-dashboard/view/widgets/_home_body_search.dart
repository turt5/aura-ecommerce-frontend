import 'package:flutter/material.dart';

class HomeBodySearch extends StatelessWidget {
  const HomeBodySearch({
    super.key,
    required this.theme, required this.onTap, required this.label,
  });

  final String label;

  final ColorScheme theme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(300),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            color: theme.primary.withOpacity(.17),
            borderRadius: BorderRadius.circular(300)),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: theme.primary,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(label)
            ],
          ),
        ),
      ),
    );
  }
}
