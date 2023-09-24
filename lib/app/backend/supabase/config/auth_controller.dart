import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final SupabaseClient supabaseClient;

  AuthController(this.supabaseClient);

  @override
  void onInit() {
    super.onInit();
    // Daftarkan listener untuk mendengarkan perubahan status otentikasi
    supabaseClient.auth.onAuthStateChange.listen((event) {
      // ignore: unrelated_type_equality_checks
      if (event == AuthChangeEvent.signedIn) {
        // Arahkan pengguna ke halaman beranda
        Get.offAllNamed('/home');
      } else {
        // Arahkan pengguna sesuai status otentikasi saat ini
        navigateToAppropriateScreen();
      }
    });
  }

  // Method untuk menavigasi ke halaman login atau onboarding
  void navigateToAppropriateScreen() {
    final currentUser = supabaseClient.auth.currentUser;
    if (currentUser == null) {
      // Pengguna belum terotentikasi, arahkan ke halaman onboarding
      Get.offAllNamed('/home');
    } else {
      // Pengguna sudah login, arahkan ke halaman login
      Get.toNamed('/splashscreen');
    }
  }
}
