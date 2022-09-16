import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_impack/models/Activity.dart';
import 'package:test_impack/providers/Activities.dart';
import 'package:test_impack/services/AppTheme.dart';
import 'package:test_impack/pages/CreateNew.dart';
import 'package:test_impack/widgets/CardItemActivity.dart';
import 'package:test_impack/widgets/PageContainer.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final AppTheme theme;
  late final List<String> _titles;
  late int _selectedIndexNav;
  late String _selectedNameTab;

  @override
  void initState() {
    theme = AppTheme(context);
    _titles = [
      'Activities',
      'Meeting',
      'Phone Call',
      'Profile',
    ];
    _selectedIndexNav = 0;
    _selectedNameTab = "Open";
    super.initState();
  }

  Widget ActivityList(List<Activity> activities) {
    var activitiesGruopByDate = [];

    activitiesGruopByDate = activities
        .map(
          (activity) => DateTime(
            activity.when.year,
            activity.when.month,
            activity.when.day,
          ),
        )
        .toSet()
        .toList();

    activitiesGruopByDate.sort(
      (a, b) => (a as DateTime).compareTo(b as DateTime),
    );

    activitiesGruopByDate = activitiesGruopByDate.map(
      (date) {
        List<Activity> activityGroup = activities
            .where((activity) =>
                activity.when.isAfter(date) &&
                activity.when.isBefore(
                  DateTime(date.year, date.month, date.day + 1),
                ))
            .toList();

        activityGroup.sort((a, b) => a.when.compareTo(b.when));

        return activityGroup;
      },
    ).toList();

    return activities.isNotEmpty
        ? SizedBox(
            key: const ValueKey<bool>(true),
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                left: theme.size(50),
                right: theme.size(50),
                top: theme.size(10),
                bottom: theme.size(180),
              ),
              child: Column(
                children: activitiesGruopByDate
                    .map(
                      (activitiesGroup) => Padding(
                        padding: EdgeInsets.symmetric(vertical: theme.size(40)),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(bottom: theme.size(15)),
                              child: Text(
                                DateFormat('d MMMM y').format(DateTime(
                                  activitiesGroup[0].when.year,
                                  activitiesGroup[0].when.month,
                                  activitiesGroup[0].when.day,
                                )),
                                style: TextStyle(
                                  fontSize: theme.size(38),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: activitiesGroup.length,
                              itemBuilder: (context, index) => CardItemActivity(
                                id: activitiesGroup[index].id,
                                status: activitiesGroup.length == 1
                                    ? CardItemActivityStatus.none
                                    : index == 0
                                        ? CardItemActivityStatus.first
                                        : index == activitiesGroup.length - 1
                                            ? CardItemActivityStatus.last
                                            : CardItemActivityStatus.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          )
        : SizedBox(
            key: const ValueKey<bool>(false),
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.grey,
                  size: theme.size(246),
                ),
                Text(
                  "No data available",
                  style: TextStyle(
                    fontSize: theme.size(46),
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
  }

  Widget Fragment(List<Activity> activities, int indexNav, String nameTab) {
    List<Activity> activitiesByTab = activities
        .where(
          (activity) => nameTab == "Open"
              ? activity.result == ""
              : nameTab == "Complete"
                  ? activity.result != ""
                  : true,
        )
        .toList();

    switch (indexNav) {
      case 0:
        return ActivityList(activitiesByTab);

      case 1:
        return ActivityList(
          activitiesByTab
              .where((activity) => activity.activityType == "meeting")
              .toList(),
        );

      case 2:
        return ActivityList(
          activitiesByTab
              .where((activity) => activity.activityType == "phone_call")
              .toList(),
        );

      case 3:
        return Container(
          color: theme.colorPrimary.withOpacity(0.3),
          child: Image.asset('images/CurriculumVitae.png'),
        );

      default:
        return const SizedBox.shrink();
    }
  }

  Widget TabButton(String name) {
    return Flexible(
      flex: 1,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            if (_selectedNameTab != name) {
              setState(() => _selectedNameTab = name);
            }
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(theme.size(64)),
              side: BorderSide(
                color: Colors.white,
                width: theme.size(5),
              ),
            ),
            backgroundColor:
                name == _selectedNameTab ? Colors.white : Colors.transparent,
          ),
          child: Text(
            name,
            style: TextStyle(
              fontSize: theme.size(34),
              fontWeight: FontWeight.bold,
              color:
                  name == _selectedNameTab ? theme.colorPrimary : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Activities activities = Provider.of<Activities>(context);

    return PageContainer(
      title: _titles[_selectedIndexNav],
      bottomNavigation: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndexNav,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white30,
        backgroundColor: theme.colorPrimary,
        iconSize: theme.size(80),
        selectedLabelStyle: TextStyle(fontSize: theme.size(32)),
        unselectedLabelStyle: TextStyle(fontSize: theme.size(32)),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups_rounded),
            label: 'Meeting',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone_in_talk_rounded),
            label: 'Phone Call',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (int index) {
          setState(() {
            _selectedNameTab = "Open";
            _selectedIndexNav = index;
          });
        },
      ),
      floatingActionButton: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (Widget child, Animation<double> animation) =>
            ScaleTransition(scale: animation, child: child),
        child: _selectedIndexNav == 0
            ? FloatingActionButton(
                key: const ValueKey<bool>(true),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const CreateNew()),
                  );
                },
                backgroundColor: Colors.deepPurpleAccent,
                child: Icon(
                  Icons.add_rounded,
                  size: theme.size(100),
                ),
              )
            : const SizedBox.shrink(
                key: ValueKey<bool>(false),
              ),
      ),
      tabBarOption: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) =>
            ScaleTransition(scale: animation, child: child),
        child: _selectedIndexNav < 3
            ? Padding(
                key: ValueKey<bool>(_selectedIndexNav < 3),
                padding: EdgeInsets.only(
                  left: theme.size(50),
                  right: theme.size(50),
                  top: theme.size(10),
                  bottom: theme.size(40),
                ),
                child: Row(
                  children: [
                    TabButton("Open"),
                    SizedBox(width: theme.size(50)),
                    TabButton("Complete"),
                  ],
                ),
              )
            : SizedBox.shrink(key: ValueKey<bool>(_selectedIndexNav < 3)),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) =>
            FadeTransition(opacity: animation, child: child),
        child: SizedBox(
          key: ValueKey<String>('$_selectedIndexNav-$_selectedNameTab'),
          width: double.infinity,
          height: double.infinity,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (Widget child, Animation<double> animation) =>
                FadeTransition(opacity: animation, child: child),
            child: Fragment(
              activities.data,
              _selectedIndexNav,
              _selectedNameTab,
            ),
          ),
        ),
      ),
    );
  }
}
