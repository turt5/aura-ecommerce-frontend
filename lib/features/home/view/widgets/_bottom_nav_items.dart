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
  });

  final String asset;
  final String label;
  final Color activeColor;
  final Color inactiveColor;
  final bool active;
  final VoidCallback onPressed;
  final bool? notification;

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
            Image.asset(
              asset,
              scale: 1.9,
              color: active ? activeColor : inactiveColor,
            ),
            !active
                ? AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    color: Colors.transparent,
                  )
                : Text(
                    label,
                    style: TextStyle(
                        fontSize: 11,
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
