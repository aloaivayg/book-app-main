part of 'clothes_bloc.dart';

class ClothesState extends Equatable {
  final List<Clothes>? clothesList;
  final DioException? error;
  final Clothes? item;

  const ClothesState({this.clothesList, this.error, this.item});
  @override
  List<Object> get props => [clothesList!, error!];
}

class ClothesDataLoading extends ClothesState {
  const ClothesDataLoading();
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
  }) : super(item: clothes);
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
  final Map<String, int> clothesMap;
  final double totalPrice;

  const ViewCartSuccess(
      {required this.clothesList,
      required this.clothesMap,
      required this.totalPrice});
}

class ViewPaymentDetailSuccess extends ClothesState {
  final List<Clothes> clothesList;
  final double totalPrice;

  const ViewPaymentDetailSuccess(
      {required this.clothesList, required this.totalPrice});
}
