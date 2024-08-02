import 'package:flutter/material.dart';

class MessageTextField extends StatelessWidget {
  const MessageTextField({super.key, required this.theme, required this.attatchmentPressed, required this.sendPressed, required this.controller});

  final ColorScheme theme;
  final VoidCallback attatchmentPressed;
  final VoidCallback sendPressed;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      // height: 100,
      child: Center(
        child: Container(
          height: 55,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              width: 2,
              color: theme.primary.withOpacity(.3),
            ),
          ),
          child: Row(
            children: [
              InkWell(
                splashColor: theme.primary.withOpacity(.2),
                borderRadius: const  BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
                onTap: attatchmentPressed,
                child: Container(
                  width: 50,
                  margin: const EdgeInsets.only(left: 2, top: 2, bottom: 2),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/icon/attatchment.png',
                      scale: 1.7,
                      color: theme.primary,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Type a message',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ),
              InkWell(
                splashColor: theme.onPrimary,
                highlightColor: theme.onPrimary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
                onTap: sendPressed,
                child: Container(
                  width: 70,
                  margin: EdgeInsets.only(right: 2, top: 2, bottom: 2),
                  decoration: BoxDecoration(
                    color: theme.primary,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child:Image.asset(
                      'assets/icon/send.png',
                      scale: 1.7,
                      color: theme.onPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
