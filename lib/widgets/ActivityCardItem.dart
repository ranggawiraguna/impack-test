// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_impack/others/Activity.dart';
import 'package:test_impack/others/AppTheme.dart';
import 'package:test_impack/pages/DetailInfo.dart';
import 'package:test_impack/pages/EditInfo.dart';

class ActivityCardItem extends StatelessWidget {
  static final Map<String, IconData> _icons = {
    'meeting': Icons.groups_rounded,
    'phone_call': Icons.phone_in_talk_rounded,
  };
  static final Map<String, String> _titles = {
    'meeting': "Meeting",
    'phone_call': "Phone Call",
  };

  final Activity activity;
  final ActivityCardItemStatus status;

  const ActivityCardItem({
    super.key,
    required this.activity,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = AppTheme(context);

    return Padding(
      padding: EdgeInsets.only(
        left: theme.size(25),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            status != ActivityCardItemStatus.none
                ? Positioned(
                    left: theme.size(21),
                    top: status == ActivityCardItemStatus.first
                        ? theme.size(40)
                        : 0,
                    bottom: status == ActivityCardItemStatus.last ? null : 0,
                    child: Container(
                      width: theme.size(10),
                      height: status == ActivityCardItemStatus.last
                          ? theme.size(50)
                          : null,
                      color: Colors.deepPurpleAccent,
                    ),
                  )
                : const SizedBox.shrink(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: theme.size(35)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Center(
                            child: Icon(
                              Icons.circle,
                              color: Colors.white,
                              size: theme.size(50),
                            ),
                          ),
                          Center(
                            child: Icon(
                              Icons.radio_button_checked,
                              color: Colors.deepPurpleAccent,
                              size: theme.size(50),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: theme.size(20)),
                        child: SizedBox(
                          width: theme.size(120),
                          child: Text(
                            DateFormat('Hm').format(
                              DateTime.parse((activity.when)),
                            ),
                            style: TextStyle(
                              fontSize: theme.size(36),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(
                      top: theme.size(10),
                      bottom: theme.size(10),
                    ),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetailInfo(
                              activity: activity,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(theme.size(20)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              theme.size(20),
                            ),
                          ),
                        ),
                        backgroundColor: theme.colorCardItem,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(theme.size(10)),
                                      decoration: BoxDecoration(
                                        color: Colors.black38,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(theme.size(10)),
                                        ),
                                      ),
                                      child: Icon(
                                        _icons[activity.activityType],
                                        size: theme.size(40),
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: theme.size(15)),
                                    Text(
                                      '${_titles[activity.activityType]}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: theme.size(36),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: theme.size(60),
                                height: theme.size(60),
                                child: PopupMenuButton(
                                  padding: const EdgeInsets.all(0),
                                  icon: Icon(
                                    Icons.more_vert_rounded,
                                    size: theme.size(60),
                                    color: Colors.white,
                                  ),
                                  onSelected: (value) {
                                    switch (value) {
                                      case 1:
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => DetailInfo(
                                              activity: activity,
                                            ),
                                          ),
                                        );
                                        break;

                                      case 2:
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => EditInfo(
                                              activity: activity,
                                            ),
                                          ),
                                        );
                                        break;

                                      case 3:
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text('Delete this data'),
                                          ),
                                        );
                                        break;

                                      default:
                                        break;
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: 1,
                                      height: double.minPositive,
                                      padding: EdgeInsets.symmetric(
                                        vertical: theme.size(20),
                                        horizontal: theme.size(40),
                                      ),
                                      child: Text(
                                        "Detail",
                                        style: TextStyle(
                                          fontSize: theme.size(32),
                                        ),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 2,
                                      height: double.minPositive,
                                      padding: EdgeInsets.symmetric(
                                        vertical: theme.size(20),
                                        horizontal: theme.size(40),
                                      ),
                                      child: Text(
                                        "Edit",
                                        style: TextStyle(
                                          fontSize: theme.size(32),
                                        ),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 3,
                                      height: double.minPositive,
                                      padding: EdgeInsets.symmetric(
                                        vertical: theme.size(20),
                                        horizontal: theme.size(40),
                                      ),
                                      child: Text(
                                        "Delete",
                                        style: TextStyle(
                                          fontSize: theme.size(32),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: theme.size(20)),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              '${_titles[activity.activityType]} with ${activity.institution}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: theme.size(36),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum ActivityCardItemStatus { none, normal, first, last }
