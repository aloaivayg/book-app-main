import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:book_app/src/model/clothes.dart';
import 'package:book_app/src/model/user.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'clothes_event.dart';
part 'clothes_state.dart';

class ClothesBloc extends Bloc<ClothesEvent, ClothesState> {
  ClothesBloc() : super(const ClothesDataLoading()) {
    on<GetAllClothesEvent>(onGetAllClothes);
    on<ViewClothesInfoEvent>(onViewClothesInfo);
    on<EnableAddToCartEvent>(onEnableAddToCartEvent);
    on<AddClothesToCartEvent>(onAddToCartEvent);
    on<ViewCartEvent>(onViewCartEvent);
    on<IncreaseCartQuantityEvent>(onIncreaseCartQuantityEvent);
    on<DecreaseCartQuantityEvent>(onDecreaseCartQuantityEvent);
    on<RemoveCartItemEvent>(onRemoveCartItemEvent);
    on<ViewPaymentDetailsEvent>(onViewPaymentDetailsEvent);
  }

  var cartItems = <Clothes>[];
  var cartItemQuantityMap = <String, int>{};
  var cartItemMap = <String, Clothes>{};
  late User user;
  double totalPrice = 0;

  void onGetAllClothes(
      GetAllClothesEvent event, Emitter<ClothesState> emit) async {
    final dataState = await Clothes.loadItemsFromBundle();
    user = await User.loadUserFromBundle();
    print(user.toJson());

    emit(const ClothesDataLoading());

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
    emit(const ClothesDataLoading());

    if (event.clothes != null) {
      print("CLOTHES INFO");
      emit(ViewClothesInfoSuccess(
          clothes: event.clothes,
          isEnabled: false,
          cartQuantity: cartItems.length));
    } else {
      emit(FetchClothesError(DioException(requestOptions: RequestOptions())));
    }
  }

  void onEnableAddToCartEvent(
      EnableAddToCartEvent event, Emitter<ClothesState> emit) async {
    emit(const ClothesDataLoading());
    if (event.selectedColorIndex != -1 && event.selectedSizeIndex != -1) {
      emit(ViewClothesInfoSuccess(
          clothes: event.clothes,
          isEnabled: true,
          cartQuantity: cartItems.length));
    } else {
      emit(ViewClothesInfoSuccess(
          clothes: event.clothes,
          isEnabled: false,
          cartQuantity: cartItems.length));
    }
  }

  void updateTotalPrice() {
    totalPrice = 0;
    for (var element in cartItemMap.keys) {
      totalPrice += cartItemMap[element]!.price * cartItemQuantityMap[element]!;
    }
  }

  void onAddToCartEvent(
      AddClothesToCartEvent event, Emitter<ClothesState> emit) async {
    var listItem = <Clothes>[];
    totalPrice = 0;

    emit(const ClothesDataLoading());
    if (event.clothes != null) {
      cartItemMap.putIfAbsent(event.clothes.id, () => event.clothes);
      if (cartItemQuantityMap.containsKey(event.clothes.id)) {
        cartItemQuantityMap[event.clothes.id] =
            cartItemQuantityMap[event.clothes.id]! + 1;
      } else {
        listItem.add(event.clothes);
        cartItems.add(event.clothes);
        cartItemQuantityMap[event.clothes.id] = 1;
      }

      updateTotalPrice();
    }

    emit(ViewClothesInfoSuccess(
        clothes: event.clothes,
        isEnabled: true,
        cartQuantity: cartItems.length));
  }

  void onViewCartEvent(ViewCartEvent event, Emitter<ClothesState> emit) async {
    emit(ViewCartSuccess(
        clothesList: cartItems,
        clothesMap: cartItemQuantityMap,
        totalPrice: totalPrice));
  }

  void onIncreaseCartQuantityEvent(
      IncreaseCartQuantityEvent event, Emitter<ClothesState> emit) async {
    emit(const ClothesDataLoading());

    if (cartItemQuantityMap[event.clothes.id]! < 10) {
      cartItemQuantityMap[event.clothes.id] =
          cartItemQuantityMap[event.clothes.id]! + 1;
      updateTotalPrice();
    }

    emit(ViewCartSuccess(
        clothesList: cartItems,
        clothesMap: cartItemQuantityMap,
        totalPrice: totalPrice));
  }

  void onDecreaseCartQuantityEvent(
      DecreaseCartQuantityEvent event, Emitter<ClothesState> emit) async {
    emit(const ClothesDataLoading());

    if (cartItemQuantityMap[event.clothes.id]! > 1) {
      cartItemQuantityMap[event.clothes.id] =
          cartItemQuantityMap[event.clothes.id]! - 1;
      updateTotalPrice();
    }

    emit(ViewCartSuccess(
        clothesList: cartItems,
        clothesMap: cartItemQuantityMap,
        totalPrice: totalPrice));
  }

  void onRemoveCartItemEvent(
      RemoveCartItemEvent event, Emitter<ClothesState> emit) async {
    emit(const ClothesDataLoading());

    cartItemMap.remove(event.clothes.id);
    cartItemQuantityMap.remove(event.clothes.id);
    cartItems.remove(event.clothes);

    updateTotalPrice();

    emit(ViewCartSuccess(
        clothesList: cartItems,
        clothesMap: cartItemQuantityMap,
        totalPrice: totalPrice));
  }

  void onViewPaymentDetailsEvent(
      ViewPaymentDetailsEvent event, Emitter<ClothesState> emit) async {
    emit(const ClothesDataLoading());

    emit(ViewPaymentDetailSuccess(
        clothesList: cartItems, totalPrice: totalPrice));
  }
}
