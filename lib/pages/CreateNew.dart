// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:test_impack/others/AppTheme.dart';
import 'package:test_impack/widgets/PageContainer.dart';

class CreateNew extends StatefulWidget {
  const CreateNew({Key? key}) : super(key: key);

  @override
  State<CreateNew> createState() => _CreateNewState();
}

class _CreateNewState extends State<CreateNew> {
  late final AppTheme theme;

  @override
  void initState() {
    theme = AppTheme(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: 'New Activity',
      withBackButton: true,
      child: Container(),
    );
  }
}
