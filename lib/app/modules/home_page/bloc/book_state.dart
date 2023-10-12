part of 'book_bloc.dart';

enum BookStatus { initial, loading, loaded, error }

class BookState extends Equatable {
  const BookState(
      {this.status = BookStatus.initial,
      this.listBookModels,
      this.error,
      this.args,
      this.bookModels});

  final BookStatus status;
  final List<BookModels>? listBookModels;
  final BookModels? bookModels;
  final String? error;
  final String? args;

  BookState copyWith({
    BookStatus? status,
    List<BookModels>? listBookModels,
    BookModels? bookModels,
    String? args,
    String? error,
  }) {
    return BookState(
        bookModels: bookModels ?? this.bookModels,
        status: status ?? this.status,
        listBookModels: listBookModels ?? this.listBookModels,
        args: args ?? this.args,
        error: error ?? this.error);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, listBookModels, error, bookModels, args];
}
