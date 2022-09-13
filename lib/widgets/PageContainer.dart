// ignore_for_file: non_constant_identifier_names, file_names
import 'package:flutter/material.dart';
import 'package:test_impack/others/AppTheme.dart';

class PageContainer extends StatefulWidget {
  final Widget child;
  final String title;
  final Function()? actionBackward;

  const PageContainer({
    Key? key,
    required this.child,
    required this.title,
    this.actionBackward,
  }) : super(key: key);

  @override
  State<PageContainer> createState() => _PageContainerState();
}

class _PageContainerState extends State<PageContainer> {
  late final AppTheme theme;

  @override
  void initState() {
    theme = AppTheme(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: SizedBox(
        width: theme.width,
        height: theme.height,
        child: Column(
          children: [
            Container(
              height: theme.size(130),
              color: theme.colorPrimary,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: theme.size(20)),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Folks',
                      fontSize: theme.size(48),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: Container(
                color: Colors.white,
                child: widget.child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
