import 'package:flutter/material.dart';

import 'package:buzzer_beater/dao/enroll.dart';
import 'package:buzzer_beater/dao/order.dart';
import 'package:buzzer_beater/dao/purchase.dart';
import 'package:buzzer_beater/dto/enroll.dart';
import 'package:buzzer_beater/dto/order.dart';
import 'package:buzzer_beater/dto/purchase.dart';

class EnrollNotifier extends ChangeNotifier {
  List<EnrollDto> _enrollList;
  List<EnrollDto> get enrollList => _enrollList;

  getEnroll() async {
    EnrollDao _dao = EnrollDao();
    _enrollList = await _dao.getEnroll();

    notifyListeners();
  }
}

class OrderNotifier extends ChangeNotifier {
  List<OrderDto> _orderList;
  List<OrderDto> get orderList => _orderList;

  getOrder() async {
    OrderDao _dao = OrderDao();
    _orderList = await _dao.getOrder();

    notifyListeners();
  }
}

class PurchaseNotifier extends ChangeNotifier {
  List<PurchaseDto> _purchaseList;
  List<PurchaseDto> get purchaseList => _purchaseList;
  bool _isInvalidAds;
  bool get isInvalidAds => _isInvalidAds;

  getPurchase() async {
    PurchaseDao _dao = PurchaseDao();
    _purchaseList = await _dao.getPurchase();

    _isInvalidAds = false;
    for (PurchaseDto _purchase in _purchaseList) {
      _isInvalidAds = _purchase.isActive == true ? true : _isInvalidAds;
    }
    notifyListeners();
  }
}
