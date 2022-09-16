import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_impack/models/Activity.dart';
import 'package:test_impack/providers/Activities.dart';
import 'package:test_impack/services/ApiService.dart';
import 'package:test_impack/services/AppTheme.dart';
import 'package:test_impack/widgets/ButtonSubmitForm.dart';
import 'package:test_impack/widgets/FormGroup.dart';
import 'package:test_impack/widgets/PageContainer.dart';

class EditInfo extends StatefulWidget {
  final String id;

  const EditInfo({Key? key, required this.id}) : super(key: key);

  @override
  State<EditInfo> createState() => _EditInfoState();
}

class _EditInfoState extends State<EditInfo> {
  late final AppTheme theme;
  late final ApiService apiService;
  late final Map<String, FormItem> forms;

  bool _alreadySetInitValues = false;

  @override
  void initState() {
    theme = AppTheme(context);
    apiService = ApiService();
    forms = {
      "activityType": FormItem(
        type: FormInput.Dropdown,
        title: "What do you want to do ?",
        hint: "Meeting or Call",
        controller: TextEditingController(),
        values: ["phone_call", "meeting"],
      ),
      "institution": FormItem(
        type: FormInput.TextField,
        title: "Who do you want to meet or call ?",
        hint: "Institusion or People",
        controller: TextEditingController(),
      ),
      "when": FormItem(
        type: FormInput.DatePicker,
        title: "When do you want to meet or call ?",
        hint: "Activity Date",
        controller: TextEditingController(),
      ),
      "objective": FormItem(
        type: FormInput.Dropdown,
        title: "Why do you want to meet or call ?",
        hint: "New Order, Invoice or New Leads",
        controller: TextEditingController(),
        values: ["new_order", "invoice", "new_leads"],
      ),
      "remarks": FormItem(
        type: FormInput.TextField,
        title: "Could you describe it more details ?",
        hint: "More Description",
        controller: TextEditingController(),
        minHeight: 300,
      ),
    };
    super.initState();
  }

  void submitFormToExistingActivity(Activities activities) {
    if (forms.values
        .map((form) => form.controller)
        .every((controller) => controller.text.isNotEmpty)) {
      Map<String, String> dataUpdated = {};
      forms.forEach((key, value) {
        if (forms[key]!.controller.text !=
            activities.selectById(widget.id).toJson()[key]) {
          dataUpdated.addAll({key: value.controller.text});
        }
      });

      if (dataUpdated.isNotEmpty) {
        activities.editActivity(
          activities.selectById(widget.id).id,
          Activity.fromJson({
            'id': activities.selectById(widget.id).id,
            ...activities.selectById(widget.id).toJson(),
            ...dataUpdated
          }),
          (bool success) {
            if (success) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Successfully update data")),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Failed to update data")),
              );
            }
          },
        );
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
    final Activities activities = Provider.of<Activities>(context);

    if (!_alreadySetInitValues && !activities.selectById(widget.id).isEmpty) {
      for (var key in forms.keys) {
        forms[key]!.controller.text =
            activities.selectById(widget.id).toJson()[key];
      }
      setState(() => _alreadySetInitValues = true);
    }

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
                onClick: () => submitFormToExistingActivity(activities),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
