import 'package:flutter/material.dart';

// Repeated code for TextField
const kTextFiledInputDecoration = InputDecoration(
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.black),
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 2),
  ),
  labelText: " Email",
  labelStyle:
      TextStyle(color: Colors.grey, fontSize: 19, fontWeight: FontWeight.w400),
);

BoxDecoration decorationBox = BoxDecoration(
  borderRadius: BorderRadius.circular(10),
  color: Colors.white,
  boxShadow: [
    BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 5))
  ],
);

InputDecoration profileInputDecoration = InputDecoration(
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
    borderSide: BorderSide(color: Color(0xffd2d1d1), width: 1.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
    borderSide: BorderSide(color: Color(0xffd2d1d1), width: 1.0),
  ),
  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  hintStyle: TextStyle(color: Colors.grey),
);
