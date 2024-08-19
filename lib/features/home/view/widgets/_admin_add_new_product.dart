import 'package:attira/features/home/controller/_admin_add_product_provider.dart';
import 'package:attira/services/products/firebase/_product_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddNewProduct extends ConsumerWidget {
  AddNewProduct({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;
    final productService = FirebaseProductService();

    final readAdminAddProduct = ref.watch(adminAddProductProvider);
    final writeAdminAddProduct = ref.watch(adminAddProductProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            CustomButton(
              width: double.infinity,
              height: 200,
              primaryColor: theme.primary.withOpacity(.1),
              textColor: theme.onPrimary,
              onPressed: () {},
              textBold: true,
              textSize: 12,
              borderRadius: 13,
              label: 'Add',
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: theme.onSurface.withOpacity(.5),
                      size: 25,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Add Picture',
                      style: TextStyle(
                          color: theme.onSurface.withOpacity(.5), fontSize: 15),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: _nameController,
              hint: 'Product Name',
              height: 55,
              width: double.infinity,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: _priceController,
                    hint: 'Size',
                    height: 55,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CustomTextField(
                    controller: _priceController,
                    hint: 'Price',
                    height: 55,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                CustomButton(
                  width: 70,
                  height: 55,
                  primaryColor: theme.primary,
                  textColor: theme.onPrimary,
                  onPressed: () {},
                  textBold: true,
                  textSize: 12,
                  borderRadius: 13,
                  label: 'Add',
                  child: Center(
                    child: Icon(
                      Icons.add,
                      color: theme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 55,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 13),
              decoration: BoxDecoration(
                color: theme.primary.withOpacity(.1),
                borderRadius: BorderRadius.circular(13),
              ),
              child: StreamBuilder<List<Section>>(
                stream: productService.getSections(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CupertinoActivityIndicator(
                        radius: 10,
                        color: theme.primary,
                      ),
                    );
                  } else if (snapshot.hasData && snapshot.data != null) {
                    List<Section> sections = snapshot.data!;

                    Section? _selectedSection =  readAdminAddProduct.selectedSection;

                    // Ensure _selectedSection is in the sections list
                    if (_selectedSection != null &&
                        !sections.contains(_selectedSection)) {
                      _selectedSection = null;
                    }

                    return DropdownButtonHideUnderline(
                      child: DropdownButton<Section>(
                        dropdownColor: theme.primary,
                        isExpanded: true,
                        value: _selectedSection,
                        hint: Text(
                          _selectedSection != null
                              ? _selectedSection.name.toString()
                              : "Select Section",
                          style: TextStyle(
                            color: theme.onSurface.withOpacity(.5),
                          ),
                        ),
                        items: sections.map((Section section) {
                          return DropdownMenuItem<Section>(
                            value: section,
                            child: Text(section.name),
                          );
                        }).toList(),
                        onChanged: (Section? newValue) {
                          writeAdminAddProduct.setSelectedSection=newValue;
                        },
                      ),
                    );

                  } else {
                    return Center(
                      child: Icon(
                        Icons.error,
                        color: theme.error,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.height,
    required this.width,
  });

  final String hint;
  final double height;
  final double width;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: theme.primary.withOpacity(.1),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Center(
        child: TextField(
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

class ProductCategorySection extends StatelessWidget {
  const ProductCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
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
