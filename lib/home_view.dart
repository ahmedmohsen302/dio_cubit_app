import 'package:animate_do/animate_do.dart';
import 'package:dio_cubit_app/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/home_cubit_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  void showAddPostDialog(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController bodyController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Post"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Title"),
              ),
              TextField(
                controller: bodyController,
                decoration: const InputDecoration(labelText: "Body"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Close dialog
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    bodyController.text.isNotEmpty) {
                  context.read<HomeCubitCubit>().addPost(
                        titleController.text,
                        bodyController.text,
                      );
                  Navigator.pop(context); // Close dialog after submission
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'New Task',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<HomeCubitCubit, HomeCubitState>(
        builder: (context, state) {
          return state is HomeCubitLoading
              ? const Center(child: CircularProgressIndicator())
              : state is HomeCubitLoaded
                  ? ListView.builder(
                      itemCount: state.data.length,
                      itemBuilder: (context, index) {
                        return FadeInLeft(
                          delay: Duration(milliseconds: 100 * index),
                          child: ListTile(
                            leading: BounceInDown(
                              delay: Duration(milliseconds: 100 * index),
                              child: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  child: Text(state.data[index].id.toString())),
                            ),
                            title: SlideInLeft(
                                delay: Duration(milliseconds: 100 * index),
                                child: Text(state.data[index].title)),
                            subtitle: ElasticInRight(
                                delay: Duration(milliseconds: 100 * index),
                                child: Text(state.data[index].body)),
                          ),
                        );
                      },
                    )
                  : state is HomeCubitError
                      ? Center(
                          child: Text(state.message),
                        )
                      : Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddPostDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
