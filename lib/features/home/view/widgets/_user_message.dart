import 'dart:io';

import 'package:attira/services/message/provider/_firestore_message_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../services/message/provider/_firestore_provider.dart';
import '_message_textfield.dart';

class UserMessageView extends ConsumerWidget {
  UserMessageView({super.key});

  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firestoreService = ref.watch(firestoreServiceProvider);
    final userId = ref.watch(sharedPreferencesProvider).getString('userId') ?? '';
    const receiverId = 'oIR4bC6BiwMr3l4BLiJLhxZt8F43';

    // Fetch messages from Firestore
    final messageStream = firestoreService.getMessages(userId, receiverId);


    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text('Inbox'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        toolbarHeight: 70,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.white,
                child: StreamBuilder<List<Map<String, dynamic>>>(
                  stream: firestoreService.getMessages(userId, receiverId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No messages'));
                    }

                    final messages = snapshot.data!;
                    final theme = Theme.of(context).colorScheme;
                    final w = MediaQuery.of(context).size.width;

                    // Sort messages by time
                    final sortedMessages = messages..sort((a, b) {
                      return DateTime.parse(a['sent']).compareTo(DateTime.parse(b['sent']));
                    });

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      // Ensure that the ScrollController is attached before scrolling
                      if (_scrollController.hasClients) {
                        _scrollToBottom();
                      }
                    });

                    return ListView.builder(
                      controller: _scrollController,
                      reverse: false,
                      itemCount: sortedMessages.length,
                      itemBuilder: (context, index) {
                        final message = sortedMessages[index];
                        final isUserMessage = message['from'] == 'user';

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                          child: Align(
                            alignment: isUserMessage
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              constraints: BoxConstraints(maxWidth: w * 0.7),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: message['from'] == 'user' ? null : Border.all(
                                    width: 2,
                                    color: theme.primary
                                ),
                                color: isUserMessage
                                    ? theme.primary
                                    : Colors.transparent,
                              ),
                              child: Column(
                                crossAxisAlignment: isUserMessage
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  if (message['image'] != null)
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.file(
                                        File(message['image']),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  Text(
                                    message['content'] ?? '',
                                    maxLines: null,
                                    style: TextStyle(
                                      color: message['from'] == 'user' ? theme.onPrimary : theme.primary,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    _formatTimestamp(message['sent']),
                                    style: TextStyle(
                                      color: message['from'] == 'user' ? theme.onPrimary.withOpacity(0.6) : theme.primary.withOpacity(0.5),
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              )

            ),
            MessageTextField(
              theme: Theme.of(context).colorScheme,
              attatchmentPressed: () async {
                final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  firestoreService.addMessage({
                    'content': null,
                    'image': image.path,
                    'from': 'user',
                    'sent': DateTime.now().toString(),
                    'userId': userId, // Add user ID
                    'receiverId': receiverId, // Add receiver ID
                    'isRead': false
                  });
                }
              },
              sendPressed: () {
                String message = _messageController.text.trim();
                if (message.isNotEmpty || _selectedImage != null) {
                  firestoreService.addMessage({
                    'content': message,
                    'image': _selectedImage?.path,
                    'from': 'user',
                    'sent': DateTime.now().toString(),
                    'userId': userId, // Add user ID
                    'receiverId': receiverId, // Add receiver ID
                    'isRead': false
                  });
                  _messageController.clear();
                  _selectedImage = null;
                  // Ensure that the ScrollController is attached before scrolling
                  if (_scrollController.hasClients) {
                    _scrollToBottom();
                  }
                }
              },
              controller: _messageController,
            ),
          ],
        ),
      ),
    );
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  String _formatTimestamp(String timestamp) {
    final DateTime dateTime = DateTime.parse(timestamp);
    final int hour = dateTime.hour;
    final int minute = dateTime.minute;
    final String period = hour >= 12 ? 'PM' : 'AM';
    final int formattedHour = hour > 12 ? hour - 12 : hour == 0 ? 12 : hour;

    return '$formattedHour:${minute.toString().padLeft(2, '0')} $period';
  }
}
