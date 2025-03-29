import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../data_model.dart';

part 'home_cubit_state.dart';

class HomeCubitCubit extends Cubit<HomeCubitState> {
  HomeCubitCubit() : super(HomeCubitInitial());
  final dio = Dio();
  List<dataModel> posts = [];

  getHomeData() async {
    emit(HomeCubitLoading());
    try {
      var response =
          await dio.get("https://jsonplaceholder.typicode.com/posts");
      List<dataModel> data =
          (response.data as List).map((e) => dataModel.fromJson(e)).toList();
      posts = data;
      emit(HomeCubitLoaded(posts));
    } catch (e) {
      emit(HomeCubitError(e.toString()));
    }
  }

  Future<void> addPost(String title, String body) async {
    try {
      Response response = await dio.post(
        'https://jsonplaceholder.typicode.com/posts',
        data: {
          "title": title,
          "body": body,
          "userId": 1,
        },
        options: Options(headers: {"Content-Type": "application/json"}),
      );
      print("Status Code: ${response.statusCode}");
      print("Response Data: ${response.data}");

      dataModel newPost = dataModel.fromJson(response.data);

      final currentState = state;
      if (currentState is HomeCubitLoaded) {
        posts = List.from(currentState.data);
        print(response.data);
      }

      posts.insert(0, newPost);
      emit(
        HomeCubitLoaded(
          List.from(posts),
        ),
      );
    } catch (e) {
      emit(HomeCubitError("Failed to add post"));
    }
  }
}
