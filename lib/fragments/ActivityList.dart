import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_impack/others/Activity.dart';
import 'package:test_impack/others/AppTheme.dart';
import 'package:test_impack/widgets/CardItemActivity.dart';

class ActivityList extends StatefulWidget {
  final List<Activity> activities;

  const ActivityList({super.key, required this.activities});

  @override
  State<ActivityList> createState() => _ActivityListState();
}

class _ActivityListState extends State<ActivityList> {
  late final AppTheme theme;

  @override
  void initState() {
    theme = AppTheme(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        left: theme.size(50),
        right: theme.size(50),
        top: theme.size(10),
        bottom: theme.size(180),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: theme.size(40)),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: theme.size(15)),
                  child: Text(
                    DateFormat('d MMMM y').format(DateTime.now()),
                    style: TextStyle(
                      fontSize: theme.size(38),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.activities.length,
                  itemBuilder: (context, index) => CardItemActivity(
                    activity: widget.activities[index],
                    status: widget.activities.length == 1
                        ? CardItemActivityStatus.none
                        : index == 0
                            ? CardItemActivityStatus.first
                            : index == widget.activities.length - 1
                                ? CardItemActivityStatus.last
                                : CardItemActivityStatus.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
