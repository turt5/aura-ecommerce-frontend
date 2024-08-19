import 'package:attira/services/user/firebase/_user_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminManageUsersProfile extends StatelessWidget {
  const AdminManageUsersProfile(
      {super.key,
      required this.name,
      required this.userId,
      required this.email,
      required this.phone,
      required this.role,
      required this.imageUrl});

  final String name;
  final String userId;
  final String email;
  final String phone;
  final String role;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final FirebaseService fs = FirebaseService();

    return Scaffold(
      backgroundColor: theme.surface,
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: SafeArea(
          child: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (context, a, b) {
                      return CupertinoActivityIndicator(
                        radius: 10,
                        color: theme.primary,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          ListTile(
            tileColor: theme.primary.withOpacity(.2),
            leading: Icon(Icons.person),
            title: Text(
              'UID',
              style: TextStyle(
                color: theme.onSurface.withOpacity(.4),
                fontSize: 11,
              ),
            ),
            subtitle: Text(
              userId,
              style: TextStyle(
                  fontSize: 16,
                  color: theme.onSurface,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            tileColor: theme.primary.withOpacity(.2),
            leading: Icon(Icons.person),
            title: Text(
              'Name',
              style: TextStyle(
                color: theme.onSurface.withOpacity(.4),
                fontSize: 11,
              ),
            ),
            subtitle: Text(
              name,
              style: TextStyle(
                  fontSize: 16,
                  color: theme.onSurface,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            tileColor: theme.primary.withOpacity(.2),
            leading: Icon(Icons.email),
            title: Text(
              'Email',
              style: TextStyle(
                color: theme.onSurface.withOpacity(.4),
                fontSize: 11,
              ),
            ),
            subtitle: Text(
              email,
              style: TextStyle(
                  fontSize: 16,
                  color: theme.onSurface,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            tileColor: theme.primary.withOpacity(.2),
            leading: Icon(Icons.phone),
            title: Text(
              'Phone',
              style: TextStyle(
                color: theme.onSurface.withOpacity(.4),
                fontSize: 11,
              ),
            ),
            subtitle: Text(
              phone,
              style: TextStyle(
                  fontSize: 16,
                  color: theme.onSurface,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10,),
          
          SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(onPressed: (){},style: ElevatedButton.styleFrom(
                backgroundColor: theme.error,
                foregroundColor: theme.onError,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ), child: Text('Delete User',style: TextStyle(
                fontWeight: FontWeight.bold
              ),)))
        ],
      )),
    );
  }
}
