import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs_clone/repository/auth_repo.dart';

import '../colors.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  void signInWithGoogle(WidgetRef ref){
    ref.read(authRepoProvider).signInWithGoogle();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ElevatedButton.icon(
            onPressed: () => signInWithGoogle(ref),
            icon: Image.asset(
              'assets/images/g-logo-2.png',
              height: 28,
            ),
            label: Text(
              'Sign in with Google',
              style: TextStyle(color: KBlackColor),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: KWhiteColor,
              minimumSize: Size(170, 70),
            ),
          ),
        ),
      ),
    );
  }
}
