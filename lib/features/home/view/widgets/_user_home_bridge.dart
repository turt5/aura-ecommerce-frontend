import 'package:attira/features/home/view/widgets/_cart_body.dart';
import 'package:attira/features/home/view/widgets/_categories_body.dart';
import 'package:attira/features/home/view/widgets/_home_body.dart';
import 'package:attira/features/home/view/widgets/_home_profile.dart';
import 'package:attira/features/home/view/widgets/_user_inbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserHomeBridge extends StatelessWidget {
  const UserHomeBridge({super.key, required this.read});

  final dynamic read;

  @override
  Widget build(BuildContext context) {
    return read.selected == 0
        ? HomeBody()
        : read.selected == 1
            ? CategoriesBody()
            : read.selected == 2
                ? CartBody()
                : read.selected == 3
                    ? UserInbox()
                    : HomeProfilePage();
  }
}
