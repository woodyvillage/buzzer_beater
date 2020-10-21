import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

_showFlush(BuildContext context, String message, bool isError) {
  if (isError) {
    Flushbar(
      margin: EdgeInsets.all(8),
      message: message,
      icon: Icon(
        Icons.error_outline,
        size: 28,
        color: Colors.red[300],
      ),
      duration: Duration(seconds: 2),
      leftBarIndicatorColor: Colors.red,
      forwardAnimationCurve: Curves.easeOutExpo,
      reverseAnimationCurve: Curves.easeOutExpo,
    )..show(context);
  } else {
    Flushbar(
      margin: EdgeInsets.all(8),
      message: message,
      icon: Icon(
        Icons.info_outline,
        size: 28,
        color: Colors.blue[300],
      ),
      duration: Duration(seconds: 2),
      leftBarIndicatorColor: Colors.blue,
      forwardAnimationCurve: Curves.easeOutExpo,
      reverseAnimationCurve: Curves.easeOutExpo,
    )..show(context);
  }
}

showInformation(BuildContext _context, String _message) {
  _showFlush(_context, _message, false);
}

showError(BuildContext _context, String _message) {
  _showFlush(_context, _message, true);
}
