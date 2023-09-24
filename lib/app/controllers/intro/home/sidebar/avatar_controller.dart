import 'package:besafe/app/backend/supabase/client/auth_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AvatarController extends GetxController {
  RxBool isLoading = false.obs;
  RxString imageUrl = ''.obs;

  Future<void> uploadImage() async {
    isLoading.value = true;

    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 300,
      maxHeight: 300,
    );

    if (imageFile == null) {
      isLoading.value = false;
      return;
    }

    try {
      final bytes = await imageFile.readAsBytes();
      final fileExt = imageFile.path.split('.').last;
      final fileName = '${DateTime.now().toIso8601String()}.$fileExt';
      final filePath = fileName;

      await client.storage.from('avatars').uploadBinary(
            filePath,
            bytes,
            fileOptions: FileOptions(contentType: imageFile.mimeType),
          );

      final imageUrlResponse = await client.storage
          .from('avatars')
          .createSignedUrl(filePath, 60 * 60 * 24 * 365 * 10);
      imageUrl.value = imageUrlResponse;
    } catch (error) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred',
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      );
    }
    isLoading.value = false;
  }
}
