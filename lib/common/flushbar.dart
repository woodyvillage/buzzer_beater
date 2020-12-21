import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

_showFlush(BuildContext _context, String _message, bool _isError) {
  if (_isError) {
    Flushbar(
      margin: EdgeInsets.all(8),
      message: _message,
      icon: Icon(
        Icons.error_outline,
        size: 28,
        color: Colors.red[300],
      ),
      duration: Duration(seconds: 2),
      leftBarIndicatorColor: Colors.red,
      forwardAnimationCurve: Curves.easeOutExpo,
      reverseAnimationCurve: Curves.easeOutExpo,
    )..show(_context);
  } else {
    Flushbar(
      margin: EdgeInsets.all(8),
      message: _message,
      icon: Icon(
        Icons.info_outline,
        size: 28,
        color: Colors.blue[300],
      ),
      duration: Duration(seconds: 2),
      leftBarIndicatorColor: Colors.blue,
      forwardAnimationCurve: Curves.easeOutExpo,
      reverseAnimationCurve: Curves.easeOutExpo,
    )..show(_context);
  }
}

showInformation(BuildContext _context, String _message) {
  _showFlush(_context, _message, false);
}

showError(BuildContext _context, String _message) {
  _showFlush(_context, _message, true);
}
