import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs_clone/colors.dart';
import 'package:google_docs_clone/model/docu_model.dart';
import 'package:google_docs_clone/model/error_model.dart';
import 'package:google_docs_clone/repository/auth_repo.dart';
import 'package:google_docs_clone/repository/document_repo.dart';

class DocumentScreen extends ConsumerStatefulWidget {
  final String id;
  const DocumentScreen({super.key, required this.id});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends ConsumerState<DocumentScreen> {
  TextEditingController titleController =
      TextEditingController(text: 'Untitled Document');
  final quill.QuillController _controller = quill.QuillController.basic();
  ErrorModel? errorModel;
  @override
  void initState() {
    super.initState();
    fetchDocumentData();
  }

  void fetchDocumentData() async {
   errorModel = await ref
        .read(documentProvider)
        .getDocumentById(ref.read(userProvider)!.token, widget.id);

        if(errorModel!.data != null){
          titleController.text = (errorModel!.data as DocumentModel).title;
          setState(() {
            
          });
        }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
  }

  void updateTitle(WidgetRef ref, String title) {
    ref.read(documentProvider).updateTitle(
          token: ref.read(userProvider)!.token,
          title: title,
          id: widget.id,
        );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: KWhiteColor,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.lock,
                  size: 16,
                ),
                label: Text('Share'),
                style: ElevatedButton.styleFrom(backgroundColor: KBlueColor),
              ),
            )
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: KGrayColor, width: 0.1),
              ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 9.0),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/docs-logo.png',
                  height: 40,
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 180,
                  child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: KBlueColor,
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 10),
                    ),
                    onSubmitted: (value) {
                      return updateTitle(ref, value);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                quill.QuillToolbar.basic(controller: _controller)
              ]),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  child: SizedBox(
                    width: 750,
                    child: Card(
                      color: KWhiteColor,
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: quill.QuillEditor.basic(
                          controller: _controller,
                          readOnly: false, // true for view only mode
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
