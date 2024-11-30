import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CajaController{
  late BuildContext context;
  late Function refresh;
  Future init(BuildContext context, Function refresh)async {
    this.context = context;
    this.refresh = refresh;
  }
}