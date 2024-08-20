import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseProductService {
  final FirebaseFirestore _firestoreDB = FirebaseFirestore.instance;
  final String _collectionPath = 'categories';
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final String _productsCollectionPath = 'products';



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
  Future<void> addProduct(Map<String, dynamic> productData) async {
    try {
      await _firestoreDB.collection(_productsCollectionPath).add(productData);
      print("Product added successfully.");
    } catch (e) {
      print("Failed to add product: $e");
    }
  }

  // Method to get all products
  Stream<List<Product>> getProducts() {
    return _firestoreDB.collection(_productsCollectionPath).snapshots().map(
          (snapshot) {
        final products = snapshot.docs.map(
              (doc) {
            final data = doc.data();
            return Product.fromFirestore(doc.id, data);
          },
        ).toList();
        return products;
      },
    );
  }

  // Method to update a product
  Future<void> updateProduct(String productId, Map<String, dynamic> productData) async {
    try {
      await _firestoreDB.collection(_productsCollectionPath).doc(productId).update(productData);
      print("Product updated successfully.");
    } catch (e) {
      print("Failed to update product: $e");
    }
  }

  // Method to delete a product
  Future<void> deleteProduct(String productId) async {
    try {
      await _firestoreDB.collection(_productsCollectionPath).doc(productId).delete();
      print("Product deleted successfully.");
    } catch (e) {
      print("Failed to delete product: $e");
    }
  }

  // Method to get the count of products
  Future<String> getProductCount() async {
    try {
      final snapshot = await _firestoreDB.collection(_productsCollectionPath).get();
      return snapshot.docs.length.toString();
    } catch (e) {
      print("Failed to get product count: $e");
      return '0';
    }
  }

  Future<void> updateSection(String id, String name) async{
    try{
      _firestoreDB.collection('sections').doc(id).update(
        {
          'name': name,
          'timestamp': FieldValue.serverTimestamp()
        }
      );
    }catch(e){
      print(e);
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
        print('Snapshot received with ${snapshot.docs.length} documents');
        final categories = snapshot.docs.map(
          (doc) {
            final data = doc.data();
            print('Document ID: ${doc.id}, Data: $data');
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

// class Section {
//   final String id;
//   final String name;
//   final Timestamp timestamp;
//
//   Section({required this.id, required this.name, required this.timestamp});
//
//   factory Section.fromFirestore(String id, Map<String, dynamic> data) {
//     return Section(
//         id: id,
//         name: data['name'] ?? "",
//         timestamp: data['timeStamp'] as Timestamp);
//   }
//
//   factory Section.getJson(Map<String, dynamic> data){
//     return Section(
//       id: data['id'],
//       name: data['name'],
//       timestamp: data['timestamp']
//     );
//   }
//
//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
//     return other is Section &&
//         other.id == id &&
//         other.name == name &&
//         other.timestamp == timestamp;
//   }
//
//   @override
//   int get hashCode => id.hashCode ^ name.hashCode ^ timestamp.hashCode;
// }
class Product {
  final String id;
  final String name;
  final String description;
  final String category;
  final double price;
  final List<String> sizes;
  final List<Map<String, String>> colors;
  final String? imageUrl;
  final Timestamp timestamp;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.sizes,
    required this.colors,
    this.imageUrl,
    required this.timestamp,
  });

  factory Product.fromFirestore(String id, Map<String, dynamic> data) {
    return Product(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      sizes: List<String>.from(data['sizes'] ?? []),
      colors: List<Map<String, String>>.from(data['colors'] ?? []),
      imageUrl: data['imageUrl'] as String?,
      timestamp: data['timestamp'] as Timestamp,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.category == category &&
        other.price == price &&
        other.sizes == sizes &&
        other.colors == colors &&
        other.imageUrl == imageUrl &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ description.hashCode ^ category.hashCode ^
  price.hashCode ^ sizes.hashCode ^ colors.hashCode ^ imageUrl.hashCode ^ timestamp.hashCode;
}