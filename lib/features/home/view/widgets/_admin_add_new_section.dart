import 'package:attira/features/home/view/widgets/_custom_app_bar.dart';
import 'package:attira/services/products/firebase/_product_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AdminAddNewSection extends StatelessWidget {
  AdminAddNewSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final FirebaseProductService productService = FirebaseProductService();

    void _showEditDialog(BuildContext context, Section section) {
      _editController.text = section.name;

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Edit Section'),
            content: TextField(
              controller: _editController,
              decoration: InputDecoration(
                hintText: 'Section name',
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
                  String newSectionName = _editController.text.trim();

                  if (newSectionName.isNotEmpty) {
                    productService
                        .updateSection(section.id, newSectionName)
                        .then((_) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Section updated successfully!',
                              style: TextStyle(color: theme.onPrimary)),
                          backgroundColor: theme.primary,
                        ),
                      );
                    }).catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to update section: $error',
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
      backgroundColor: theme.surface,
      appBar: CustomAppBar(title: 'Add New Section', theme: theme),
      body: SafeArea(
          child: Column(
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
                      hintText: 'Add new Section',
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
                    String section = _controller.text.trim();

                    if (section.isNotEmpty) {
                      productService.addSection(section).then((_) {
                        _controller.clear(); // Clear the input after adding
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Section added successfully!',
                                style: TextStyle(color: theme.onPrimary)),
                            backgroundColor: theme.primary,
                          ),
                        );
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to add Section: $error',
                                style: TextStyle(color: theme.onPrimary)),
                            backgroundColor: theme.primary,
                          ),
                        );
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Section cannot be empty!',
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
          Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.white),
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                  child: Text(
                'Existing Sections:',
                style: TextStyle(
                    color: theme.onSurface,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ))),
          Expanded(
            child: StreamBuilder<List<Section>>(
              stream: productService.getSections(),
              builder: (context, snapshot) {
                print(snapshot.data);
                if (snapshot.hasError) {
                  return Center(
                      child: CupertinoActivityIndicator(
                    radius: 10,
                    color: theme.primary,
                  ));
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
                  return Center(child: Text('No sections found.'));
                }

                List<Section> sections = snapshot.data!;

                return ListView.builder(
                  itemCount: sections.length,
                  itemBuilder: (context, index) {
                    final section = sections[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: ListTile(
                        title: Text(
                          section.name,
                          style: TextStyle(color: theme.primary),
                        ),
                        tileColor: Colors.white,
                        leading: Icon(
                          Icons.category_outlined,
                          color: theme.primary,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {
                                  _showEditDialog(context, section);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: theme.error,
                                )),
                            IconButton(
                                onPressed: () {
                                  String id = section.id;
                                  productService.removeSection(id).then((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Section deleted successfully!',
                                            style: TextStyle(
                                                color: theme.onPrimary)),
                                        backgroundColor: theme.primary,
                                      ),
                                    );
                                  }).catchError((error) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Failed to delete section: $error',
                                            style: TextStyle(
                                                color: theme.onPrimary)),
                                        backgroundColor: theme.primary,
                                      ),
                                    );
                                  });
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: theme.error,
                                )),
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
      )),
    );
  }

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _editController = TextEditingController();
}
