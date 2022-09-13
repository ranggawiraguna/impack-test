// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:test_impack/others/AppTheme.dart';
import 'package:test_impack/widgets/PageContainer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final AppTheme theme;

  @override
  void initState() {
    theme = AppTheme(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(title: 'Activities', child: Container());
  }
}
