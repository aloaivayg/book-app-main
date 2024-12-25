part of 'clothes_bloc.dart';

class ClothesEvent extends Equatable {
  const ClothesEvent();

  @override
  List<Object> get props => [];
}

class GetAllClothesEvent extends ClothesEvent {
  const GetAllClothesEvent();
}

class ViewClothesInfoEvent extends ClothesEvent {
  final Clothes clothes;
  const ViewClothesInfoEvent({required this.clothes});
}

class SelectClothesColorEvent extends ClothesEvent {
  const SelectClothesColorEvent();
}

class SelectClothesSizeEvent extends ClothesEvent {
  const SelectClothesSizeEvent();
}

class EnableAddToCartEvent extends ClothesEvent {
  final int selectedSizeIndex;
  final int selectedColorIndex;
  final Clothes clothes;

  const EnableAddToCartEvent(
      {required this.selectedSizeIndex,
      required this.selectedColorIndex,
      required this.clothes});
}

class AddClothesToCartEvent extends ClothesEvent {
  final Clothes clothes;
  const AddClothesToCartEvent({required this.clothes});
}

class ViewCartEvent extends ClothesEvent {
  const ViewCartEvent();
}

class IncreaseCartQuantityEvent extends ClothesEvent {
  final Clothes clothes;
  const IncreaseCartQuantityEvent({required this.clothes});
}

class DecreaseCartQuantityEvent extends ClothesEvent {
  final Clothes clothes;
  const DecreaseCartQuantityEvent({required this.clothes});
}

class RemoveCartItemEvent extends ClothesEvent {
  final Clothes clothes;
  const RemoveCartItemEvent({required this.clothes});
}

class ViewPaymentDetailsEvent extends ClothesEvent {
  const ViewPaymentDetailsEvent();
}

class PlaceOrderEvent extends ClothesEvent {
  final Map<String, String> formData;
  const PlaceOrderEvent({required this.formData});
}

class ViewAllOrdersEvent extends ClothesEvent {
  final String userId;
  const ViewAllOrdersEvent({required this.userId});
}
