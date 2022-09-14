// ignore_for_file: file_names

class Activity {
  int id;
  String activityType, institution, when, objective, remarks, result;

  Activity({
    required this.id,
    required this.activityType,
    required this.institution,
    required this.when,
    required this.objective,
    required this.remarks,
    required this.result,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "activityType": activityType,
        "institution": institution,
        "when": when,
        "objective": objective,
        "remarks": remarks,
        "result": result,
      };

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        id: json['id'],
        activityType: json['activityType'],
        institution: json['institution'],
        when: json['when'],
        objective: json['objective'],
        remarks: json['remarks'],
        result: json['result'],
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
          result: '',
        );
}
