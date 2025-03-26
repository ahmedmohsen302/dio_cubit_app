import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../data_model.dart';

part 'home_cubit_state.dart';

class HomeCubitCubit extends Cubit<HomeCubitState> {
  HomeCubitCubit() : super(HomeCubitInitial());
  final dio = Dio();

  getHomeData() async {
    emit(HomeCubitLoading());
    try {
      var response =
          await dio.get("https://jsonplaceholder.typicode.com/posts");
      print(response.data);
      List<DataModel> data =
          (response.data as List).map((e) => DataModel.fromJson(e)).toList();
      emit(HomeCubitLoaded(data));
    } catch (e) {
      emit(HomeCubitError(e.toString()));
    }
  }
}
