import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/home_cubit_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
                              leading: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  child: Text(state.data[index].id.toString())),
                              title: Text(state.data[index].title),
                              subtitle: Text(state.data[index].body),
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
        ));
  }
}
