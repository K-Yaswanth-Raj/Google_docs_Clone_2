import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs_clone/colors.dart';
import 'package:google_docs_clone/repository/auth_repo.dart';
import 'package:google_docs_clone/repository/document_repo.dart';
import 'package:routemaster/routemaster.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void signOut(WidgetRef ref) {
    ref.read(authRepoProvider).signOut();
    ref.read(useProvider.notifier).update((state) => null);
  }

  void createDocument(BuildContext context, WidgetRef ref) async {
    String token = ref.read(useProvider)!.token;
    final navigator = Routemaster.of(context);
    final snackbar = ScaffoldMessenger.of(context);
    final errorModel = await ref.read(documentProvider).createDocument(token);
    if (errorModel.data != null) {
      navigator.push('/document/${errorModel.data.id}');
    } else {
      snackbar.showSnackBar(
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
      appBar: AppBar(backgroundColor: KWhiteColor, elevation: 0, actions: [
        IconButton(
          onPressed: () {
            return createDocument(context, ref);
          },
          icon: Icon(
            Icons.add,
            color: KBlackColor,
          ),
        ),
        IconButton(
          onPressed: () {
            return signOut(ref);
          },
          icon: Icon(
            Icons.logout,
            color: KRedColor,
          ),
        ),
      ]),
      body: Center(
        child: Text(
          ref.watch(useProvider)!.uid,
        ),
      ),
    ));
  }
}
