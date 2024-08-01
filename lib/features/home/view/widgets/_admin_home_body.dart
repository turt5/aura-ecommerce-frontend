import 'package:attira/features/home/controller/_admin_home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class AdminHomeBody extends ConsumerWidget {
  const AdminHomeBody({super.key, required this.theme});

  final ColorScheme theme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adminHomeRead = ref.watch(adminHomeProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        children: [
          const SizedBox(height: 10),
          FutureBuilder<Map<String, dynamic>>(
            future: adminHomeRead.getHomeDashboardData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Shimmer.fromColors(
                  baseColor: theme.primary.withOpacity(.1),
                  highlightColor: Colors.grey[200]!,
                  child: GridView.builder(
                    shrinkWrap:
                        true, // This is important to make the GridView fit in the ListView
                    physics:
                        const NeverScrollableScrollPhysics(), // Prevent GridView from scrolling
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Number of items per row
                            mainAxisSpacing:
                                8.0, // Spacing between items vertically
                            crossAxisSpacing:
                                8.0, // Spacing between items horizontally
                            mainAxisExtent: 140),
                    itemCount: 2, // Number of items in the grid
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                            color: theme.surface,
                            borderRadius: BorderRadius.circular(20)),
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final data = snapshot.data!;

                return GridView.builder(
                  shrinkWrap:
                      true, // This is important to make the GridView fit in the ListView
                  physics:
                      const NeverScrollableScrollPhysics(), // Prevent GridView from scrolling
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of items per row
                      mainAxisSpacing: 8.0, // Spacing between items vertically
                      crossAxisSpacing:
                          8.0, // Spacing between items horizontally
                      mainAxisExtent: 140),
                  itemCount: 2, // Number of items in the grid
                  itemBuilder: (BuildContext context, int index) {
                    // Replace with your actual data and widget building logic
                    return Container(
                      decoration: BoxDecoration(
                          color: index == 0 ? theme.primary : theme.onPrimary,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${index==0? data['users']-1:data['products']-1}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20,
                                color: index==0?theme.onPrimary:theme.primary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${ index==0? data['usersTitle']:data['productsTitle']}",
                            style: TextStyle(fontSize: 11,
                              color: index==0?theme.onPrimary:theme.primary,),

                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: Text('No data available'));
              }
            },
          ),
        ],
      ),
    );
  }
}
