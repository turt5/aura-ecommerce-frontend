import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:attira/services/cart/firebase/_cart_service.dart';
import 'package:attira/services/products/firebase/_product_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:attira/features/user-dashboard/view/widgets/_custom_app_bar.dart';

class CartBody extends StatefulWidget {
  const CartBody({Key? key}) : super(key: key);

  @override
  _CartBodyState createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  late Future<String?> _userIdFuture;
  final Set<String> _selectedCartItemIds =
      Set<String>(); // To track selected items

  @override
  void initState() {
    super.initState();
    _userIdFuture = _getUserId();
  }

  Future<String?> _getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  void _removeCartItem(String cartItemId) async {
    await CartService().removeCartItem(cartItemId);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Cart item removed')),
    );
  }

  void _toggleSelection(String cartItemId) {
    setState(() {
      if (_selectedCartItemIds.contains(cartItemId)) {
        _selectedCartItemIds.remove(cartItemId);
      } else {
        _selectedCartItemIds.add(cartItemId);
      }
    });
  }

  void _checkout() {
    // Perform checkout action with selected cart items
    if (_selectedCartItemIds.isNotEmpty) {
      // Example: print selected items for now
      print('Checkout items: $_selectedCartItemIds');
      // Add your checkout logic here
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No items selected for checkout')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return FutureBuilder<String?>(
      future: _userIdFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: CustomAppBar(
                title: "Cart", theme: Theme.of(context).colorScheme),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            appBar: CustomAppBar(
                title: "Cart", theme: Theme.of(context).colorScheme),
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        final userId = snapshot.data;

        if (userId == null) {
          return Scaffold(
            appBar: CustomAppBar(
                title: "Cart", theme: Theme.of(context).colorScheme),
            body:
                Center(child: Text('User ID not found. Please log in again.')),
          );
        }

        return Scaffold(
          appBar:
              CustomAppBar(title: "Cart", theme: Theme.of(context).colorScheme),
          body: Column(
            children: [
              Expanded(
                child: StreamBuilder<List<CartItem>>(
                  stream: CartService().getCartItems(userId),
                  builder: (context, cartSnapshot) {
                    if (cartSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (cartSnapshot.hasError) {
                      return Center(
                          child: Text('Error: ${cartSnapshot.error}'));
                    }

                    final cartItems = cartSnapshot.data;

                    if (cartItems == null || cartItems.isEmpty) {
                      return Center(
                        child: Text(
                          'Your cart is empty.',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 18),
                        ),
                      );
                    }

                    return StreamBuilder<List<Product>>(
                      stream: FirebaseProductService().getProducts(),
                      builder: (context, productSnapshot) {
                        if (productSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (productSnapshot.hasError) {
                          return Center(
                              child: Text('Error: ${productSnapshot.error}'));
                        }

                        final products = productSnapshot.data;

                        return ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            final cartItem = cartItems[index];
                            final product = products?.firstWhere(
                              (p) => p.id == cartItem.productId,
                              orElse: () => Product(
                                id: '',
                                categoryId: '',
                                categoryName: '',
                                name: 'Product Not Found',
                                description: '',
                                price: 0.0,
                                quantity: '',
                                sizes: [],
                                colors: [],
                                imageUrls: [],
                                tags: [],
                              ),
                            );

                            /*
                            Checkbox(
                                              value: _selectedCartItemIds.contains(cartItem.id),
                                              onChanged: (isSelected) {
                                                _toggleSelection(cartItem.id);
                                              },
                                            ),
                             */

                            return GestureDetector(
                              onTap: () {
                                _toggleSelection(cartItem.id);
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 140,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: _selectedCartItemIds
                                                .contains(cartItem.id)
                                            ? theme.primary.withOpacity(.3)
                                            : theme.primary.withOpacity(.1),
                                        borderRadius: BorderRadius.circular(10),
                                        border: _selectedCartItemIds
                                            .contains(cartItem.id)
                                            ? Border.all(
                                          color: theme.primary.withOpacity(.5),
                                          width: 3
                                        ):null
                                      ),
                                      child: Center(
                                        child: ListTile(
                                          contentPadding: EdgeInsets.all(10),
                                          leading: product
                                                      ?.imageUrls.isNotEmpty ==
                                                  true
                                              ? CachedNetworkImage(
                                                  imageUrl:
                                                      product!.imageUrls[0]!,
                                                  width: 50,
                                                  fit: BoxFit.fill,
                                                  progressIndicatorBuilder:
                                                      (context, a, b) {
                                                    return CupertinoActivityIndicator(
                                                      color: theme.primary,
                                                      radius: 10,
                                                    );
                                                  },
                                                )
                                              : Icon(Icons.image_not_supported),
                                          title: Text(
                                              product?.name ?? 'Unknown Product',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                            color: theme.onSurface,
                                            fontSize: 14
                                          ),),
                                          subtitle: Text(
                                            'Quantity: ${cartItem.quantity}',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: theme.onSurface.withOpacity(.5)
                                            ),
                                          ),
                                          trailing: SizedBox(
                                            width: 50,
                                            child: Text(
                                              'BDT. ${product != null ? (product.price * cartItem.quantity).toStringAsFixed(2) : '0.00'}',
                                              maxLines: 2,
                                              style: TextStyle(
                                                color: theme.primary,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 8,
                                      right: 0,
                                      child: InkWell(
                                        onTap: () {
                                          // Call the removeCartItem method
                                          _removeCartItem(cartItem.id);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                            ),
                                            color: Colors.red,
                                          ),
                                          height: 40,
                                          width: 40,
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                            size: 15,
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
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: ElevatedButton(
                        onPressed: _selectedCartItemIds.length==0? null: _checkout,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: theme.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: theme.primary,
                        ),
                        child: Text('Checkout Items'),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    );
  }
}
