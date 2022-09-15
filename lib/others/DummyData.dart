import 'package:test_impack/others/Activity.dart';

class DummyData {
  static final List<Activity> activities = [
    Activity(
      id: "12345",
      activityType: 'meeting',
      institution: 'Lorem',
      when: DateTime.now().toString(),
      objective: 'new_order',
      remarks: 'Sit Amet',
      result: 'Adipising Elit',
    ),
    Activity(
      id: "23456",
      activityType: 'phone_call',
      institution: 'Lorem',
      when: DateTime.now().toString(),
      objective: 'invoice',
      remarks: 'Sit Amet',
      result: '',
    ),
    Activity(
      id: "34567",
      activityType: 'meeting',
      institution: 'Lorem',
      when: DateTime.now().toString(),
      objective: 'new_order',
      remarks: 'Sit Amet',
      result: '',
    ),
    Activity(
      id: "45678",
      activityType: 'meeting',
      institution: 'Lorem',
      when: DateTime.now().toString(),
      objective: 'new_leads',
      remarks: 'Sit Amet',
      result: 'Adipising Elit',
    ),
    Activity(
      id: "56789",
      activityType: 'phone_call',
      institution: 'Lorem',
      when: DateTime.now().toString(),
      objective: 'invoice',
      remarks: 'Sit Amet',
      result: '',
    ),
  ];
}
