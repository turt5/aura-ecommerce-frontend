import 'package:attira/features/home/view/widgets/_admin_convo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../services/message/provider/_firestore_provider.dart';

class AdminInbox extends ConsumerWidget {
  const AdminInbox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firestoreService = ref.watch(firestoreServiceProvider);

    return Scaffold(
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: firestoreService.getUsersWithMessages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CupertinoActivityIndicator(
              radius: 10,
              color: Theme.of(context).colorScheme.primary,
            ));
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No users with messages'));
          }

          final users = snapshot.data!;

          // Sort users by latest message time
          users.sort((a, b) {
            return DateTime.parse(b['lastMessageTime']).compareTo(DateTime.parse(a['lastMessageTime']));
          });

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              final userId = user['userId'];
              final userName = user['name'];
              final userImage = user['imageUrl'];
              final lastMessage = user['lastMessage'];
              final lastMessageTime = user['lastMessageTime'];
              final lastMessageTimeParts = lastMessageTime.toString().split(" ")[1].split(":");
              final unreadCount = user['unreadCount']; // Unread count

              return Container(
                margin: EdgeInsets.only(bottom: 5),
                child: ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        imageUrl: userImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Row(
                    children: [
                      Expanded(child: Text(userName,maxLines: 1,overflow: TextOverflow.ellipsis,)),
                      unreadCount>0? Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle
                        ),
                        padding: EdgeInsets.all(8),
                        child: Text(unreadCount.toString(),style: TextStyle(
                          fontSize: 10,
                          color: Colors.white
                        ),),
                      ):const SizedBox.shrink()
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      Expanded(
                        child: Text(
                          lastMessage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: unreadCount>0?FontWeight.bold:FontWeight.normal
                          ),
                        ),
                      ),
                      Text(
                        "${lastMessageTimeParts[0]}:${lastMessageTimeParts[1]}",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: unreadCount>0?FontWeight.bold:FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  onTap: () async {
                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                    String myId = prefs.getString('userId')?? " ";
                    firestoreService.markMessagesAsRead(myId, userId);
                    print(unreadCount);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminConvo(
                          userId: userId,
                          name: userName,
                          imageUrl: userImage,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
