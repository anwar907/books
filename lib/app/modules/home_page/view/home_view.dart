import 'package:book/app/modules/home_page/bloc/book_bloc.dart';
import 'package:book/app/modules/home_page/view/widgets/form_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/book_items_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('List Book'),
          elevation: 10,
        ),
        body: BlocBuilder<BookBloc, BookState>(builder: (context, state) {
          if (state.status == BookStatus.initial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == BookStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == BookStatus.error) {
            return Center(
              child: Text(state.error ?? ''),
            );
          } else if (state.status == BookStatus.loaded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.listBookModels?.length,
                  itemBuilder: (context, index) {
                    return BookItemWidget(
                        bookModels: state.listBookModels?[index]);
                  }),
            );
          } else {
            return const SizedBox.shrink();
          }
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => FormView()));
          },
          child: const Icon(Icons.add),
        ));
  }
}
