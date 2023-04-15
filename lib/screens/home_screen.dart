import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs_clone/colors.dart';
import 'package:google_docs_clone/repository/auth_repo.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void signOut(WidgetRef ref ){
    ref.read(authRepoProvider).signOut();
    ref.read(useProvider.notifier).update((state) => null);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(backgroundColor: KWhiteColor, elevation: 0, actions: [
        IconButton(
          onPressed: () {},
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
