// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:test_impack/others/Activity.dart';
import 'package:test_impack/others/AppTheme.dart';
import 'package:test_impack/widgets/PageContainer.dart';

class DetailInfo extends StatefulWidget {
  final Activity activity;

  const DetailInfo({Key? key, required this.activity}) : super(key: key);

  @override
  State<DetailInfo> createState() => _DetailInfoState();
}

class _DetailInfoState extends State<DetailInfo> {
  late final AppTheme theme;

  @override
  void initState() {
    theme = AppTheme(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: 'Activity Info',
      withBackButton: true,
      child: Container(),
    );
  }
}
