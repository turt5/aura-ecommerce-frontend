import 'package:attira/features/admin-dashboard/view/pages/_admin_add_category.dart';
import 'package:attira/features/admin-dashboard/view/pages/_admin_add_new_product.dart';
import 'package:flutter/material.dart';

class AdminAddProduct extends StatelessWidget {
  const AdminAddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddNewProduct()));
          },
          splashColor: theme.onPrimary,
          focusColor: theme.onPrimary,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 60,
            width: 200,
            decoration: BoxDecoration(
                color: theme.primary, borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text(
              'Add New Product',
              style: TextStyle(color: theme.onPrimary),
            )),
          ),
        ),
        // const SizedBox(
        //   height: 15,
        // ),
        // InkWell(
        //   onTap: () {
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => AdminAddNewSection()));
        //   },
        //   splashColor: theme.onPrimary,
        //   focusColor: theme.onPrimary,
        //   borderRadius: BorderRadius.circular(10),
        //   child: Container(
        //     height: 60,
        //     width: 200,
        //     decoration: BoxDecoration(
        //         color: theme.tertiary,
        //         borderRadius: BorderRadius.circular(10)),
        //     child: Center(
        //         child: Text(
        //       'Add New Section',
        //       style: TextStyle(color: theme.onTertiary),
        //     )),
        //   ),
        // ),
        const SizedBox(
          height: 15,
        ),
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AdminAddCategory()));
          },
          splashColor: theme.onPrimary,
          focusColor: theme.onPrimary,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 60,
            width: 200,
            decoration: BoxDecoration(
                color: theme.onPrimary,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text(
              'Add New Category',
              style: TextStyle(color: theme.primary),
            )),
          ),
        )
      ],
    );
  }
}
