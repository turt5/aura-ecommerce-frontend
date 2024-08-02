import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch messages from Firestore
  Stream<List<Map<String, dynamic>>> getMessages(
      String userId, String receiverId) {
    return _db
        .collection('messages')
        .where('userId', isEqualTo: userId)
        .where('receiverId', isEqualTo: receiverId)
        .orderBy('sent')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList());
  }

  // Add a message to Firestore
  Future<void> addMessage(Map<String, dynamic> messageData) async {
    await _db.collection('messages').add(messageData);
  }

  // Fetch users with messages along with the last message and time
  Stream<List<Map<String, dynamic>>> getUsersWithMessages() {
    return _db.collection('messages').snapshots().asyncMap((snapshot) async {
      final userIds = snapshot.docs
          .map((doc) => doc.data()['userId'] as String)
          .toSet()
          .toList();

      // Fetch user details and last message for each userId
      final users = await Future.wait(userIds.map((userId) async {
        final userDoc = await _db.collection('users').doc(userId).get();
        final userData = userDoc.data();

        // Fetch the last message for this user
        final lastMessageQuery = await _db
            .collection('messages')
            .where('userId', isEqualTo: userId)
            .orderBy('sent', descending: true)
            .limit(1)
            .get();

        final lastMessageDoc = lastMessageQuery.docs.isNotEmpty
            ? lastMessageQuery.docs.first.data()
            : null;

        // Fetch unread messages count
        final unreadCountQuery = await _db
            .collection('messages')
            .where('userId', isEqualTo: userId)
            .where('isRead', isEqualTo: false)
            .get();

        return {
          'userId': userId,
          'name': userData?['name'] ?? 'Unknown',
          'imageUrl': userData?['imageUrl'],
          'lastMessage': lastMessageDoc?['content'] ?? '',
          'lastMessageTime': lastMessageDoc?['sent'] ?? '',
          'unreadCount':
              unreadCountQuery.docs.length, // Count of unread messages
        };
      }).toList());

      return users;
    });
  }

// Function to update 'isRead' status for all messages in a selected conversation
  Future<void> markMessagesAsRead(String userId, String receiverId) async {
    try {
      // Get the collection reference for messages
      final messagesRef = _db.collection('messages');

      print('Marking messages as read...');
      print('User ID: $userId');
      print('Receiver ID: $receiverId');

      // Query to find messages between the specified user and receiver
      final query = messagesRef
          .where('userId', isEqualTo: userId)
          .where('receiverId', isEqualTo: receiverId)
          .where('isRead', isEqualTo: false);

      // Fetch messages that match the query
      final querySnapshot = await query.get();

      print("Found ${querySnapshot.docs.length} unread messages.");

      // Check if any documents were returned
      if (querySnapshot.docs.isEmpty) {
        print('No unread messages found.');
        return;
      }

      // Create a batch to update the messages
      final batch = _db.batch();

      // Iterate through the documents and add update operations to the batch
      for (final doc in querySnapshot.docs) {
        print('Updating document ID: ${doc.id}');
        batch.update(doc.reference, {'isRead': true});
      }

      // Commit the batch update
      await batch.commit();
      print('Messages marked as read successfully.');
    } catch (e) {
      // Handle errors with more specific logging
      print('Error updating messages: ${e.toString()}');
    }
  }

  Future<int> countDistinctUsers(String userId) async {
    try {
      final snapshot = await _db
          .collection('messages')
          .where('receiverId', isEqualTo: userId)
          .get();

      // Extract unique sender userIds
      final userIds =
          snapshot.docs.map((doc) => doc.data()['userId'] as String).toSet();

      return userIds.length;
    } catch (e) {
      print('Error counting distinct users: $e');
      return 0;
    }
  }

  // Count unread conversations for a user
  Future<int> countUnreadConversations(String userId) async {
    try {
      final snapshot = await _db
          .collection('messages')
          .where('receiverId', isEqualTo: userId)
          .where('isRead', isEqualTo: false)
          .get();

      // Extract distinct userIds with unread messages
      final unreadUserIds =
          snapshot.docs.map((doc) => doc.data()['userId'] as String).toSet();

      return unreadUserIds.length;
    } catch (e) {
      print('Error counting unread conversations: $e');
      return 0;
    }
  }
}
