// ignore_for_file: file_names
import 'package:test_impack/others/Activity.dart';

class ApiService {
  ApiService._internal();

  factory ApiService() => _instance;
  static final ApiService _instance = ApiService._internal();
  static const String _urlActivities =
      "https://ranggawiraguna.github.io/test-impack-api/activities.json";

  Future<List<Activity>> getAllActivity() async => [];

  Future<Activity> getActivity(int id) async => UninitializeActivity();

  Future<void> putActivity(Map<String, dynamic> newData) async {
    //
  }

  Future<void> postActivity(Activity newActivity) async {
    //
  }

  Future<void> deleteActivity(int id) async {
    //
  }
}
