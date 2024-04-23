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
  final bool isEnabled;
  final int cartQuantity;

  const ViewClothesInfoSuccess({
    required this.clothes,
    required this.isEnabled,
    required this.cartQuantity,
  });
}

class AddToCartEnabled extends ClothesState {
  final bool isEnabled = true;
  final Clothes clothes;
  const AddToCartEnabled({required this.clothes});
}

class AddToCartDisabled extends ClothesState {
  final bool isEnabled = false;
  final Clothes clothes;
  const AddToCartDisabled({required this.clothes});
}

class ViewCartSuccess extends ClothesState {
  final List<Clothes> clothesList;
  const ViewCartSuccess({required this.clothesList});
}
