import 'package:attira/features/admin-dashboard/view/pages/_admin_product_demo_display.dart';
import 'package:attira/services/products/firebase/_product_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsByCategoryPage extends ConsumerStatefulWidget {
  const ProductsByCategoryPage(
      {super.key, required this.categoryName, required this.categoryId});

  final String categoryId;
  final String categoryName;

  @override
  ConsumerState<ProductsByCategoryPage> createState() =>
      _ProductsByCategoryPageState();
}

class _ProductsByCategoryPageState
    extends ConsumerState<ProductsByCategoryPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    FirebaseProductService fps = FirebaseProductService();

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.categoryId),
      // ),
      body: SafeArea(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back)),
                const SizedBox(
                  width: 7,
                ),
                Text(
                  widget.categoryName,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
              child: StreamBuilder(
                  stream: fps.getProductsByCategory(widget.categoryId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CupertinoActivityIndicator(
                          radius: 12,
                          color: theme.primary,
                        ),
                      );
                    } else if (snapshot.hasData && snapshot.data != null) {
                      final List<Product> products = snapshot.data!;

                      return products.length == 0
                          ? Center(
                              child: Text('No Products found'),
                            )
                          : GridView.builder(
                              itemCount: products.length,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisExtent: 250),
                              itemBuilder: (context, index) {
                                Product currentProduct = products[index];
                                return InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDisplay(
                                                  productId: currentProduct.id,
                                                    name: currentProduct.name,
                                                    description: currentProduct
                                                        .description,
                                                    price: currentProduct.price,
                                                    category: currentProduct
                                                        .categoryName,
                                                    sizes: currentProduct.sizes,
                                                    colors:
                                                        currentProduct.colors,
                                                    imageUrls: currentProduct
                                                        .imageUrls,
                                                    quantity: int.parse(
                                                        currentProduct
                                                            .quantity))));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: theme.primary.withOpacity(.05),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      children: [
                                        Expanded(
                                            child: CachedNetworkImage(
                                          imageUrl:
                                              currentProduct.imageUrls.first!,
                                          fit: BoxFit.contain,
                                        )),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          currentProduct.name,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "BDT. ${currentProduct.price.toString()}",
                                          style: TextStyle(
                                              color: theme.primary,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                    } else {
                      return Center(
                        child: Text('Something went wrong!'),
                      );
                    }
                  }))
        ],
      )),
    );
  }
}
