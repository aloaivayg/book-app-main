import 'package:book_app/src/core/resources/data_state.dart';
import 'package:book_app/src/model/clothes.dart';

abstract class ClothesRepository {
  Future<DataState<List<Clothes>>> getAllClothes();
  // Future<DataState<String>> updateClothes({Map<String, dynamic>? req});
  // Future<DataState<String>> createClothes({Map<String, dynamic>? req});
  // Future<DataState<String>> deleteClothes({Map<String, dynamic>? req});
}
