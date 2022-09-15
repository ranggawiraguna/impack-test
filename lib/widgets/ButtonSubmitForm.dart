import 'package:flutter/material.dart';
import 'package:test_impack/others/AppTheme.dart';

class ButtonSubmitForm extends StatelessWidget {
  final String text;
  final Function() onClick;

  const ButtonSubmitForm({
    Key? key,
    required this.text,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme(context);

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: theme.size(20)),
        child: ElevatedButton(
          onPressed: onClick,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(theme.size(40)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(theme.size(30)),
            ),
            backgroundColor: theme.colorSecondary,
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: theme.size(42),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
