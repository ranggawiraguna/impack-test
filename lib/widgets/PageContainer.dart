import 'package:flutter/material.dart';
import 'package:test_impack/services/AppTheme.dart';

class PageContainer extends StatelessWidget {
  final Widget child;
  final String title;
  final bool withBackButton;
  final Widget? bottomNavigation;
  final Widget? floatingActionButton;
  final Widget? tabBarOption;

  const PageContainer({
    super.key,
    required this.child,
    required this.title,
    this.withBackButton = false,
    this.bottomNavigation,
    this.floatingActionButton,
    this.tabBarOption,
  });

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = AppTheme(context);

    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      bottomNavigationBar: bottomNavigation,
      floatingActionButton: floatingActionButton,
      body: SizedBox(
        width: theme.width,
        height: theme.height,
        child: Column(
          children: [
            Container(
              color: theme.colorPrimary,
              constraints: BoxConstraints(minHeight: theme.size(130)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      withBackButton
                          ? SizedBox(
                              width: theme.size(130),
                              child: IconButton(
                                padding: EdgeInsets.only(
                                  bottom: theme.size(25),
                                  left: theme.size(10),
                                ),
                                icon: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: Colors.white,
                                  size: theme.size(60),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            )
                          : const SizedBox.shrink(),
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: theme.size(tabBarOption != null ? 40 : 0),
                              bottom: theme.size(20),
                            ),
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) =>
                                      FadeTransition(
                                          opacity: animation, child: child),
                              child: Text(
                                title,
                                key: ValueKey<String>(title),
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
                      ),
                      withBackButton
                          ? SizedBox(width: theme.size(130))
                          : const SizedBox.shrink(),
                    ],
                  ),
                  tabBarOption != null
                      ? tabBarOption!
                      : const SizedBox.shrink(),
                ],
              ),
            ),
            Flexible(
              child: Container(
                color: Colors.white,
                width: double.infinity,
                height: double.infinity,
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
