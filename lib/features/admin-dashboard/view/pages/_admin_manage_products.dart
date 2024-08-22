import 'package:attira/services/products/firebase/_product_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminManageProducts extends StatefulWidget {
  const AdminManageProducts({super.key});

  @override
  State<AdminManageProducts> createState() => _AdminManageProductsState();
}

class _AdminManageProductsState extends State<AdminManageProducts> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    FirebaseProductService fps = FirebaseProductService();

    return Scaffold(
      backgroundColor: theme.surface,
      appBar: AppBar(
        title: Text(
          'All Products',
          style: TextStyle(
            color: theme.primary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  Container(
                    height: 55,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: theme.primary.withOpacity(.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: theme.onSurface.withOpacity(.5),
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            style: TextStyle(
                              fontSize: 12,
                              color: theme.onSurface,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Search Product',
                              hintStyle: TextStyle(
                                color: theme.onSurface.withOpacity(.5),
                              ),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<List<Product>>(
                stream: fps.getProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CupertinoActivityIndicator(
                        radius: 12,
                        color: theme.primary,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No products found.'),
                    );
                  } else {
                    final filteredProducts = snapshot.data!.where((product) {
                      return product.name.toLowerCase().contains(_searchQuery);
                    }).toList();

                    if (filteredProducts.isEmpty) {
                      return const Center(
                        child: Text('No matching products found.'),
                      );
                    }

                    return ListView.builder(
                      physics: const  BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: theme.secondary.withOpacity(.09),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            title: Text(product.name),
                            subtitle: Text('\$${product.price}'),
                            leading: CachedNetworkImage(
                              imageUrl: product.imageUrls[0]!,
                              height: 50,
                              width: 50,
                              fit: BoxFit.contain,
                            ),
                            onTap: () {
                              // Handle product tap
                            },
                          ),
                        );
                      },
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
