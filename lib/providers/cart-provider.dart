import 'package:flutter/material.dart';

import '../data/data.dart';

class CartProvider extends ChangeNotifier {
  List<ItemModel> data = [
    ItemModel(
      id: '001',
      name: 'Cleanser',
      brand: 'The Face Shop',
      price: '339',
      image: 'assets/images/pngs/1-b.png',
    ),
    ItemModel(
      id: '002',
      name: 'Night Gel',
      brand: 'Plum',
      price: '176',
      image: 'assets/images/pngs/2-b.png',
    ),
    ItemModel(
      id: '003',
      name: 'Refreshing Facewash',
      brand: 'Simple',
      price: '250',
      image: 'assets/images/pngs/3-b.png',
    ),
    ItemModel(
      id: '004',
      name: 'Face Wash',
      brand: 'Cetaphil',
      price: '333',
      image: 'assets/images/pngs/4-a.png',
    ),
    ItemModel(
      id: '005',
      name: 'Face Serum',
      brand: 'Pilgrim Korean',
      price: '180',
      image: 'assets/images/pngs/5-c.png',
    ),
    ItemModel(
      id: '006',
      name: 'Night Cream',
      brand: 'WOW Skin',
      price: '99',
      image: 'assets/images/pngs/6-a.png',
    ),
    ItemModel(
      id: '007',
      name: 'Moisturizer',
      brand: 'Foxtale',
      price: '55',
      image: 'assets/images/pngs/2-b.png',
    ),
    ItemModel(
      id: '008',
      name: 'Matte Lipstick',
      brand: 'Maybelline',
      price: '220',
      image: 'assets/images/pngs/4-b.png',
    ),
  ];

  final List<ItemModel> _cartedItems = [];

  List<ItemModel> get cartedItems => _cartedItems;

  set addToCart(ItemModel itemModel) {
    if (_cartedItems.contains(itemModel)) {
      return;
    }
    _cartedItems.add(itemModel);
    notifyListeners();
  }

  set removeFromCart(ItemModel item) {
    _cartedItems.remove(item);
    notifyListeners();
  }

  double get total {
    double t = 0;

    for (var e in _cartedItems) {
      t += double.parse(e.price);
    }

    return t;
  }
}
