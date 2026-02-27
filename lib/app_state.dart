import 'package:flutter/material.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  String _tmpphone = '';
  String get tmpphone => _tmpphone;
  set tmpphone(String value) {
    _tmpphone = value;
  }

  String _tmpheardabout = '';
  String get tmpheardabout => _tmpheardabout;
  set tmpheardabout(String value) {
    _tmpheardabout = value;
  }

  String _tmpotpchannel = '';
  String get tmpotpchannel => _tmpotpchannel;
  set tmpotpchannel(String value) {
    _tmpotpchannel = value;
  }

  bool _timeractive = true;
  bool get timeractive => _timeractive;
  set timeractive(bool value) {
    _timeractive = value;
  }

  bool _tmpphoneverified = false;
  bool get tmpphoneverified => _tmpphoneverified;
  set tmpphoneverified(bool value) {
    _tmpphoneverified = value;
  }

  bool _onboardingcomplete = false;
  bool get onboardingcomplete => _onboardingcomplete;
  set onboardingcomplete(bool value) {
    _onboardingcomplete = value;
  }

  List<String> _qtyBase = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31',
    '32',
    '33',
    '34',
    '35',
    '36',
    '37',
    '38',
    '39',
    '40',
    '41',
    '42',
    '43',
    '44',
    '45',
    '46',
    '47',
    '48',
    '49',
    '50'
  ];
  List<String> get qtyBase => _qtyBase;
  set qtyBase(List<String> value) {
    _qtyBase = value;
  }

  void addToQtyBase(String value) {
    qtyBase.add(value);
  }

  void removeFromQtyBase(String value) {
    qtyBase.remove(value);
  }

  void removeAtIndexFromQtyBase(int index) {
    qtyBase.removeAt(index);
  }

  void updateQtyBaseAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    qtyBase[index] = updateFn(_qtyBase[index]);
  }

  void insertAtIndexInQtyBase(int index, String value) {
    qtyBase.insert(index, value);
  }

  List<String> _productCategories = [
    'Fashion & Clothing',
    'Shoes',
    'Bags',
    'Beauty & Skincare',
    'Phones & Accessories',
    'Computers & Gadgets',
    'Home & Furniture',
    'Kitchen & Appliances',
    'Groceries',
    'Books & Stationery',
    'Sports & Fitness',
    'Toys & Kids',
    'Art & Crafts',
    'Services',
    'Other'
  ];
  List<String> get productCategories => _productCategories;
  set productCategories(List<String> value) {
    _productCategories = value;
  }

  void addToProductCategories(String value) {
    productCategories.add(value);
  }

  void removeFromProductCategories(String value) {
    productCategories.remove(value);
  }

  void removeAtIndexFromProductCategories(int index) {
    productCategories.removeAt(index);
  }

  void updateProductCategoriesAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    productCategories[index] = updateFn(_productCategories[index]);
  }

  void insertAtIndexInProductCategories(int index, String value) {
    productCategories.insert(index, value);
  }
}
