// ignore_for_file: file_names
import 'package:flutter/material.dart';

class AppTheme {
  late final BuildContext context;

  AppTheme(this.context);

  Color get colorPrimary => const Color(0xFF1E2D70);
  Color get colorSecondary => const Color(0xFF20C3AF);
  Color get colorCardItem => const Color(0xFF747EAF);

  double get width => MediaQuery.of(context).size.width;
  double get height =>
      MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

  double size(double value) => width * (value / 1080);
}
