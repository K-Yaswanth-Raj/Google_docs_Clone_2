import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs_clone/model/docu_model.dart';
import 'package:http/http.dart';
import 'package:google_docs_clone/model/error_model.dart';

import '../constants.dart';

final documentProvider = Provider<DocumentRepository>((ref) {
  return DocumentRepository(client: Client());
});

class DocumentRepository {
  final Client _client;
  DocumentRepository({required Client client}) : _client = client;

  Future<ErrorModel> createDocument(String token) async {
    ErrorModel error = ErrorModel(error: 'Some Error has Occured', data: null);
    try {
      var res = await _client.post(
        Uri.parse('$host/doc/create'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
        body: jsonEncode({
          'createdAt': DateTime.now().millisecondsSinceEpoch,
        }),
      );
      switch (res.statusCode) {
        case 200:
          error = ErrorModel(
            error: null,
            data: DocumentModel.fromJson(res.body),
          );
          break;
        default:
          error = ErrorModel(error: res.body, data: null);
          break;
      }
    } catch (e) {
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }
}
