import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseProductService {
  final FirebaseFirestore _firestoreDB = FirebaseFirestore.instance;
  final String _collectionPath = 'categories';
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final String _productsCollectionPath = 'products';

  // Method to upload an image to Firebase Storage
  Future<String?> uploadImage(XFile imageFile) async {
    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final storageRef = _storage.ref().child('product_images/$fileName');
      final uploadTask = storageRef.putFile(File(imageFile.path));
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Failed to upload image: $e");
      return null;
    }
  }

  // Method to add a new product to Firestore
  Future<bool> addProduct(Map<String, dynamic> productData) async {
    try {
      await _firestoreDB.collection(_productsCollectionPath).add(productData);
      print("Product added successfully.");
      return true;
    } catch (e) {
      print("Failed to add product: $e");
      return false;
    }
  }

  // Method to get all products
  Stream<List<Product>> getProducts() {
    Stream<List<Product>> products = _firestoreDB.collection(_productsCollectionPath).snapshots().map(
          (snapshot) {
        final productList = snapshot.docs.map(
              (doc) {
            final data = doc.data();
            return Product.fromFirestore(doc.id, data);
          },
        ).toList();

        // Print each product's details for debugging
        for (var product in productList) {
          print('Product ID: ${product.id}, Name: ${product.name}, Price: ${product.price}');
        }

        return productList;
      },
    );

    return products;
  }


  // Method to update a product
  Future<void> updateProduct(
      String productId, Map<String, dynamic> productData) async {
    try {
      await _firestoreDB
          .collection(_productsCollectionPath)
          .doc(productId)
          .update(productData);
      print("Product updated successfully.");
    } catch (e) {
      print("Failed to update product: $e");
    }
  }

  // Method to delete a product
  Future<void> deleteProduct(String productId) async {
    try {
      await _firestoreDB
          .collection(_productsCollectionPath)
          .doc(productId)
          .delete();
      print("Product deleted successfully.");
    } catch (e) {
      print("Failed to delete product: $e");
    }
  }

  // Method to get the count of products
  Future<String> getProductCount() async {
    try {
      final snapshot =
      await _firestoreDB.collection(_productsCollectionPath).get();
      return snapshot.docs.length.toString();
    } catch (e) {
      print("Failed to get product count: $e");
      return '0';
    }
  }

  // Add a new category
  Future<void> addCategory(String categoryName) async {
    try {
      await _firestoreDB.collection(_collectionPath).add({
        'name': categoryName,
        'timestamp': FieldValue.serverTimestamp(),
      });
      print("Category added successfully.");
    } catch (e) {
      print("Failed to add category: $e");
    }
  }

  // Get all categories
  Stream<List<Category>> getCategories() {
    return _firestoreDB.collection(_collectionPath).snapshots().map(
          (snapshot) {
        final categories = snapshot.docs.map(
              (doc) {
            final data = doc.data();
            return Category.fromFirestore(doc.id, data);
          },
        ).toList();
        return categories;
      },
    );
  }

  // Update an existing category
  Future<void> updateCategory(String categoryId, String newCategoryName) async {
    try {
      await _firestoreDB.collection(_collectionPath).doc(categoryId).update({
        'name': newCategoryName,
        'timestamp': FieldValue.serverTimestamp(),
      });
      print("Category updated successfully.");
    } catch (e) {
      print("Failed to update category: $e");
    }
  }

  // Delete a category
  Future<void> deleteCategory(String categoryId) async {
    try {
      await _firestoreDB.collection(_collectionPath).doc(categoryId).delete();
      print("Category deleted successfully.");
    } catch (e) {
      print("Failed to delete category: $e");
    }
  }

  // Get the count of categories
  Future<String> getCategoryCount() async {
    try {
      final snapshot = await _firestoreDB.collection(_collectionPath).get();
      return snapshot.docs.length.toString();
    } catch (e) {
      print("Failed to get category count: $e");
      return '0';
    }
  }
}

class Category {
  final String id;
  final String name;
  final Timestamp timestamp;

  Category({
    required this.id,
    required this.name,
    required this.timestamp,
  });

  factory Category.fromFirestore(String id, Map<String, dynamic> data) {
    return Category(
      id: id,
      name: data['name'] ?? '',
      timestamp: data['timestamp'] as Timestamp,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Category &&
        other.id == id &&
        other.name == name &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ timestamp.hashCode;
}

class Product {
  final String id;
  final String categoryId;
  final String categoryName;
  final String name;
  final String description;
  final double price;
  final String quantity;
  final List<String> sizes;
  final List<ColorData> colors;
  final List<String?> imageUrls;
  final List<String> tags;

  Product({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.sizes,
    required this.colors,
    required this.imageUrls,
    required this.tags,
  });

  factory Product.fromFirestore(String id, Map<String, dynamic> data) {
    try {
      return Product(
        id: id,
        categoryId: data['categoryId'] ?? '',
        categoryName: data['categoryName'] ?? '',
        name: data['name'] ?? '',
        description: data['description'] ?? '',
        price: (data['price'] as num).toDouble(),
        quantity: data['quantity'] ?? '',
        sizes: List<String>.from(data['sizes'] ?? []),
        colors: (data['colors'] as List)
            .map((color) => ColorData.fromFirestore(color))
            .toList(),
        imageUrls: List<String>.from(data['imageUrls'] ?? []),
        tags: List<String>.from(data['tags'] ?? []),
      );
    } catch (e) {
      print("Error parsing product data: $e");
      throw Exception("Failed to parse product data");
    }
  }
}

class ColorData {
  final String colorCode;
  final String colorName;

  ColorData({required this.colorCode, required this.colorName});

  factory ColorData.fromFirestore(Map<String, dynamic> data) {
    return ColorData(
      colorCode: data['colorCode'] ?? '',
      colorName: data['colorName'] ?? '',
    );
  }
}
