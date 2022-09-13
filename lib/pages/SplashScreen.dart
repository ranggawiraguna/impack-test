// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:test_impack/others/AppTheme.dart';
import 'package:test_impack/widgets/FlexSpace.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final AppTheme theme;

  @override
  void initState() {
    theme = AppTheme(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorPrimary,
      body: Center(
          child: Row(
        children: [
          FlexSpace(150),
          const Flexible(
            flex: 730,
            child: FlutterLogo(
              size: double.infinity,
              style: FlutterLogoStyle.horizontal,
              textColor: Colors.white,
            ),
          ),
          FlexSpace(200),
        ],
      )),
    );
  }
}

class FutureSplash {
  FutureSplash._();
  static final instance = FutureSplash._();

  Future initialize() async {
    await Future.delayed(const Duration(seconds: 4));
  }
}
