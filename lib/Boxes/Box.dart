import 'package:hive/hive.dart';
import 'package:reem_flora/models/cart.dart';
import 'package:reem_flora/models/product_model.dart';

class Boxes {
  static Box<ProductModel> getAllFavPro() =>
      Hive.box<ProductModel>("FavoriteProducts");
  static Box<Cart> getAllCartPro() => Hive.box<Cart>("CartProducts");
}
