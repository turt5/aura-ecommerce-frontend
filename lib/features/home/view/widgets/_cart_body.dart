import 'package:flutter/material.dart';

class CartBody extends StatelessWidget {
  const CartBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Cart',
        style: TextStyle(
            color: Theme.of(context).colorScheme.primary, fontSize: 18),
      ),
    );
  }
}
