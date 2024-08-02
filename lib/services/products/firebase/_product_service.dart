import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseProductService {
  final FirebaseFirestore _firestoreDB = FirebaseFirestore.instance;
  final String _collectionPath = 'categories';

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
            final data = doc.data() as Map<String, dynamic>;
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
}

