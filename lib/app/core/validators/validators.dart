import 'package:flutter/material.dart';

class Validators {
  Validators._();

  static FormFieldValidator<String> compare(
      TextEditingController? valueEC, String message) {
    return (value) {
      final valueCompare = valueEC?.text ?? '';
      if (value == null || (value != valueCompare)) {
        return message;
      }
      return null;
    };
  }
}
