import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:book_app/src/config/data_source/ServerUrl.dart';
import 'package:book_app/src/model/clothes.dart';
import 'package:book_app/src/model/order.dart';
import 'package:book_app/src/model/user.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:book_app/src/config/http/http_client.dart';

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
    on<PlaceOrderEvent>(onPlaceOrderEvent);
    on<ViewAllOrdersEvent>(onViewAllOrdersEvent);
  }

  var itemMapByProductCode = <String, List<Clothes>>{};
  var itemListByProductCode = <Clothes>[];

  var cartItems = <Clothes>[];
  var cartItemQuantityMap = <String, int>{};
  var cartItemMap = <String, Clothes>{};

  double totalPrice = 0;

  void onViewAllOrdersEvent(
      ViewAllOrdersEvent event, Emitter<ClothesState> emit) async {
    final String url = '${ServerUrl.orderApi}/getByUserId/${event.userId}';

    print(event.userId);
    final response = await HttpClient.getRequest(url);

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);

      List<Order> orderList =
          data.map((json) => Order.fromJson(json)).toList().cast<Order>();

      emit(ViewAllOrdersSuccess(orderList: orderList));
    } else {
      emit(const PlaceOrderFail());
    }
  }

  void onPlaceOrderEvent(
      PlaceOrderEvent event, Emitter<ClothesState> emit) async {
    final String url = '${ServerUrl.orderApi}/create';

    var body = {
      "userId": event.formData["userId"],
      "orderDate": DateTime.now().toIso8601String(),
      "paymentMethod": event.formData["paymentMethod"],
      "shippingAddress": event.formData["shippingAddress"],
      "shippingMethod": event.formData["shippingMethod"],
      "orderItems": cartItemQuantityMap,
      "discountsCode": "SUMMER20"
    };

    final response = await HttpClient.postRequest(url, params: body);

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);

      Order order = Order.fromJson(data);
      cartItems = <Clothes>[];
      cartItemQuantityMap = <String, int>{};
      cartItemMap = <String, Clothes>{};
      emit(PlaceOrderSuccess(order: order));
    } else {
      emit(const PlaceOrderFail());
    }
  }

  void assignItemListByProductCode(List<Clothes> listItem) {
    for (var item in listItem) {
      String productCode = item.productCode;

      if (!itemMapByProductCode.containsKey(productCode)) {
        itemMapByProductCode[productCode] = [];
      }

      itemMapByProductCode[productCode]!.add(item);
    }
  }

  void refreshValue() {
    itemListByProductCode = [];
  }

  void onGetAllClothes(
      GetAllClothesEvent event, Emitter<ClothesState> emit) async {
    final dataState = await Clothes.fetchClothes();

    emit(const ClothesDataLoading());
    refreshValue();
    assignItemListByProductCode(dataState);

    itemMapByProductCode.forEach(((key, value) {
      itemListByProductCode.add(value.first);
    }));

    if (dataState.isNotEmpty) {
      print("FETCH SUCCES");

      emit(FetchClothesSuccess(selectClothesList: itemListByProductCode));
    } else {
      print("FETCH ERROR");

      emit(FetchClothesError(DioException(requestOptions: RequestOptions())));
    }
  }

  void onViewClothesInfo(
      ViewClothesInfoEvent event, Emitter<ClothesState> emit) async {
    emit(const ClothesDataLoading());

    if (event.clothes != null) {
      emit(ViewClothesInfoSuccess(
          clothes: event.clothes,
          selectClothesList: itemMapByProductCode[event.clothes.productCode]!,
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
          selectClothesList: itemMapByProductCode[event.clothes.productCode]!,
          isEnabled: true,
          cartQuantity: cartItems.length));
    } else {
      emit(ViewClothesInfoSuccess(
          clothes: event.clothes,
          selectClothesList: itemMapByProductCode[event.clothes.productCode]!,
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
        selectClothesList: itemMapByProductCode[event.clothes.productCode]!,
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
