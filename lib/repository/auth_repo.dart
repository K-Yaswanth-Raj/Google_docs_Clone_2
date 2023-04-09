import 'dart:convert';

import 'package:google_docs_clone/constants.dart';
import 'package:http/http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs_clone/model/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

final authRepoProvider = Provider<AuthRepo>((ref) {
  return AuthRepo(googleSignIn: GoogleSignIn(), client: Client());
});

class AuthRepo {
  final GoogleSignIn _googleSignIn;
  final Client _client;
  AuthRepo({required GoogleSignIn googleSignIn, required Client client})
      : _googleSignIn = googleSignIn,
        _client = client;

  void signInWithGoogle() async {
    try {
      final user = await _googleSignIn.signIn();
      if (user != null) {
        final userAcc = UserModel(
            email: user.email, name: user.displayName!, uid: '', token: '');
        var res = await _client.post(Uri.parse('$host/api/signup'),
            body: userAcc.toJson(),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            });

        switch (res.statusCode) {
          case 200:
            final newUser = userAcc.copyWith(
              uid: jsonDecode(res.body)['user']['_id'],
            );
            break;
          
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
