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
