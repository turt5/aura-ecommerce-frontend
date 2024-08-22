import 'package:attira/features/user-dashboard/view/pages/_cart_body.dart';
import 'package:attira/features/user-dashboard/view/pages/_categories_body.dart';
import 'package:attira/features/user-dashboard/view/pages/_home_body.dart';
import 'package:attira/features/user-dashboard/view/pages/_home_profile.dart';
import 'package:attira/features/user-dashboard/view/pages/_user_inbox.dart';
import 'package:attira/features/user-dashboard/view/pages/_user_message.dart';
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
                    ? UserMessageView()
                    : HomeProfilePage();
  }
}
