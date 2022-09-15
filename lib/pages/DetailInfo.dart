import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_impack/others/Activity.dart';
import 'package:test_impack/others/AppTheme.dart';
import 'package:test_impack/pages/EditInfo.dart';
import 'package:test_impack/widgets/ButtonSubmitForm.dart';
import 'package:test_impack/widgets/FormGroup.dart';
import 'package:test_impack/widgets/PageContainer.dart';

class DetailInfo extends StatefulWidget {
  final Activity activity;

  const DetailInfo({Key? key, required this.activity}) : super(key: key);

  @override
  State<DetailInfo> createState() => _DetailInfoState();
}

class _DetailInfoState extends State<DetailInfo> {
  late final AppTheme theme;
  final TextEditingController resultController = TextEditingController();

  @override
  void initState() {
    theme = AppTheme(context);
    super.initState();
  }

  void updateActivyFinished() {
    //
  }

  @override
  Widget build(BuildContext context) {
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
                        '${widget.activity.activityType.split('_').map((e) => '${e[0].toUpperCase()}${e.substring(1)}').join(' ')} with ${widget.activity.institution} on ${DateFormat('d MMMM y').format(DateTime.parse(widget.activity.when))} at ${DateFormat('HH:mm').format(DateTime.parse(widget.activity.when))} to discuss about ${widget.activity.objective.split('_').map((e) => '${e[0].toUpperCase()}${e.substring(1)}').join(' ')}',
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
                        widget.activity.remarks,
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
                                  activity: widget.activity,
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
                            backgroundColor: theme.colorPrimary,
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
                onClick: () => updateActivyFinished(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
