import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;



  Future<bool> registerUser(String name, XFile image, String phone,
      String email, String password, String role) async {
    try {
      // Register user for authentication

      UserCredential _userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? _user = _userCredential.user;

      // failed to create user auth service
      if (_user == null) {
        return false;
      }

      // Upload image to firebase storage
      String imagePath = 'user_images/${_user.uid}/${image.name}';
      UploadTask uploadTask = _firebaseStorage.ref(imagePath).putFile(
            File(image.path),
          );
      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();

      // Add user data to firestore
      await _firebaseFirestore.collection('users').doc(_user.uid).set({
        'name': name,
        'phone': phone,
        'email': email,
        'role': role,
        'imageUrl': imageUrl,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      if (user == null) return null;

      DocumentSnapshot userDoc =
      await _firebaseFirestore.collection('users').doc(user.uid).get();
      Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
      preferences.setString('userId', user.uid);
      preferences.setString('role', userData!['role']);
      preferences.setString('imageUrl', userData!['imageUrl']);
      preferences.setString('phone', userData!['phone']);
      preferences.setString('email', userData!['email']);
      preferences.setString('name', userData!['name']);

      return userDoc.data() as Map<String, dynamic>?;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'invalid-credential') {
        return {
          "error" : "Wrong credential"
        };
      } else {
        return {
          "error" : "An unknown error occurred!"
        };
      }
      return null;
    } catch (e) {
      return {
        "error" : "An unknown error occurred!"
      };
    }
  }


  Future<void> logoutUser() async {
    SharedPreferences pref= await SharedPreferences.getInstance();
    pref.remove('userId');
    pref.remove('email');
    pref.remove('role');
    pref.remove('name');
    pref.remove('phone');
    pref.remove('imageUrl');
    await FirebaseAuth.instance.signOut();
  }

  Future<int> countUsers() async {
    try {
      QuerySnapshot userCollection = await _firebaseFirestore.collection('users').get();
      return userCollection.docs.length;
    } catch (e) {
      print('Error counting users: $e');
      return 0; // or handle the error as needed
    }
  }

}
