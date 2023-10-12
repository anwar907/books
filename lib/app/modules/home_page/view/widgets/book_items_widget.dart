import 'package:book/app/data/models/book_models.dart';
import 'package:book/app/modules/home_page/bloc/book_bloc.dart';
import 'package:book/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookItemWidget extends StatelessWidget {
  BookItemWidget({super.key, required this.bookModels});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _publishedController = TextEditingController();

  final BookModels? bookModels;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        _showButtomSheet(context, bookModels);
      },
      trailing: IconButton(
          onPressed: () {
            context.read<BookBloc>().add(DeleteBookEvent(bookModels?.id ?? ''));
            context.read<BookBloc>().add(LoadBookEvent());
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Book Deleted'),
            ));
          },
          icon: const Icon(Icons.delete)),
      leading: Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
          ),
          child: Center(
            child: Text(
              bookModels?.bookAuthor?.firstValue().toUpperCase() ?? '',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          )),
      title: Text(bookModels?.bookName ?? ''),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(bookModels?.bookAuthor ?? '',
              style: const TextStyle(color: Colors.grey)),
          Text(''.parseDate(bookModels?.publishedDate))
        ],
      ),
    );
  }

  void _showButtomSheet(BuildContext context, BookModels? data) {
    showModalBottomSheet(
        context: context,
        elevation: 1,
        enableDrag: true,
        builder: (context) {
          _nameController.text = data?.bookName ?? '';
          _authorController.text = data?.bookAuthor ?? '';
          _publishedController.text = data?.publisher ?? '';
          return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _authorController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _publishedController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    OutlinedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<BookBloc>().add(UpdateBookEvent(
                                BookModels(
                                    id: data?.id,
                                    bookName: _nameController.text,
                                    bookAuthor: _authorController.text,
                                    publisher: _publishedController.text)));
                            context.read<BookBloc>().add(LoadBookEvent());
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Please fill the form'),
                            ));
                          }
                        },
                        child: const Icon(Icons.save))
                  ],
                ),
              ));
        });
  }
}
