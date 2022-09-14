// ignore_for_file: file_names, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:test_impack/fragments/ActivityList.dart';
import 'package:test_impack/fragments/ProfileInfo.dart';
import 'package:test_impack/others/Activity.dart';
import 'package:test_impack/others/AppTheme.dart';
import 'package:test_impack/others/DummyData.dart';
import 'package:test_impack/pages/CreateNew.dart';
import 'package:test_impack/widgets/PageContainer.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final AppTheme theme;
  late final List<Activity> activities;
  late final List<String> _titles;
  late int _selectedIndexNav;
  late String _selectedNameTab;

  @override
  void initState() {
    theme = AppTheme(context);
    activities = DummyData.activities;
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

  Widget getFragment(int indexNav, String nameTab) {
    List<Activity> activitiesFiltered = activities
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
        return ActivityList(activities: activitiesFiltered);

      case 1:
        return ActivityList(
          activities: activitiesFiltered
              .where((activity) => activity.activityType == "meeting")
              .toList(),
        );

      case 2:
        return ActivityList(
          activities: activitiesFiltered
              .where((activity) => activity.activityType == "phone_call")
              .toList(),
        );

      case 3:
        return const ProfileInfo();

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
    return PageContainer(
      title: _titles[_selectedIndexNav],
      bottomNavigation: Container(
        padding: EdgeInsets.only(top: theme.size(30)),
        color: theme.colorPrimary,
        child: BottomNavigationBar(
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
          child: getFragment(_selectedIndexNav, _selectedNameTab),
        ),
      ),
    );
  }
}
