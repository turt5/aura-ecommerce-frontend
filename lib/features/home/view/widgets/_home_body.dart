import 'package:flutter/material.dart';

import '_home_body_search.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 10,
          ),
          HomeBodySearch(
            theme: theme,
            onTap: () {},
          ),
          const SizedBox(
            height: 13,
          ),
          SizedBox(
            height: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/picture/banner-1.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 70,
            child: Row(
              children: [
                HomeCategoriesGrid(
                  theme: theme,
                  label: "T-Shirt",
                  asset: 'assets/icon/tshirt.png',
                ),
                const SizedBox(
                  width: 15,
                ),
                HomeCategoriesGrid(
                  theme: theme,
                  label: "Shirt",
                  asset: 'assets/icon/shirt.png',
                ),
                const SizedBox(
                  width: 15,
                ),
                HomeCategoriesGrid(
                  theme: theme,
                  label: "Pant",
                  asset: 'assets/icon/pant.png',
                ),
                const SizedBox(
                  width: 15,
                ),
                HomeCategoriesGrid(
                  theme: theme,
                  label: "More",
                  asset: 'assets/icon/menu.png',
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 500,
            color: theme.tertiary,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'T-Shirt',
                      style: TextStyle(
                          color: theme.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(onPressed: () {}, child: Text('See All'))
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns in the grid
                    crossAxisSpacing: 8.0, // Space between columns
                    mainAxisSpacing: 8.0, // Space between rows
                  ),
                  itemCount: 4, // Total number of items
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.teal[(index + 1) * 100],
                      child: Center(
                        child: Text(
                          'Item $index',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

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
    ));
  }
}
