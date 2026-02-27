import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart_item_model.dart';

abstract class CartLocalDataSource {
  Future<List<CartItemModel>> getItems();
  Future<void> saveItems(List<CartItemModel> items);
}

const String _cartKey = 'hadi_cart_items';

class CartLocalDataSourceImpl implements CartLocalDataSource {
  CartLocalDataSourceImpl({required SharedPreferences prefs}) : _prefs = prefs;

  final SharedPreferences _prefs;

  @override
  Future<List<CartItemModel>> getItems() async {
    final json = _prefs.getString(_cartKey);
    if (json == null) return [];
    final list = jsonDecode(json) as List<dynamic>;
    return list
        .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> saveItems(List<CartItemModel> items) async {
    final list = items.map((e) => e.toJson()).toList();
    await _prefs.setString(_cartKey, jsonEncode(list));
  }
}
