import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdaptiveDatePicker extends StatelessWidget {
  late final DateTime? selectedDate;
  final Function(DateTime) onDateChanged;

  AdaptiveDatePicker({
    required this.onDateChanged,
    this.selectedDate,
  });

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      onDateChanged(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return defaultTargetPlatform == TargetPlatform.iOS
        ? SizedBox(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              maximumDate: DateTime.now(),
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(2019),
              onDateTimeChanged: onDateChanged,
            ),
          )
        : SizedBox(
            height: 70,
            child: Row(
              children: <Widget>[
                // ignore: unnecessary_null_comparison
                Expanded(
                  child: Text(
                    selectedDate == null
                        ? "Nenhuma Data Selecionada"
                        : "Data Selecionada : ${DateFormat("dd/MM/yy").format(selectedDate!)}",
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _showDatePicker(context),
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                      foregroundColor: Theme.of(context).primaryColor),
                  child: const Text(
                    "Selecionar Data",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
