import 'package:attira/features/home/controller/_categories_model_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '_home_body_search.dart';

class CategoriesBody extends ConsumerWidget {
  const CategoriesBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;

    final read = ref.watch(categoriesProvider);
    final write = ref.read(categoriesProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 20,
          ),
          HomeBodySearch(
            theme: theme,
            onTap: () {},
          ),
          const SizedBox(
            height: 20,
          ),
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: read.categories.length, // Total number of items
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of items per row
              childAspectRatio: (MediaQuery.of(context).size.width / 2) /
                  130, // Aspect ratio to ensure height of 150
              mainAxisSpacing: 10, // Spacing between rows
              crossAxisSpacing: 10, // Spacing between columns
            ),
            itemBuilder: (context, index) {
              return Container(
                height: 130, // Fixed height
                decoration: BoxDecoration(
                    color: theme.primary.withOpacity(.15),
                    borderRadius: BorderRadius.circular(10)),
                // padding: EdgeInsets.all(10),// Example color, change as needed
                child: Stack(
                  children: [
                    Positioned(
                      left:5,
                      top: 0,
                      child: Text(
                        '${index + 1}',
                        style: GoogleFonts.rowdies(
                          color: theme.primary.withOpacity(.2),
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          read.categories[index],
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(color: theme.primary, fontSize: 12,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
