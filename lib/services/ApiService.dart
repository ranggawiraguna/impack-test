import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_impack/models/Activity.dart';

class ApiService {
  ApiService._internal();

  factory ApiService() => _instance;
  static final ApiService _instance = ApiService._internal();
  static const String _root =
      "https://xdummydatax-default-rtdb.firebaseio.com/test-impack";
  static Uri _url(String urlString) => Uri.parse("$urlString.json");

  Future<List<Activity>> getAllActivity() async {
    try {
      final response = (await http.get(_url("$_root/activities")));
      Map<String, dynamic> json =
          jsonDecode(response.body) as Map<String, dynamic>;

      return response.statusCode == 200 && json.isNotEmpty
          ? json.keys
              .map(
                (key) => Activity.fromJson(
                  {
                    "id": key,
                    ...json[key]!,
                  },
                ),
              )
              .toList()
          : [];
    } catch (_) {
      return [];
    }
  }

  Future<Activity> getActivity(int id) async {
    try {
      return Activity.fromJson(
        {
          "id": id,
          ...jsonDecode((await http.get(_url("$_root/activities/$id"))).body)
              as Map<String, dynamic>,
        },
      );
    } catch (_) {
      return Activity.empty();
    }
  }

  Future<bool> putActivity(String id, Map<String, dynamic> newData) async {
    try {
      return (await http.put(_url("$_root/activities/$id"),
                      body: json.encode(newData)))
                  .statusCode ==
              200
          ? true
          : false;
    } catch (_) {
      return false;
    }
  }

  Future<String> postActivity(Map<String, dynamic> newData) async {
    try {
      final response = await http.post(_url("$_root/activities"),
          body: json.encode(newData));
      String newId =
          (json.decode(response.body) as Map<String, dynamic>)['name']
              .toString();

      return response.statusCode == 200 && newId.isNotEmpty ? newId : '';
    } catch (_) {
      return '';
    }
  }

  Future<bool> deleteActivity(String id) async {
    try {
      return (await http.delete(_url("$_root/activities/$id"))).statusCode ==
              200
          ? true
          : false;
    } catch (_) {
      return false;
    }
  }
}
