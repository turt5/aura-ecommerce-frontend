import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../firebase/_user_service.dart';

final firebaseServiceProvider =
    Provider<FirebaseService>((ref) => FirebaseService());

final userProvider = StateProvider<Map<String,dynamic>?>((ref) {
  return null;
});