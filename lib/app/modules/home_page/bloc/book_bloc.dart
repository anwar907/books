import 'dart:developer';

import 'package:book/app/data/models/book_models.dart';
import 'package:book/app/data/providers/firstore_providers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  BookBloc() : super(const BookState()) {
    on<LoadBookEvent>(loadBook);
    on<DeleteBookEvent>(delete);
    on<AddBookEvent>(addBook);
    on<UpdateBookEvent>(updateBook);
    on<SelectedDateEvent>(onSelectionChanged);
  }

  final FirestoreProviders _firestoreProviders = FirestoreProviders();

  Future<void> loadBook(LoadBookEvent event, Emitter<BookState> emit) async {
    try {
      emit(state.copyWith(status: BookStatus.loading));
      final books = await _firestoreProviders.getBook().first;

      emit(state.copyWith(status: BookStatus.loaded, listBookModels: books));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), status: BookStatus.error));
    }
  }

  Future<void> addBook(AddBookEvent event, Emitter<BookState> emit) async {
    try {
      emit(state.copyWith(status: BookStatus.loading));

      await _firestoreProviders.addBook(event.bookModels);

      emit(state.copyWith(
          status: BookStatus.loaded, bookModels: event.bookModels));
    } catch (e) {
      emit(state.copyWith(status: BookStatus.error, error: e.toString()));
    }
  }

  Future<void> updateBook(
      UpdateBookEvent event, Emitter<BookState> emit) async {
    try {
      emit(state.copyWith(status: BookStatus.loading));

      await _firestoreProviders.updateBook(event.bookModels);

      final books = await _firestoreProviders.getBook().first;
      emit(state.copyWith(status: BookStatus.loaded, listBookModels: books));
    } catch (e) {
      emit(state.copyWith(status: BookStatus.error, error: e.toString()));
    }
  }

  Future<void> delete(DeleteBookEvent event, Emitter<BookState> emit) async {
    try {
      emit(state.copyWith(status: BookStatus.loading));

      await _firestoreProviders.deleteBook(event.id);
      emit(state.copyWith(status: BookStatus.loaded));
    } catch (e) {
      emit(state.copyWith(status: BookStatus.error, error: e.toString()));
    }
  }

  void onSelectionChanged(SelectedDateEvent event, Emitter<BookState> emit) {
    String selectedDate = '';
    log('tanggal: ${event.args.value}');
    if (event.args.value is DateTime) {
      selectedDate = event.args.value.toString();
    }

    emit(state.copyWith(args: selectedDate));
  }
}
