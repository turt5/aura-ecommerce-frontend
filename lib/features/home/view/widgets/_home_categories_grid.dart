import 'package:flutter/material.dart';

class HomeCategoriesGrid extends StatelessWidget {
  const HomeCategoriesGrid({
    super.key,
    required this.theme,
    required this.label,
    required this.asset,
  });

  final ColorScheme theme;
  final String label;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
          onTap: (){

          },

          borderRadius: BorderRadius.circular(10),

          child: Container(
            decoration: BoxDecoration(
                color: theme.tertiary.withOpacity(.4),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 25,
                  child: Image.asset(asset),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  label,
                  style: TextStyle(color: theme.onSurface, fontSize: 11),
                ),
              ],
            ),
          ),
        ));
  }
}
