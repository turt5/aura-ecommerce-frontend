import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseProductService {
  final FirebaseFirestore _firestoreDB = FirebaseFirestore.instance;
  final String _collectionPath = 'categories';

  // Future<void> addSection(String sectionName) async {
  //   try {
  //     await _firestoreDB.collection('sections').add(
  //         {'name': sectionName, 'timeStamp': FieldValue.serverTimestamp()});
  //   } catch (e) {
  //     print(e);
  //   }
  // }


  // Stream<List<Section>> getSections(){
  //   return _firestoreDB.collection('sections').snapshots().map((snapshot){
  //     final sections = snapshot.docs.map((doc){
  //       final data = doc.data();
  //       return Section.fromFirestore(doc.id, data);
  //     }).toList();
  //
  //     return sections;
  //   });
  // }

  // Future<void> removeSection(String id)async{
  //   try{
  //     _firestoreDB.collection('sections').doc(id).delete();
  //   }catch(e){
  //     print(e);
  //   }
  // }

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
