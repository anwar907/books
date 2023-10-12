import 'package:book/app/data/models/book_models.dart';
import 'package:book/app/modules/home_page/bloc/book_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class FormView extends StatelessWidget {
  FormView({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _bookNameController = TextEditingController();
  final TextEditingController _bookAuthorController = TextEditingController();
  final TextEditingController _publishedController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Form'),
          elevation: 10,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: _bookNameController,
                    decoration: const InputDecoration(hintText: 'Book Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _bookAuthorController,
                    decoration: const InputDecoration(hintText: 'Book Author'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _publishedController,
                    decoration:
                        const InputDecoration(hintText: 'Book Publisher'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  BlocBuilder<BookBloc, BookState>(builder: (context, state) {
                    return Column(
                      children: [
                        SfDateRangePicker(
                          onSelectionChanged: (value) {
                            context
                                .read<BookBloc>()
                                .add(SelectedDateEvent(value));
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        OutlinedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate() &&
                                  state.args != null) {
                                context.read<BookBloc>().add(AddBookEvent(
                                    BookModels(
                                        bookName: _bookNameController.text,
                                        bookAuthor: _bookAuthorController.text,
                                        publisher: _publishedController.text,
                                        publishedDate: DateTime.parse(
                                            state.args.toString()))));
                                Navigator.of(context).maybePop(true);
                              } else {
                                if (state.args == null) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text('Please fill the Date'),
                                  ));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text('Please fill the form'),
                                  ));
                                }
                              }
                            },
                            child: const Icon(Icons.save))
                      ],
                    );
                  }),
                ],
              )),
        ),
      ),
    );
  }
}
