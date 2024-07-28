import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../controller/_account_provider.dart';

Future<void> pickImage(ImagePicker picker, WidgetRef ref) async {
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    ref.read(accountProvider).setImageFile(pickedFile);
}
