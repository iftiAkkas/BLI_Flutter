import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient supabase = Supabase.instance.client;

  // Signup
  Future<User?> signUp(String email, String password, String fullName) async {
    final res = await supabase.auth.signUp(
      email: email,
      password: password,
    );

    if (res.user != null) {
      // Save profile data
      await supabase.from('profiles').insert({
        'id': res.user!.id,
        'full_name': fullName,
      });
      return res.user;
    }

    return null;
  }

  // Login
  Future<User?> signIn(String email, String password) async {
    final res = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    return res.user;
  }

  // Logout
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  // Forgot password
  Future<void> resetPassword(String email) async {
    await supabase.auth.resetPasswordForEmail(email);
  }
}
