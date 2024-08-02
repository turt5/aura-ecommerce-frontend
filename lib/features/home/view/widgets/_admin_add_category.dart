import 'package:attira/services/products/firebase/_product_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class AdminAddCategory extends ConsumerWidget {
  AdminAddCategory({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;
    final FirebaseProductService productService = FirebaseProductService();

    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            color: Colors.white,
            height: 80,
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Add new category',
                      hintStyle: const TextStyle(color: Colors.grey),
                      fillColor: theme.primary.withOpacity(.1),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    String category = _controller.text.trim();

                    if (category.isNotEmpty) {
                      productService.addCategory(category).then((_) {
                        _controller.clear(); // Clear the input after adding
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Category added successfully!', style: TextStyle(color: theme.onPrimary)),
                            backgroundColor: theme.primary,
                          ),
                        );
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to add category: $error', style: TextStyle(color: theme.onPrimary)),
                            backgroundColor: theme.primary,
                          ),
                        );
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Category cannot be empty!', style: TextStyle(color: theme.onPrimary)),
                          backgroundColor: theme.primary,
                        ),
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 55,
                    width: 55,
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: theme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Category>>(
              stream: productService.getCategories(),
              builder: (context, snapshot) {
                print(snapshot.data);
                if (snapshot.hasError) {
                  return Center(child: CupertinoActivityIndicator(radius: 10,color: theme.primary,));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListView.builder(
                    itemCount: 5, // Number of skeleton items
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          color: Colors.white,
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                color: Colors.grey[300],
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Container(
                                  height: 20,
                                  color: Colors.grey[300],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No categories found.'));
                }

                List<Category> categories = snapshot.data!;

                return ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: ListTile(
                        title: Text(
                          category.name,
                          style: TextStyle(color: theme.primary),
                        ),
                        tileColor: Colors.white,
                        leading: Icon(
                          Icons.category,
                          color: theme.primary,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}
