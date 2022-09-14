// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:test_impack/others/Activity.dart';
import 'package:test_impack/others/AppTheme.dart';
import 'package:test_impack/widgets/PageContainer.dart';

class EditInfo extends StatefulWidget {
  final Activity activity;

  const EditInfo({Key? key, required this.activity}) : super(key: key);

  @override
  State<EditInfo> createState() => _EditInfoState();
}

class _EditInfoState extends State<EditInfo> {
  late final AppTheme theme;

  @override
  void initState() {
    theme = AppTheme(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: 'Edit Activity',
      withBackButton: true,
      child: Container(),
    );
  }
}
