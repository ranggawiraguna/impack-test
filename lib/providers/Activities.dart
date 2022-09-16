import 'dart:async';
import 'package:flutter/material.dart';
import 'package:test_impack/models/Activity.dart';
import 'package:test_impack/services/ApiService.dart';

class Activities with ChangeNotifier {
  final ApiService apiService = ApiService();

  List<Activity> _data = [];

  Activities() {
    apiService.getAllActivity().then((activities) {
      _data = activities;
      notifyListeners();
    });
  }

  List<Activity> get data => _data;

  Activity selectById(String id) {
    return _data.firstWhere((element) => element.id == id,
        orElse: () => Activity.empty());
  }

  Future<void> addActivity(
    Activity newActivity,
    Function(bool status) showAlert,
  ) async {
    await apiService.postActivity(newActivity.toJson()).then((status) {
      _data.add(newActivity);
      notifyListeners();
      showAlert(status);
    });
  }

  Future<void> editActivity(
    String id,
    Activity newActivity,
    Function(bool status) showAlert,
  ) async {
    await apiService.putActivity(id, newActivity.toJson()).then((status) {
      final int dataIndex = _data.indexWhere((activity) => activity.id == id);
      _data.replaceRange(
        dataIndex,
        dataIndex + 1,
        [newActivity],
      );
      notifyListeners();
      showAlert(status);
    });
  }

  Future<void> deleteActivity(
    String id,
    Function(bool status) showAlert,
  ) async {
    await apiService.deleteActivity(id).then((status) {
      _data.removeWhere((activity) => activity.id == id);
      notifyListeners();
      showAlert(status);
    });
  }
}
