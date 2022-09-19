import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_impack/services/AppTheme.dart';

class FormGroup extends StatelessWidget {
  final FormItem form;
  final void Function() refresh;

  const FormGroup({
    super.key,
    required this.form,
    required this.refresh,
  });

  Widget InputWidget(AppTheme theme) {
    switch (form.type) {
      case FormInput.TextField:
        return TextField(
          readOnly: form.type == FormInput.DatePicker ? true : false,
          controller: form.controller,
          maxLines: form.minHeight > 125 ? null : 1,
          decoration: InputDecoration.collapsed(hintText: form.hint),
          style: TextStyle(fontSize: theme.size(38)),
        );

      case FormInput.Dropdown:
        return DropdownButton<String>(
          value: form.controller.text.isEmpty ? null : form.controller.text,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          isDense: true,
          isExpanded: true,
          iconSize: theme.size(65),
          hint: Text(
            form.hint,
            style: TextStyle(fontSize: theme.size(38)),
          ),
          style: const TextStyle(color: Colors.black),
          underline: const SizedBox.shrink(),
          onChanged: (String? newValue) {
            form.controller.text = newValue ?? '';
            refresh();
          },
          items: form.values != null
              ? form.values!
                  .map(
                    (dropdownValue) => DropdownMenuItem<String>(
                      value: dropdownValue,
                      child: Text(
                        dropdownValue
                            .split('_')
                            .map(
                                (e) => '${e[0].toUpperCase()}${e.substring(1)}')
                            .join(' '),
                      ),
                    ),
                  )
                  .toList()
              : [],
        );

      case FormInput.DatePicker:
        return Text(
          DateTime.tryParse(form.controller.text) != null
              ? DateFormat('d MMMM y - HH:mm').format(
                  DateTime.parse(form.controller.text),
                )
              : 'Activity Date',
          style: TextStyle(
            fontSize: theme.size(38),
            color: Colors.black.withOpacity(
              DateTime.tryParse(form.controller.text) != null ? 1 : 0.6,
            ),
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = AppTheme(context);

    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: theme.size(30), horizontal: theme.size(20)),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              form.title,
              style: TextStyle(
                fontSize: theme.size(38),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: theme.size(20)),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
                horizontal: theme.size(40), vertical: theme.size(30)),
            constraints: BoxConstraints(minHeight: theme.size(form.minHeight)),
            decoration: BoxDecoration(
              color: const Color(0xFFBFB5B5).withOpacity(0.15),
              borderRadius: BorderRadius.all(Radius.circular(theme.size(25))),
              border: Border.all(
                color: Colors.black.withOpacity(0.1),
                width: theme.size(6),
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Row(
                crossAxisAlignment: form.minHeight <= 125
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  Expanded(child: InputWidget(theme)),
                  form.type == FormInput.TextField && form.minHeight <= 125
                      ? Icon(
                          Icons.search,
                          size: theme.size(50),
                        )
                      : form.type == FormInput.DatePicker
                          ? IconButton(
                              icon: const Icon(Icons.calendar_month_rounded),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              splashRadius: null,
                              iconSize: theme.size(50),
                              onPressed: () async {
                                await showDatePicker(
                                  context: context,
                                  initialDate:
                                      DateTime.tryParse(form.controller.text) !=
                                              null
                                          ? DateTime.parse(form.controller.text)
                                          : DateTime.now(),
                                  firstDate: DateTime.tryParse(
                                              form.controller.text) !=
                                          null
                                      ? DateTime.parse(form.controller.text)
                                                  .compareTo(DateTime.now()) <=
                                              0
                                          ? DateTime.parse(form.controller.text)
                                          : DateTime.now()
                                      : DateTime.now(),
                                  lastDate: DateTime(
                                    DateTime.now().year + 10,
                                    12,
                                    0,
                                  ),
                                ).then(
                                  (final DateTime? datePicked) async {
                                    if (datePicked != null) {
                                      await showTimePicker(
                                        context: context,
                                        initialTime: const TimeOfDay(
                                          hour: 0,
                                          minute: 0,
                                        ),
                                      ).then(
                                        (TimeOfDay? timePicked) {
                                          if (timePicked != null) {
                                            form.controller.text = DateTime(
                                              datePicked.year,
                                              datePicked.month,
                                              datePicked.day,
                                              timePicked.hour,
                                              timePicked.minute,
                                            ).toString();
                                            refresh();
                                          }
                                        },
                                      );
                                    }
                                  },
                                );
                              },
                            )
                          : const SizedBox.shrink(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FormItem {
  final FormInput type;
  final String title;
  final String hint;
  final TextEditingController controller;
  final double minHeight;
  final List<String>? values;

  FormItem({
    required this.type,
    required this.title,
    required this.hint,
    required this.controller,
    this.minHeight = 125,
    this.values,
  });
}

enum FormInput { TextField, Dropdown, DatePicker }
