import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs_clone/colors.dart';
import 'package:google_docs_clone/common/widgets/loader.dart';
import 'package:google_docs_clone/model/docu_model.dart';
import 'package:google_docs_clone/model/error_model.dart';
import 'package:google_docs_clone/repository/auth_repo.dart';
import 'package:google_docs_clone/repository/document_repo.dart';
import 'package:routemaster/routemaster.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void signOut(WidgetRef ref) {
    ref.read(authRepoProvider).signOut();
    ref.read(userProvider.notifier).update((state) => null);
  }

  void createDocument(BuildContext context, WidgetRef ref) async {
    String token = ref.read(userProvider)!.token;
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

  void navigateToDocument(BuildContext context, String documentId) {
    Routemaster.of(context).push('/document/$documentId');
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
        body: FutureBuilder<ErrorModel>(
          future: ref.watch(documentProvider).getDocument(
                ref.watch(userProvider)!.token,
              ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loader();
            }

            return Center(
                child: Container(
              width: 600,
              margin: const EdgeInsets.only(top: 10),
              child: ListView.builder(
                itemCount: snapshot.data!.data.length,
                itemBuilder: (context, index) {
                  DocumentModel document = snapshot.data!.data[index];
                  return InkWell(
                    onTap: () => navigateToDocument(context, document.id),
                    child: SizedBox(
                      height: 50,
                      child: Card(
                        child: Center(
                          child: Text(
                            document.title,
                            style: const TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ));
          },
        ),
      ),
    );
  }
}
