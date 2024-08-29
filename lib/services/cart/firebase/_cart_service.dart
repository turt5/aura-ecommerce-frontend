import 'package:cloud_firestore/cloud_firestore.dart';

class CartService {
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  final String _collection = 'cart';

  // Method to add a cart item
  Future<bool> addToCart({
    required String productId,
    required int quantity,
    required String color,
    required String size,
    required String userId,
  }) async {
    try {
      await _database.collection(_collection).add({
        'userId': userId,
        'productId': productId,
        'quantity': quantity,
        'color': color,
        'size': size,
        'addedAt': FieldValue.serverTimestamp(),
      });
      return true;
    } catch (e) {
      print('Error adding to cart: $e');
      return false;
    }
  }

  // Method to get cart items for a specific user
  Stream<List<CartItem>> getCartItems(String userId) {
    return _database
        .collection(_collection)
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => CartItem.fromFirestore(doc))
        .toList());
  }

  // Method to remove a cart item by its document ID
  Future<void> removeCartItem(String cartItemId) async {
    try {
      await _database.collection(_collection).doc(cartItemId).delete();
      print("Cart item removed successfully.");
    } catch (e) {
      print("Failed to remove cart item: $e");
    }
  }
}


class CartItem {
  final String id; // Add this field
  final String productId;
  final int quantity;
  final String color;
  final String size;

  CartItem({
    required this.id, // Initialize this field
    required this.productId,
    required this.quantity,
    required this.color,
    required this.size,
  });

  factory CartItem.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CartItem(
      id: doc.id, // Extract the document ID
      productId: data['productId'],
      quantity: data['quantity'],
      color: data['color'],
      size: data['size'],
    );
  }
}
