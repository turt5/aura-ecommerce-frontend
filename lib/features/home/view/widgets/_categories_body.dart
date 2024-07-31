import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoriesBody extends StatelessWidget {
  const CategoriesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Categories',
        style: TextStyle(
            color: Theme.of(context).colorScheme.primary, fontSize: 18),
      ),
    );
  }
}
