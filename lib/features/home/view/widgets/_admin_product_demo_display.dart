import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ProductDisplay extends StatelessWidget {
  final String name;
  final String description;
  final double price;
  final String category;
  final List<String> sizes;
  final List<Map<String, String>> colors;
  final List<XFile> imageFiles;

  const ProductDisplay({
    super.key,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.sizes,
    required this.colors,
    required this.imageFiles,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: theme.brightness,
      systemNavigationBarIconBrightness: theme.brightness,
      systemNavigationBarColor: theme.surface,
      statusBarColor: theme.surface
    ));

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Product View Demo',style: TextStyle(
                  fontSize: 20,
                  color: theme.onSurface
                ),),

              ],
            ),
            const SizedBox(height: 20,),
            if (imageFiles.isNotEmpty)
              SizedBox(
                height: 250,
                child: PageView.builder(
                  itemCount: imageFiles.length,
                  itemBuilder: (context, index) {
                    return Image.file(
                      File(imageFiles[index].path),
                      fit: BoxFit.cover,
                    );
                  },
                ),
              )
            else
              Container(
                height: 250,
                color: theme.onSurface.withOpacity(0.1),
                child: Center(
                  child: Text(
                    'No Image Available',
                    style: TextStyle(color: theme.onSurface),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            Text(
              name,
              style: TextStyle(
                color: theme.primary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '\$${price.toStringAsFixed(2)}',
              style: TextStyle(
                color: theme.secondary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Category: $category',
              style: TextStyle(
                color: theme.onSurface.withOpacity(0.6),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Description',
              style: TextStyle(
                color: theme.onSurface,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(
                color: theme.onSurface.withOpacity(0.7),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Sizes Available',
              style: TextStyle(
                color: theme.onSurface,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: sizes
                  .map((size) => Chip(
                label: Text(size),
                backgroundColor: theme.primary.withOpacity(0.1),
              ))
                  .toList(),
            ),
            const SizedBox(height: 20),
            Text(
              'Colors Available',
              style: TextStyle(
                color: theme.onSurface,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: colors
                  .map((color) => Chip(
                label: Text(color['colorName'] ?? ''),
                backgroundColor:
                Color(int.parse(color['colorCode'] ?? '0xFFFFFFFF'))
                    .withOpacity(0.1),
              ))
                  .toList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          onPressed: () {
            // Handle add to cart action here
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15),
            backgroundColor: theme.primary,
          ),
          child: Text(
            'Exit',
            style: TextStyle(
              color: theme.onPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
