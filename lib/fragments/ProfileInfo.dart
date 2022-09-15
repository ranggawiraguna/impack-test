import 'package:flutter/material.dart';
import 'package:test_impack/others/AppTheme.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = AppTheme(context);

    return Container(
      color: theme.colorPrimary.withOpacity(0.3),
      child: Image.asset('images/CurriculumVitae.png'),
    );
  }
}
