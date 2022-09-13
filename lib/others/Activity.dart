// ignore_for_file: file_names

class Activity {
  static const String url =
      "https://ranggawiraguna.github.io/test-impack-api/activities.json";

  int id;
  String activityType;
  String institution;
  String when;
  String objective;
  String remarks;

  Activity({
    required this.id,
    required this.activityType,
    required this.institution,
    required this.when,
    required this.objective,
    required this.remarks,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "activityType": activityType,
        "institution": institution,
        "when": when,
        "objective": objective,
        "remarks": remarks,
      };

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        id: json['id'],
        activityType: json['activityType'],
        institution: json['institution'],
        when: json['when'],
        objective: json['objective'],
        remarks: json['remarks'],
      );
}

class UninitializeActivity extends Activity {
  UninitializeActivity()
      : super(
          id: -1,
          activityType: '',
          institution: '',
          when: '',
          objective: '',
          remarks: '',
        );
}
