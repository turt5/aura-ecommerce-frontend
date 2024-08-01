import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blur/blur.dart';

final GlobalKey<_CustomDialogState> _dialogKey =
    GlobalKey<_CustomDialogState>();

class CustomDialog extends StatefulWidget {
  const CustomDialog({super.key});

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  void closeDialog() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Dialog(
      insetAnimationDuration: const Duration(milliseconds: 300),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 140,
        width: 140,
        decoration: BoxDecoration(
          color: theme.surface,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoActivityIndicator(
                  radius: 10,
                  color: theme.primary,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Please wait...',
                  style: TextStyle(
                    color: theme.primary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).frosted(
      blur: 20,
      frostOpacity: .1,
      frostColor: Colors.white.withOpacity(0.1),
    );
  }
}

void showCustomDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return CustomDialog(key: _dialogKey);
    },
  );
}

void closeCustomDialog() {
  if (_dialogKey.currentState != null) {
    _dialogKey.currentState!.closeDialog();
  }
}
