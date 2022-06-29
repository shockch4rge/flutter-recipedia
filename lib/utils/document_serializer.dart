import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

// this special DocumentSerializer class is used to map Firestore's DocumentReferences from/to JSON data.
// this way our models remain easy to query and safely-typed.
class DocumentSerializer
    implements JsonConverter<DocumentReference, DocumentReference> {
  const DocumentSerializer();

  @override
  DocumentReference fromJson(DocumentReference docRef) => docRef;

  @override
  DocumentReference toJson(DocumentReference docRef) => docRef;
}
