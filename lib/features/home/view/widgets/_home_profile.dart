import 'package:attira/features/home/controller/_home_model_provider.dart';
import 'package:attira/features/home/view/widgets/_custom_app_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeProfilePage extends ConsumerWidget {
  const HomeProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;
    final homeRead = ref.watch(homeModelProvider);

    return Scaffold(
      appBar: CustomAppBar(title: "Profile", theme: theme),
      body: FutureBuilder<Map<String, dynamic>>(
          future: homeRead.getUserData(),
          builder: (context, snapshot) {
            if (snapshot.hasData && !snapshot.hasError) {
              final data = snapshot.data!;
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                physics: const BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 150,
                    child: Center(
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: data['imageUrl'],
                          progressIndicatorBuilder: (context, url, progress) {
                            return Center(
                              child: CupertinoActivityIndicator(
                                radius: 9,
                                color: theme.primary,
                              ),
                            );
                          },
                          fit: BoxFit.cover, // Ensure the image covers the circle
                          height: 120, // Set height to a fixed value
                          width: 120, // Set width to the same fixed value
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(data['name'],style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),)
                    ],
                  ),
                  const SizedBox(height: 20,),
                  
                  CustomListTile(title: "Phone",subTitle:data['phone'],theme:theme,iconData: Icons.phone,),
                  const SizedBox(height: 10,),
                  
                  CustomListTile(title: "Email",subTitle:data['email'],theme:theme,iconData: Icons.email,),
                  
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CupertinoActivityIndicator(
                  radius: 12,
                  color: theme.primary,
                ),
              );
            } else {
              return const Center(
                child: Text("Something went wrong!"),
              );
            }
          }),
    );
  }
}


class CustomListTile extends StatelessWidget {
  const CustomListTile({super.key, required this.title, required this.theme, required this.iconData, required this.subTitle});

  final String title;
  final ColorScheme theme;
  final IconData iconData;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.primary.withOpacity(.05),
        borderRadius: BorderRadius.circular(10)
      ),
      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
      child: Row(
        children: [
          Icon(iconData,color: theme.onSurface,),
          const SizedBox(width: 20,),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title,style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11,
                color: theme.primary.withOpacity(.5)
              ),),
              const SizedBox(height: 5,),
              Row(
                children: [
                  Text(subTitle,
                  maxLines: 2,
                   style: TextStyle(
                    color: theme.onSurface
                  ),),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
