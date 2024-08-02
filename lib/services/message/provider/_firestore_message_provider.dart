import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../firebase/_firestore_message.dart';
import '_firestore_provider.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(); // Will be overridden in main.dart
});

final fireStoreMessageProvider = StateNotifierProvider<MessageNotifier, MessageState>((ref) {
  final firestoreService = ref.read(firestoreServiceProvider);
  final sharedPreferences = ref.read(sharedPreferencesProvider);
  final userId = sharedPreferences.getString('userId') ?? '';
  final receiverId = 'oIR4bC6BiwMr3l4BLiJLhxZt8F43';
  return MessageNotifier(firestoreService, userId, receiverId);
});

class MessageState {
  final List<Map<String, dynamic>> messages;

  MessageState(this.messages);
}

class MessageNotifier extends StateNotifier<MessageState> {
  final FirestoreService _firestoreService;
  final String _userId;
  final String _receiverId;

  MessageNotifier(this._firestoreService, this._userId, this._receiverId) : super(MessageState([])) {
    _listenToMessages();
  }

  void _listenToMessages() {
    _firestoreService.getMessages(_userId, _receiverId).listen((messages) {
      state = MessageState(messages);
    });
  }

  Future<void> addMessage(Map<String, dynamic> messageData) async {
    await _firestoreService.addMessage(messageData);
  }
}
