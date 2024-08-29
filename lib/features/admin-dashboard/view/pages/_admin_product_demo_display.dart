import 'dart:io';
import 'package:attira/features/register/view/widgets/_customDialog.dart';
import 'package:attira/services/cart/firebase/_cart_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../services/products/firebase/_product_service.dart';

class ProductDisplay extends StatefulWidget {
  final String name;
  final String description;
  final double price;
  final String category;
  final List<String> sizes;
  final List<ColorData> colors;
  final List<String?> imageUrls;
  final int quantity;
  final String productId;

  const ProductDisplay({
    Key? key,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.sizes,
    required this.colors,
    required this.imageUrls,
    required this.quantity,
    required this.productId,
  }) : super(key: key);

  @override
  _ProductDisplayState createState() => _ProductDisplayState();
}

class _ProductDisplayState extends State<ProductDisplay> {
  int _currentIndex = 0;
  String? _selectedSize;
  ColorData? _selectedColor;
  int _selectedQuantity = 1; // Initialize the quantity to 1

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header and Image Carousel code remains unchanged...
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back)),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      widget.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 20,
                        color: theme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20),
                children: [
                  if (widget.imageUrls.isNotEmpty)
                    SizedBox(
                      height: 250,
                      child: Stack(
                        children: [
                          PageView.builder(
                            itemCount: widget.imageUrls.length,
                            onPageChanged: (index) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                            itemBuilder: (context, index) {
                              return CachedNetworkImage(
                                imageUrl: widget.imageUrls[index]!,
                                fit: BoxFit.fill,
                              );
                            },
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${_currentIndex + 1} / ${widget.imageUrls.length}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(widget.imageUrls.length,
                                  (index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  height: 8,
                                  width: 8,
                                  decoration: BoxDecoration(
                                    color: _currentIndex == index
                                        ? theme.primary
                                        : theme.onSurface.withOpacity(0.3),
                                    shape: BoxShape.circle,
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.name,
                    style: TextStyle(
                      color: theme.primary,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '\$${widget.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: theme.secondary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Category: ${widget.category}',
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
                    widget.description,
                    style: TextStyle(
                      color: theme.onSurface.withOpacity(0.7),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Size Selection
                  Text(
                    'Select Size',
                    style: TextStyle(
                      color: theme.onSurface,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    children: widget.sizes
                        .map((size) => ChoiceChip(
                              label: Text(size),
                              selected: _selectedSize == size,
                              onSelected: (selected) {
                                setState(() {
                                  _selectedSize = selected ? size : null;
                                });
                              },
                              backgroundColor: theme.primary.withOpacity(0.1),
                              selectedColor: theme.primary,
                              labelStyle: TextStyle(
                                color: _selectedSize == size
                                    ? theme.onPrimary
                                    : theme.onSurface,
                              ),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 20),

                  // Color Selection
                  Text(
                    'Select Color',
                    style: TextStyle(
                      color: theme.onSurface,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    children: widget.colors
                        .map((color) => ChoiceChip(
                              label: Text(color.colorName),
                              selected: _selectedColor == color,
                              onSelected: (selected) {
                                setState(() {
                                  _selectedColor = selected ? color : null;
                                });
                              },
                              backgroundColor: Color(
                                int.parse(color.colorCode),
                              ).withOpacity(0.3),
                              selectedColor: Color(
                                int.parse(color.colorCode),
                              ),
                              labelStyle: TextStyle(
                                color: theme.primary,
                              ),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 20),

                  // Quantity Selection
                  Text(
                    'Select Quantity',
                    style: TextStyle(
                      color: theme.onSurface,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove,color: Colors.red,),
                        onPressed: () {
                          setState(() {
                            if (_selectedQuantity > 1) {
                              _selectedQuantity--;
                            }
                          });
                        },
                      ),
                      Text(
                        '$_selectedQuantity',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: theme.onSurface,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add,color: Colors.green,),
                        onPressed: () {
                          setState(() {
                            _selectedQuantity++;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          onPressed: () async {
            if (_selectedSize == null || _selectedColor == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Please select a size and color.'),
                ),
              );
              return;
            }

            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

            String userId = sharedPreferences.getString('userId')??"";

            showCustomDialog(context);

            CartService cartService = CartService();
            bool response = await cartService.addToCart(
              userId: userId,
              productId: widget.productId,
              quantity: _selectedQuantity, // Pass the selected quantity
              color: _selectedColor!.colorName,
              size: _selectedSize!,
            );

            if (response) {
              closeCustomDialog();

                ScaffoldMessenger.of(context).showSnackBar(
                 const  SnackBar(
                    content: Text('Product added to cart, Go to cart section to checkout!'),
                  ),
                );

               setState(() {
                 _selectedSize = null;
                 _selectedColor = null;
                 _selectedQuantity = 1;
               });



                return;



            } else {
              closeCustomDialog();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Something went wrong!'),
                ),
              );
              return;
            }
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15),
            backgroundColor: theme.primary,
          ),
          child: Text(
            'Add to cart',
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
