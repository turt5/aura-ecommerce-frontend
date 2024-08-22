import 'package:attira/features/user-dashboard/view/widgets/_custom_app_bar.dart';
import 'package:flutter/material.dart';

class CartBody extends StatelessWidget {
  const CartBody({super.key});

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: CustomAppBar(title: "Cart", theme: theme),
      body: Center(
        child: Text(
          'Cart Page',
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary, fontSize: 18),
        ),
      ),
    );
  }
}
