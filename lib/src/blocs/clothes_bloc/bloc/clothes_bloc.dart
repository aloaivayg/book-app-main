import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:book_app/src/model/clothes.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'clothes_event.dart';
part 'clothes_state.dart';

class ClothesBloc extends Bloc<ClothesEvent, ClothesState> {
  ClothesBloc() : super(const DataLoading()) {
    on<GetAllClothesEvent>(onGetAllClothes);
    on<ViewClothesInfoEvent>(onViewClothesInfo);
  }

  void onGetAllClothes(
      GetAllClothesEvent event, Emitter<ClothesState> emit) async {
    final dataState = await Clothes.loadItemsFromBundle();
    emit(const DataLoading());

    if (dataState.isNotEmpty) {
      print("FETCH SUCCES");

      emit(FetchClothesSuccess(dataState));
    } else {
      print("FETCH ERROR");

      emit(FetchClothesError(DioException(requestOptions: RequestOptions())));
    }
  }

  void onViewClothesInfo(
      ViewClothesInfoEvent event, Emitter<ClothesState> emit) async {
    emit(const DataLoading());
    if (event.clothes != null) {
      emit(ViewClothesInfoSuccess(clothes: event.clothes));
    } else {
      emit(FetchClothesError(DioException(requestOptions: RequestOptions())));
    }
  }
}
