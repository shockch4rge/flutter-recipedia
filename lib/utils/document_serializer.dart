import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class DocumentSerializer
    implements JsonConverter<DocumentReference, DocumentReference> {
  const DocumentSerializer();

  @override
  DocumentReference fromJson(DocumentReference docRef) => docRef;

  @override
  DocumentReference toJson(DocumentReference docRef) => docRef;
}
