import 'package:flutter/material.dart';

InputDecoration customInputDecoration = const InputDecoration(
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      width: 0.5,
      color: Colors.red,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(5),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      width: 0.5,
      color: Color.fromARGB(255, 64, 169, 255),
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(5),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      width: 0.5,
      color: Colors.grey,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(5),
    ),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      width: 0.5,
      color: Colors.red,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(5),
    ),
  ),
);
