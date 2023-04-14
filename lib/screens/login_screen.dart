import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs_clone/repository/auth_repo.dart';
import 'package:google_docs_clone/screens/home_screen.dart';

import '../colors.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  void signInWithGoogle(WidgetRef ref, BuildContext context) async {
    final errorModel = await ref.read(authRepoProvider).signInWithGoogle();
    if (errorModel.error == null) {
      ref.read(useProvider.notifier).update((state) => errorModel.data);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorModel.error!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ElevatedButton.icon(
            onPressed: () => signInWithGoogle(ref, context),
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
