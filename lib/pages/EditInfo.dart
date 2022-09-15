import 'package:flutter/material.dart';
import 'package:test_impack/others/Activity.dart';
import 'package:test_impack/others/ApiService.dart';
import 'package:test_impack/others/AppTheme.dart';
import 'package:test_impack/widgets/ButtonSubmitForm.dart';
import 'package:test_impack/widgets/FormGroup.dart';
import 'package:test_impack/widgets/PageContainer.dart';

class EditInfo extends StatefulWidget {
  final Activity activity;

  const EditInfo({Key? key, required this.activity}) : super(key: key);

  @override
  State<EditInfo> createState() => _EditInfoState();
}

class _EditInfoState extends State<EditInfo> {
  late final AppTheme theme;
  late final ApiService apiService;
  late final Map<String, FormItem> forms;

  @override
  void initState() {
    theme = AppTheme(context);
    apiService = ApiService();
    forms = {
      "activityType": FormItem(
        type: FormInput.Dropdown,
        title: "What do you want to do ?",
        hint: "Meeting or Call",
        controller: TextEditingController(text: widget.activity.activityType),
        values: ["phone_call", "meeting"],
      ),
      "institution": FormItem(
        type: FormInput.TextField,
        title: "Who do you want to meet or call ?",
        hint: "Institusion or People",
        controller: TextEditingController(text: widget.activity.institution),
      ),
      "when": FormItem(
        type: FormInput.DatePicker,
        title: "When do you want to meet or call ?",
        hint: "Activity Date",
        controller: TextEditingController(text: widget.activity.when),
      ),
      "objective": FormItem(
        type: FormInput.Dropdown,
        title: "Why do you want to meet or call ?",
        hint: "New Order, Invoice or New Leads",
        controller: TextEditingController(text: widget.activity.objective),
        values: ["new_order", "invoice", "new_leads"],
      ),
      "remarks": FormItem(
        type: FormInput.TextField,
        title: "Could you describe it more details ?",
        hint: "More Description",
        controller: TextEditingController(text: widget.activity.remarks),
        minHeight: 300,
      ),
    };
    super.initState();
  }

  void submitFormToExistingActivity() {
    if (forms.values
        .map((form) => form.controller)
        .every((controller) => controller.text.isNotEmpty)) {
      Map<String, String> dataUpdated = {};
      forms.forEach((key, value) {
        if (forms[key]!.controller.text != widget.activity.toJson()[key]) {
          dataUpdated.addAll({key: value.controller.text});
        }
      });

      if (dataUpdated.isNotEmpty) {
        apiService.putActivity(dataUpdated);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please check the data you want to change"),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please complete the form correctly"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: 'Edit Activity',
      withBackButton: true,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            top: theme.size(30),
            left: theme.size(30),
            right: theme.size(30),
            bottom: theme.size(90),
          ),
          child: Column(
            children: [
              ...forms.values
                  .map(
                    (form) => FormGroup(
                      form: form,
                      refresh: () => setState(() {}),
                    ),
                  )
                  .toList(),
              SizedBox(height: theme.size(50)),
              ButtonSubmitForm(
                text: 'Edit Activity',
                onClick: () => submitFormToExistingActivity(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
