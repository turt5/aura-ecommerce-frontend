import 'package:attira/features/home/controller/_home_model_provider.dart';
import 'package:attira/main.dart';
import 'package:attira/services/user/firebase/_user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminHomePage extends ConsumerWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final theme = Theme.of(context).colorScheme;
    final read = ref.watch(homeModelProvider);
    final write = ref.read(homeModelProvider);


    return Scaffold(
      backgroundColor: theme.surface,
      body: SafeArea(child: FutureBuilder<Map<String, dynamic>>(
        future: read.getUserData(), // Call the Future method
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Loading indicator
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // Error handling
          } else if (snapshot.hasData) {
            final user = snapshot.data!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(user['name']?.toString() ?? 'No Name'),
                  ],
                ),
                const SizedBox(height: 20,),Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(user['email']?.toString() ?? 'No Email'),
                  ],
                ),
                const SizedBox(height: 20,),Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(user['userId']?.toString() ?? 'No userId'),
                  ],
                ),
                const SizedBox(height: 20,),Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(user['role']?.toString() ?? 'No role'),
                  ],
                ),
                const SizedBox(height: 20,),Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(user['phone']?.toString() ?? 'No phone'),
                  ],
                ),
                const SizedBox(height: 20,),Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   Container(
                     height: 100,
                     width: 100,
                     child: Image.network(user['imageUrl']!.toString()),
                   )
                  ],
                ),
                const SizedBox(height: 20,),// Display user name
                
                SizedBox(
                  width: 150,
                  height: 45,
                  child: ElevatedButton(onPressed: (){
                    FirebaseService firebaseService = FirebaseService();
                    firebaseService.logoutUser();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MyApp()));
                  }, style: ElevatedButton.styleFrom(
                    backgroundColor: CupertinoColors.activeBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),child: Text('Logout')),
                )
              ],
            );
          } else {
            return const Center(child: Text('No data available')); // Handle no data case
          }
        },
      )),
    );
  }
}
