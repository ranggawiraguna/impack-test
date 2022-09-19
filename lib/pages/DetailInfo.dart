import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_impack/models/Activity.dart';
import 'package:test_impack/providers/Activities.dart';
import 'package:test_impack/services/AppTheme.dart';
import 'package:test_impack/pages/EditInfo.dart';
import 'package:test_impack/widgets/ButtonSubmitForm.dart';
import 'package:test_impack/widgets/FormGroup.dart';
import 'package:test_impack/widgets/PageContainer.dart';

class DetailInfo extends StatefulWidget {
  final String id;

  const DetailInfo({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailInfo> createState() => _DetailInfoState();
}

class _DetailInfoState extends State<DetailInfo> {
  late final AppTheme theme;
  final TextEditingController resultController = TextEditingController();
  bool _alreadySetInitValues = false;

  @override
  void initState() {
    theme = AppTheme(context);
    super.initState();
  }

  void updateActivyFinished(Activities activities) {
    if (resultController.text.isNotEmpty &&
        resultController.text != activities.selectById(widget.id).result) {
      activities.editActivity(
        activities.selectById(widget.id).id,
        Activity.fromJson({
          'id': activities.selectById(widget.id).id,
          ...activities.selectById(widget.id).toJson(),
          'result': resultController.text,
        }),
        (bool success) {
          if (success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text("Successfully update activity result")),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Failed to update activity result")),
            );
          }
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter the activity result correctly"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Activities activities = Provider.of<Activities>(context);
    final Activity activity = activities.selectById(widget.id);

    if (activity.result.isNotEmpty && !_alreadySetInitValues) {
      resultController.text = activity.result;
      setState(() => _alreadySetInitValues = true);
    }

    return PageContainer(
      title: 'Activity Info',
      withBackButton: true,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            top: theme.size(50),
            left: theme.size(30),
            right: theme.size(30),
            bottom: theme.size(90),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: theme.size(15)),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    left: theme.size(40),
                    right: theme.size(40),
                    top: theme.size(30),
                    bottom: theme.size(25),
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFBFB5B5).withOpacity(0.15),
                    borderRadius:
                        BorderRadius.all(Radius.circular(theme.size(25))),
                    border: Border.all(
                      color: Colors.black.withOpacity(0.1),
                      width: theme.size(6),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Details',
                        style: TextStyle(
                          fontSize: theme.size(40),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: theme.size(20)),
                      Text(
                        '${activity.activityType.split('_').map((e) => '${e[0].toUpperCase()}${e.substring(1)}').join(' ')} with ${activity.institution} on ${DateFormat('d MMMM y').format(activity.when)} at ${DateFormat('HH:mm').format(activity.when)} to discuss about ${activity.objective.split('_').map((e) => '${e[0].toUpperCase()}${e.substring(1)}').join(' ')}',
                        style: TextStyle(
                          fontSize: theme.size(38),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: theme.size(25),
                        ),
                        child: Container(
                          height: 2,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(1),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        activity.remarks,
                        style: TextStyle(
                          fontSize: theme.size(38),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: theme.size(25),
                        ),
                        child: Container(
                          height: 2,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(1),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EditInfo(
                                  id: widget.id,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: EdgeInsets.all(theme.size(30)),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(theme.size(1000)),
                            ),
                            backgroundColor: theme.colorCardItem,
                          ),
                          child: Text(
                            "Edit Activity",
                            style: TextStyle(
                              fontSize: theme.size(42),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: theme.size(50)),
              FormGroup(
                form: FormItem(
                  type: FormInput.TextField,
                  title: "What is the result of the Activity ?",
                  hint: "Result Description",
                  controller: resultController,
                  minHeight: 300,
                ),
                refresh: () => setState(() {}),
              ),
              SizedBox(height: theme.size(10)),
              ButtonSubmitForm(
                text: 'Complete Activity',
                onClick: () => updateActivyFinished(activities),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
