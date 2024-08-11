import 'package:attira/features/home/view/widgets/_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../../services/products/firebase/_product_service.dart';
import '_home_appbar.dart';
import '_home_body_search.dart';
import '_home_categories_grid.dart';
import '_home_offers_section.dart';
import '_home_product_details.dart';
import '_home_tshirt_section.dart';

class HomeBody extends StatelessWidget {
  HomeBody({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final FirebaseProductService productService = FirebaseProductService();
    return Scaffold(
      key: _scaffoldKey,
      appBar: HomeAppbar(_scaffoldKey, theme: theme),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  return const Center(child: Text('No categories found.'));
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
    );
  }
}
