import 'dart:io';
import 'package:flutter/material.dart';

class FormDto {
  FocusNode node;
  TextEditingController controller;
  Icon icon;
  String hint;
  String value;
  bool boolvalue;
  Color mainColor;
  Color edgeColor;
  File image;

  FormDto({
    this.node,
    this.controller,
    this.icon,
    this.hint,
    this.value,
    this.boolvalue,
    this.image,
  });

  bool isPrepare() {
    if (node == null || controller == null) {
      return false;
    } else {
      return true;
    }
  }
}
