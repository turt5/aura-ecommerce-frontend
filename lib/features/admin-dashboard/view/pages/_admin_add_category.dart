import 'package:attira/services/products/firebase/_product_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class AdminAddCategory extends ConsumerWidget {
  AdminAddCategory({super.key});

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _editController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;
    final FirebaseProductService productService = FirebaseProductService();

    void _showEditDialog(BuildContext context, Category category) {
      _editController.text = category.name;

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Edit Category'),
            content: TextField(
              controller: _editController,
              decoration: InputDecoration(
                hintText: 'Category name',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  String newCategoryName = _editController.text.trim();

                  if (newCategoryName.isNotEmpty) {
                    productService
                        .updateCategory(category.id, newCategoryName)
                        .then((_) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Category updated successfully!',
                              style: TextStyle(color: theme.onPrimary)),
                          backgroundColor: theme.primary,
                        ),
                      );
                    }).catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to update category: $error',
                              style: TextStyle(color: theme.onPrimary)),
                          backgroundColor: theme.primary,
                        ),
                      );
                    });
                  }
                },
                child: Text('Save'),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            color: theme.surface,
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
                            content: Text('Category added successfully!',
                                style: TextStyle(color: theme.onPrimary)),
                            backgroundColor: theme.primary,
                          ),
                        );
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to add category: $error',
                                style: TextStyle(color: theme.onPrimary)),
                            backgroundColor: theme.primary,
                          ),
                        );
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Category cannot be empty!',
                              style: TextStyle(color: theme.onPrimary)),
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
          // const SizedBox(
          //   height: 10,
          // ),
          Container(
            width: double.infinity,
              decoration: BoxDecoration(color: theme.surface),
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(child: Text('Existing Categories:',style: TextStyle(
                color: theme.onSurface,
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),))),
          // const SizedBox(
          //   height: 10,
          // ),
          Expanded(
            child: StreamBuilder<List<Category>>(
              stream: productService.getCategories(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: CupertinoActivityIndicator(
                      radius: 10,
                      color: theme.primary,
                    ),
                  );
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          color: theme.surface,
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
                          style: TextStyle(color: theme.onSurface),
                        ),
                        tileColor: theme.primary.withOpacity(.1),
                        leading: Icon(
                          Icons.category,
                          color: theme.primary,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                _showEditDialog(context, category);
                              },
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                String id = category.id;
                                productService.deleteCategory(id).then((_) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Category deleted successfully!',
                                          style: TextStyle(
                                              color: theme.onPrimary)),
                                      backgroundColor: theme.primary,
                                    ),
                                  );
                                }).catchError((error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Failed to delete category: $error',
                                          style: TextStyle(
                                              color: theme.onPrimary)),
                                      backgroundColor: theme.primary,
                                    ),
                                  );
                                });
                              },
                              icon: Icon(Icons.delete, color: theme.error),
                            ),
                          ],
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
