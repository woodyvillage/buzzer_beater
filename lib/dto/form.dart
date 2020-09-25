import 'package:flutter/material.dart';

class FormDto {
  FocusNode node;
  TextEditingController controller;
  Icon icon;
  String hint;
  String value;
  Color color;
  Color border;

  FormDto({this.node, this.controller, this.icon, this.hint, this.value});

  bool isPrepare() {
    if (this.node == null || this.controller == null) {
      return false;
    } else {
      return true;
    }
  }
}