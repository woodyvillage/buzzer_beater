import 'package:flutter/material.dart';

import 'package:buzzer_beater/dao/enroll.dart';
import 'package:buzzer_beater/dao/order.dart';
import 'package:buzzer_beater/dto/enroll.dart';
import 'package:buzzer_beater/dto/order.dart';

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
