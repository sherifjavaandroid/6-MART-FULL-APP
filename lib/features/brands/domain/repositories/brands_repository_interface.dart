import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/interfaces/repository_interface.dart';

abstract class BrandsRepositoryInterface extends RepositoryInterface {
  Future<ItemModel?> getBrandItemList({required int brandId, int? offset});
}