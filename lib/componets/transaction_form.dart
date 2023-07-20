import 'package:expenses/componets/adaptive_textField.dart';
import 'package:flutter/material.dart';
import 'adaptive_button.dart';
import 'adaptive_picker.dart';

// ignore: use_key_in_widget_constructors
class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm(this.onSubmit, {Key? key}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value, _selectDate);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: 10 + MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: <Widget>[
              AdadptiveTextField(
                label: "Título",
                controller: _titleController,
                onSubmited: _submitForm,
              ),
              AdadptiveTextField(
                label: "Valor (R\$)",
                controller: _valueController,
                onSubmited: _submitForm,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
              AdaptiveDatePicker(
                selectedDate: _selectDate,
                onDateChanged: (newDate) {
                  setState(() {
                    _selectDate = newDate;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AdaptiveButton(
                    label: "Nova Transação",
                    onPressed: _submitForm,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
