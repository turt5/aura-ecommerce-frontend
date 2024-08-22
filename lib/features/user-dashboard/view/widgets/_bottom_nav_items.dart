import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  const NavItem({
    super.key,
    required this.asset,
    required this.label,
    required this.activeColor,
    required this.inactiveColor,
    required this.active,
    required this.onPressed,
    this.notification,
    this.iconData,
    this.notificationCount,
    this.scale
  });

  final String asset;
  final String label;
  final Color activeColor;
  final Color inactiveColor;
  final bool active;
  final VoidCallback onPressed;
  final bool? notification;
  final IconData? iconData;
  final int? notificationCount;
  final double? scale;

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
            iconData != null
                ? Icon(
                    iconData,
                    color: active ? activeColor : inactiveColor,
                  )
                : Stack(
                    children: [
                      Image.asset(
                        asset,
                        scale: scale?? 1.9,
                        color: active ? activeColor : inactiveColor,
                      ),
                      notification ==true
                          ? Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    color: Colors.red, shape: BoxShape.circle),
                                child: Text(
                                  notificationCount.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 9),
                                ),
                              ))
                          : SizedBox.shrink(),
                    ],
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
