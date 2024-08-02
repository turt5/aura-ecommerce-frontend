import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch messages from Firestore
  Stream<List<Map<String, dynamic>>> getMessages(String userId, String receiverId) {
    return _db
        .collection('messages')
        .where('userId', isEqualTo: userId)
        .where('receiverId', isEqualTo: receiverId)
        .orderBy('sent')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList());
  }

  // Add a message to Firestore
  Future<void> addMessage(Map<String, dynamic> messageData) async {
    await _db.collection('messages').add(messageData);
  }

  // Fetch users with messages along with the last message and time
  Stream<List<Map<String, dynamic>>> getUsersWithMessages() {
    return _db.collection('messages').snapshots().asyncMap((snapshot) async {
      final userIds = snapshot.docs.map((doc) => doc.data()['userId'] as String).toSet().toList();

      // Fetch user details and last message for each userId
      final users = await Future.wait(userIds.map((userId) async {
        final userDoc = await _db.collection('users').doc(userId).get();
        final userData = userDoc.data();

        // Fetch the last message for this user
        final lastMessageQuery = await _db.collection('messages')
            .where('userId', isEqualTo: userId)
            .orderBy('sent', descending: true)
            .limit(1)
            .get();

        final lastMessageDoc = lastMessageQuery.docs.isNotEmpty ? lastMessageQuery.docs.first.data() : null;

        return {
          'userId': userId,
          'name': userData?['name'] ?? 'Unknown',
          'imageUrl': userData?['imageUrl'],
          'lastMessage': lastMessageDoc?['content'] ?? '',
          'lastMessageTime': lastMessageDoc?['sent'] ?? '',
        };
      }).toList());

      return users;
    });
  }
}
