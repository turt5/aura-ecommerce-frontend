import 'package:attira/features/user-dashboard/view/pages/_products_by_category.dart';
import 'package:attira/features/user-dashboard/view/pages/_search_categories.dart';
import 'package:attira/features/user-dashboard/view/widgets/_custom_app_bar.dart';
import 'package:attira/services/products/firebase/_product_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/_home_body_search.dart';

class CategoriesBody extends ConsumerWidget {
  const CategoriesBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: theme.surface,
      statusBarIconBrightness: theme.brightness,
      systemNavigationBarColor: theme.surface,
      systemNavigationBarIconBrightness: theme.brightness
    ));


    final FirebaseProductService productService = FirebaseProductService();

    return Scaffold(
      appBar: CustomAppBar(title: "Categories", theme: theme),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            const SizedBox(
              height: 20,
            ),
            HomeBodySearch(
              theme: theme,
              label: "Search for categories",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchCategories()));
              },
            ),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder<List<Category>>(
              stream: productService.getCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
      
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
      
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No categories found.'));
                }
      
                final data = snapshot.data!;
      
                return GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: (MediaQuery.of(context).size.width / 2) /
                        130, // Aspect ratio to ensure height of 130
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductsByCategoryPage(
                          categoryName: data[index].name,
                          categoryId: data[index].id,
                        )));
                      },
                      child: Container(
                        height: 130, // Fixed height
                        decoration: BoxDecoration(
                          color: theme.primary.withOpacity(.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 5,
                              top: 0,
                              child: Text(
                                '${index + 1}',
                                style: GoogleFonts.rowdies(
                                  color: theme.primary.withOpacity(.2),
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  data[index].name,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: theme.primary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
