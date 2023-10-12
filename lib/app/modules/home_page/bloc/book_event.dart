part of 'book_bloc.dart';

@immutable
sealed class BookEvent {}

class LoadBookEvent extends BookEvent {}

class AddBookEvent extends BookEvent {
  final BookModels bookModels;

  AddBookEvent(this.bookModels);
}

class UpdateBookEvent extends BookEvent {
  final BookModels bookModels;
  UpdateBookEvent(this.bookModels);
}

class DeleteBookEvent extends BookEvent {
  final String id;
  DeleteBookEvent(this.id);
}

class SelectedDateEvent extends BookEvent {
  final DateRangePickerSelectionChangedArgs args;

  SelectedDateEvent(this.args);
}
