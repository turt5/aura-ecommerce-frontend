import 'package:flutter/material.dart';

class AdminManageCategories extends StatelessWidget {
  const AdminManageCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: theme.surface,
      appBar: AppBar(
        title: Text('Categories'),
      ),
    );
  }
}
