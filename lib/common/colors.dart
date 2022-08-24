// ignore_for_file: prefer_const_constructors

import 'package:complecionista/config/app_flavor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

AppColors getAppColors() {
  String partner = "";
  try {
    partner = Modular.get<AppFlavor>().getPartner();
  } catch (_) {}
  switch (partner) {
    case "complecionista":
      return AppColors();
    default:
      return AppColors();
  }
}

class AppColors {
  mainColor() => Color(0xFFFEC92D);
  secondColor() => Color(0xff99731F);
  grey() => Color(0xFF3F3F3F);
  darkGrey() => Color(0xFF303030);
  white() => Colors.white;
  black() => Colors.black;
  background() => Color(0xFFFCFCFC);
  backgroundOpposite() => Colors.black;
  error() => Colors.red;
}
