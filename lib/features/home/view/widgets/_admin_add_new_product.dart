import 'dart:io';
import 'package:attira/features/register/view/widgets/_customDialog.dart';
import 'package:attira/services/products/firebase/_product_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '_admin_product_demo_display.dart';

class AddNewProduct extends ConsumerStatefulWidget {
  const AddNewProduct({super.key});

  @override
  _AddNewProductState createState() => _AddNewProductState();
}

class _AddNewProductState extends ConsumerState<AddNewProduct> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _sizesController = TextEditingController();
  final TextEditingController _colorsController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  final List<XFile> _imageFiles = []; // Change to List

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImages() async {
    final List<XFile>? images =
        await _picker.pickMultiImage(); // Use pickMultiImage
    if (images != null) {
      setState(() {
        _imageFiles.addAll(images);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    GestureDetector(
                      onTap: _pickImages,
                      child: CustomButton(
                        width: double.infinity,
                        height: 200,
                        primaryColor: theme.primary.withOpacity(.1),
                        textColor: theme.onPrimary,
                        onPressed: _pickImages,
                        textBold: true,
                        textSize: 12,
                        borderRadius: 13,
                        label: 'Add Pictures',
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_a_photo,
                                color: theme.onSurface.withOpacity(.5),
                                size: 25,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Add Pictures',
                                style: TextStyle(
                                    color: theme.onSurface.withOpacity(.5),
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _imageFiles.isNotEmpty
                        ? Column(
                            children: _imageFiles.map((file) {
                              return Column(
                                children: [
                                  Stack(
                                    // fit: StackFit.expand,
                                    children: [
                                      Image.file(
                                        File(file.path),
                                        width: double.infinity,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                      Positioned(
                                          top: 10,
                                          right: 10,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: theme.surface,
                                                shape: BoxShape.circle),
                                            child: IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.close,
                                                  color: theme.error,
                                                )),
                                          ))
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              );
                            }).toList(),
                          )
                        : const SizedBox.shrink(),
                    CustomTextField(
                      controller: _nameController,
                      hint: 'Product Name',
                      height: 55,
                      width: double.infinity,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: _priceController,
                      hint: 'Price',
                      height: 55,
                      width: double.infinity,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: _descriptionController,
                      hint: 'Description',
                      height: 100,
                      width: double.infinity,
                      maxLines: null,
                      expands: true,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: _categoryController,
                      hint: 'Category',
                      height: 55,
                      width: double.infinity,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: _sizesController,
                      hint: 'Sizes (comma separated)',
                      height: 55,
                      width: double.infinity,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: _colorsController,
                      hint:
                          'Colors (format: colorName:colorCode, comma separated)',
                      height: 55,
                      width: double.infinity,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      controller: _tagsController,
                      hint: 'Tags (format: \#TagName, comma separated)',
                      height: 55,
                      width: double.infinity,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                      decoration: BoxDecoration(
                        color: theme.tertiary,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            'Please upload an image of size chart too regarding the product sizes!',
                            style: TextStyle(color: theme.onTertiary),
                          ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                width: double.infinity,
                height: 55,
                primaryColor: theme.primary,
                textColor: theme.onPrimary,
                onPressed: () async {
                  // if (_nameController.text.isEmpty ||
                  //     _priceController.text.isEmpty ||
                  //     _descriptionController.text.isEmpty ||
                  //     _categoryController.text.isEmpty ||
                  //     _descriptionController.text.isEmpty ||
                  //     _sizesController.text.isEmpty ||
                  //     _tagsController.text.isEmpty ||
                  //     _imageFiles.isEmpty) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(
                  //         content:
                  //             Text('Fill all the data to add this product!')),
                  //   );
                  //   return;
                  // }

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDisplay(
                        name: 'Sample Product',
                        description: 'This is a sample product description.',
                        price: 29.99,
                        category: 'Category A',
                        sizes: ['S', 'M', 'L'],
                        colors: [
                          {'colorName': 'Red', 'colorCode': '0xFFFF0000'},
                          {'colorName': 'Blue', 'colorCode': '0xFF0000FF'},
                        ],
                        imageFiles: _imageFiles,
                      ),
                    ),
                  );


                  // showCustomDialog(context);
                  //
                  // final productService = FirebaseProductService();
                  //
                  // // Create a product object
                  // final productData = {
                  //   'name': _nameController.text,
                  //   'description': _descriptionController.text,
                  //   'category': _categoryController.text,
                  //   'price': double.tryParse(_priceController.text) ?? 0.0,
                  //   'sizes': _sizesController.text
                  //       .split(',')
                  //       .map((size) => size.trim())
                  //       .toList(),
                  //   'colors': _colorsController.text
                  //       .split(',')
                  //       .map((color) => {
                  //             'colorName': color.split(':')[0].trim(),
                  //             'colorCode': color.split(':')[1].trim()
                  //           })
                  //       .toList(),
                  //   'imageUrls': _imageFiles.isNotEmpty
                  //       ? await Future.wait(_imageFiles
                  //           .map((file) => productService.uploadImage(file)))
                  //       : [],
                  // };
                  //
                  // // await productService.addProduct(productData);
                  //
                  // // Clear form
                  // _nameController.clear();
                  // _priceController.clear();
                  // _descriptionController.clear();
                  // _categoryController.clear();
                  // _sizesController.clear();
                  // _colorsController.clear();
                  // setState(() {
                  //   _imageFiles.clear(); // Clear the image list
                  // });
                  // closeCustomDialog();
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(content: Text('Product added successfully')),
                  // );
                },
                textBold: true,
                textSize: 16,
                borderRadius: 13,
                label: 'Add Product',
                child: Center(
                  child: Icon(
                    Icons.save,
                    color: theme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Your existing CustomTextField and CustomButton classes remain unchanged
class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.height,
    required this.width,
    this.maxLines,
    this.expands = false, // Default to false if not provided
  });

  final String hint;
  final double height;
  final double width;
  final int? maxLines;
  final bool expands;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: theme.primary.withOpacity(.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: TextField(
          style: TextStyle(fontSize: 12),
          maxLines: maxLines ?? (expands ? null : 1), // Adjust maxLines logic
          expands: expands, // Set expands based on the provided value
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: theme.onSurface.withOpacity(.6),
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.width,
    required this.height,
    required this.primaryColor,
    required this.textColor,
    required this.label,
    required this.onPressed,
    required this.textBold,
    required this.textSize,
    required this.borderRadius,
    this.child,
  });

  final double width;
  final double height;
  final Color primaryColor;
  final Color textColor;
  final bool textBold;
  final double textSize;
  final double borderRadius;
  final String label;
  final VoidCallback onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: child ??
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: textSize,
                fontWeight: textBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
      ),
    );
  }
}
