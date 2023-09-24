import 'package:besafe/app/backend/supabase/client/auth_client.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService {
  String? avatarUrl;

  Future<void> getProfiles() async {
    try {
      final userId = client.auth.currentUser!.id;
      final data = await client
          .from('profiles')
          .select('*, user_id(id)!')
          .eq('user_id', userId)
          .single();
      avatarUrl = data['avatar_url'];
    } on PostgrestException catch (e) {
      SnackBar(
        content: Text(e.message),
      );
    } catch (e) {
      SnackBar(
        content: Text(e.toString()),
      );
    }
  }
}
