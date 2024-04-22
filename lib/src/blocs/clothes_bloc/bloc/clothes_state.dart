part of 'clothes_bloc.dart';

class ClothesState extends Equatable {
  final List<Clothes>? clothesList;
  final DioException? error;

  const ClothesState({this.clothesList, this.error});
  @override
  List<Object> get props => [clothesList!, error!];
}

class DataLoading extends ClothesState {
  const DataLoading();
}

class FetchClothesSuccess extends ClothesState {
  const FetchClothesSuccess(List<Clothes> clothes)
      : super(clothesList: clothes);
}

class FetchClothesError extends ClothesState {
  const FetchClothesError(DioException error) : super(error: error);
}

class ViewClothesInfoSuccess extends ClothesState {
  final Clothes clothes;
  const ViewClothesInfoSuccess({required this.clothes});
}
