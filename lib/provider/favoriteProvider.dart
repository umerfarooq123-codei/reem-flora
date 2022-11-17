import 'package:flutter/material.dart';
import 'package:reem_flora/Boxes/Box.dart';
import 'package:reem_flora/models/cart.dart';
import 'package:reem_flora/models/product_model.dart';

class FavoritreProvider extends ChangeNotifier {
  final box = Boxes.getAllFavPro();
  addToFavorite( product, String key) async {
    // debugPrint("Add call");
    box.put(key, product);
    notifyListeners();
  }

  removeFromFavorite( product, String key) {
    // product.delete();
    box.delete(key);
    // debugPrint("Dell call");
    notifyListeners();
  }
}

class CartProvider extends ChangeNotifier {
  final box = Boxes.getAllCartPro();
  addToCart(Cart product, String key) async {
    // debugPrint("Add call");
    box.put(key, product);
    notifyListeners();
  }

  removeFromCart(Cart product, String key) {
    // product.delete();
    box.delete(key);
    // debugPrint("Dell call");
    notifyListeners();
  }
}
