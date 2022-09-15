import 'package:flutter/material.dart';
import 'package:test_impack/others/Activity.dart';
import 'package:test_impack/others/ApiService.dart';
import 'package:test_impack/others/AppTheme.dart';
import 'package:test_impack/widgets/ButtonSubmitForm.dart';
import 'package:test_impack/widgets/FormGroup.dart';
import 'package:test_impack/widgets/PageContainer.dart';

class CreateNew extends StatefulWidget {
  const CreateNew({Key? key}) : super(key: key);

  @override
  State<CreateNew> createState() => _CreateNewState();
}

class _CreateNewState extends State<CreateNew> {
  late final AppTheme theme;
  late final ApiService apiService;
  late final List<FormItem> forms;

  @override
  void initState() {
    theme = AppTheme(context);
    apiService = ApiService();
    forms = [
      FormItem(
        type: FormInput.Dropdown,
        title: "What do you want to do ?",
        hint: "Meeting or Call",
        controller: TextEditingController(),
        values: ["phone_call", "meeting"],
      ),
      FormItem(
        type: FormInput.TextField,
        title: "Who do you want to meet or call ?",
        hint: "Institusion or People",
        controller: TextEditingController(),
      ),
      FormItem(
        type: FormInput.DatePicker,
        title: "When do you want to meet or call ?",
        hint: "Activity Date",
        controller: TextEditingController(),
      ),
      FormItem(
        type: FormInput.Dropdown,
        title: "Why do you want to meet or call ?",
        hint: "New Order, Invoice or New Leads",
        controller: TextEditingController(),
        values: ["new_order", "invoice", "new_leads"],
      ),
      FormItem(
        type: FormInput.TextField,
        title: "Could you describe it more details ?",
        hint: "More Description",
        controller: TextEditingController(),
        minHeight: 300,
      ),
    ];
    super.initState();
  }

  void submitFormToNewActivity() {
    if (forms
        .map((form) => form.controller)
        .every((controller) => controller.text.isNotEmpty)) {
      apiService.postActivity(
        Activity.createNew(
          activityType: forms[0].controller.text,
          institution: forms[1].controller.text,
          when: forms[2].controller.text,
          objective: forms[3].controller.text,
          remarks: forms[4].controller.text,
        ).toJson(),
      );
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
      title: 'New Activity',
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
              ...forms
                  .map(
                    (form) => FormGroup(
                      form: form,
                      refresh: () => setState(() {}),
                    ),
                  )
                  .toList(),
              SizedBox(height: theme.size(50)),
              ButtonSubmitForm(
                text: 'Submit Activity',
                onClick: () => submitFormToNewActivity(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
