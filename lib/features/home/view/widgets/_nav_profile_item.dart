import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavProfileItem extends StatelessWidget {
  const NavProfileItem({
    super.key,
    required this.url,
    required this.label,
    required this.activeColor,
    required this.inactiveColor,
    required this.active,
    required this.onPressed,
    this.notification,
    this.iconData,
  });

  final String url;
  final String label;
  final Color activeColor;
  final Color inactiveColor;
  final bool active;
  final VoidCallback onPressed;
  final bool? notification;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 28,
              height: 28,
              padding: EdgeInsets.all(2),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2,
                  color: active?activeColor:inactiveColor
                )
              ),
              child: CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, _, d) {
                  return Center(
                    child: CupertinoActivityIndicator(
                      radius: 8,
                    ),
                  );
                },
                errorWidget: (context, _, d) {
                  return Center(
                    child: Icon(iconData),
                  );
                },
              ),
            ),
            !active
                ? AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    color: Colors.transparent,
                  )
                : Text(
                    label,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 10,
                        color: active ? activeColor : inactiveColor,
                        fontWeight:
                            active ? FontWeight.bold : FontWeight.normal),
                  )
          ],
        ),
      ),
    );
  }
}
