import 'package:book/app/data/models/book_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreProviders {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('book');

  Stream<List<BookModels>> getBook() {
    return _collectionReference.snapshots().map((event) {
      return event.docs.map((e) {
        Map<String, dynamic> data = e.data() as Map<String, dynamic>;

        Timestamp? datetime = data['release_years'];

        return BookModels(
            id: e.id,
            bookAuthor: data['name_author'],
            bookName: data['name'],
            publisher: data['name_publish'],
            publishedDate: datetime?.toDate());
      }).toList();
    });
  }

  Future<void> addBook(BookModels book) {
    return _collectionReference.add({
      'name': book.bookName,
      'name_author': book.bookAuthor,
      'name_publish': book.publisher,
      'release_years': book.publishedDate
    });
  }

  Future<void> updateBook(BookModels book) {
    return _collectionReference.doc(book.id).update({
      'name': book.bookName,
      'name_author': book.bookAuthor,
      'name_publish': book.publisher,
      'release_years': book.publishedDate
    });
  }

  Future<void> deleteBook(String id) {
    return _collectionReference.doc(id).delete();
  }
}
