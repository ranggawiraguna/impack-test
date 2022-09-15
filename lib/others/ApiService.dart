import 'package:test_impack/others/Activity.dart';

class ApiService {
  ApiService._internal();

  factory ApiService() => _instance;
  static final ApiService _instance = ApiService._internal();
  static const String _root = "https://xdummydatax-default-rtdb.firebaseio.com";

  Future<List<Activity>> getAllActivity() async => [];

  Future<Activity> getActivity(int id) async => UninitializeActivity();

  Future<void> putActivity(Map<String, dynamic> newData) async {
    //
  }

  Future<void> postActivity(Map<String, dynamic> newActivity) async {
    //
  }

  Future<void> deleteActivity(int id) async {
    //
  }
}
