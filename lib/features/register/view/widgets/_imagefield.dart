import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../controller/_account_provider.dart';

Future<void> pickImage(ImagePicker picker, WidgetRef ref) async {
  final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
  ref.read(accountProvider).setImageFile(pickedFile);
}

class ImageField extends StatelessWidget {
  ImageField({super.key, required this.ref});

  final WidgetRef ref;
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final imageFile = ref.watch(accountProvider).imageFile;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          pickImage(picker, ref);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[350],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const  EdgeInsets.all(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.image_outlined,
              color: Colors.grey[700],
            ),
           const SizedBox(width: 10),
            Text(
              imageFile?.name.isEmpty ?? true
                  ? 'Pick a Profile Picture'
                  : imageFile!.name,
              style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
