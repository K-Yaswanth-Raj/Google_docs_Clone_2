import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final authRepoProvider = Provider<AuthRepo>((ref) {
  return AuthRepo(
    googleSignIn: GoogleSignIn(),
  );
});

class AuthRepo {
  final GoogleSignIn _googleSignIn;

  AuthRepo({
    required GoogleSignIn googleSignIn,
  }) : _googleSignIn = googleSignIn;

  void signInWithGoogle() async {
    try {
      final user = await _googleSignIn.signIn();
      if (user != null) {
        print(user.email);
        print(user.displayName);
      }
    } catch (e) {
      print(e);
    }
  }
}
