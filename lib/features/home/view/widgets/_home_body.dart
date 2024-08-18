import 'package:attira/features/home/controller/_home_model_provider.dart';
import 'package:attira/features/home/view/widgets/_drawer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../services/products/firebase/_product_service.dart';
import '_home_appbar.dart';
import '_home_body_search.dart';
import '_home_categories_grid.dart';
import '_home_offers_section.dart';
import '_home_product_details.dart';
import '_home_tshirt_section.dart';

class HomeBody extends ConsumerWidget {
  HomeBody({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;
    final FirebaseProductService productService = FirebaseProductService();
    final readUserData = ref.watch(homeModelProvider);

    return Scaffold(
      key: _scaffoldKey,
      // appBar: HomeAppbar(_scaffoldKey, theme: theme),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        _scaffoldKey.currentState!.openDrawer();
                      },
                      icon: Icon(Icons.menu)),
                  FutureBuilder(
                      future: readUserData.getUserData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError ||
                            snapshot.connectionState ==
                                ConnectionState.waiting) {
                          return CupertinoActivityIndicator(
                            color: theme.primary,
                            radius: 10,
                          );
                        }

                        final user = snapshot.data!;

                        return Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  generateGreeting(),
                                  style: TextStyle(
                                      color: theme.onSurface.withOpacity(.5),
                                      fontSize: 11),
                                ),
                                SizedBox(
                                  width: 150,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          user['name'],
                                          maxLines: 1,
                                          textAlign: TextAlign.end,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: theme.onSurface,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: theme.primary, width: 2),
                                  shape: BoxShape.circle),
                              padding: EdgeInsets.all(3),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: CachedNetworkImage(
                                  imageUrl: user['imageUrl'],
                                  height: 35,
                                  width: 35,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          ],
                        );
                      })
                ],
              ),
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 10),
                  HomeBodySearch(
                    theme: theme,
                    onTap: () {},
                  ),
                  const SizedBox(height: 13),
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
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 70,
                    child: Row(
                      children: [
                        HomeCategoriesGrid(
                          theme: theme,
                          label: "T-Shirt",
                          asset: 'assets/icon/tshirt.png',
                        ),
                        const SizedBox(width: 15),
                        HomeCategoriesGrid(
                          theme: theme,
                          label: "Shirt",
                          asset: 'assets/icon/shirt.png',
                        ),
                        const SizedBox(width: 15),
                        HomeCategoriesGrid(
                          theme: theme,
                          label: "Pant",
                          asset: 'assets/icon/pant.png',
                        ),
                        const SizedBox(width: 15),
                        HomeCategoriesGrid(
                          theme: theme,
                          label: "More",
                          asset: 'assets/icon/menu.png',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  HomeOffersSection(
                    theme: theme,
                    imageUrl: "assets/picture/clothes.jpg",
                  ),
                  const SizedBox(height: 20),
                  StreamBuilder<List<Category>>(
                    stream: productService.getCategories(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CupertinoActivityIndicator(
                            radius: 12,
                            color: theme.primary,
                          ),
                        );
                      }

                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                            child: Text('No categories found.'));
                      }

                      final data = snapshot.data!;

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return HomeTShirtSection(
                            theme: theme,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeProductDetails(),
                                ),
                              );
                            },
                            title: data[index].name,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String generateGreeting() {
    final now = DateTime.now();
    final hour = now.hour;

    if (hour >= 5 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon';
    } else if (hour >= 17 && hour < 21) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }
}
