import 'package:bp_records/app_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/bp_record.dart';

class AddRecordPage extends StatefulWidget {
  const AddRecordPage({super.key});

  @override
  State<AddRecordPage> createState() => _AddRecordPageState();
}

class _AddRecordPageState extends State<AddRecordPage> {
  DateTime dateTaken = DateTime.now().toLocal();
  final _formKey = GlobalKey<FormState>();
  final _systolicController = TextEditingController();
  final _diastolicController = TextEditingController();
  final _pulseController = TextEditingController();
  final _temperatureController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppDataProvider>(
      builder: (context, provider, child) => _body(context, provider),
    );
  }

  void _editDateTaken(BuildContext context) async {
    final DateTime? datePicked = await showDatePicker(
      context: context,
      initialDate: dateTaken,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (datePicked == null) {
      return;
    }
    if (!context.mounted) {
      return;
    }
    final TimeOfDay? timePicked = await showTimePicker(
        context: context, initialTime: TimeOfDay.fromDateTime(dateTaken));
    if (timePicked == null || !context.mounted) {
      return;
    }
    setState(() {
      dateTaken = DateTime(datePicked.year, datePicked.month, datePicked.day,
          timePicked.hour, timePicked.minute);
    });
  }

  Widget _body(BuildContext context, AppDataProvider provider) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 100),
            const Text("Add Record",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 100),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      _editDateTaken(context);
                    },
                    child: Row(
                      children: [
                        const Text("Date Taken: "),
                        Text(DateFormat('dd/MM/yyyy hh:mm a')
                            .format(dateTaken!)),
                      ],
                    ),
                  ),
                  TextFormField(
                      controller: _systolicController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Systolic Blood Pressure',
                      ),
                      validator: (value) => provider.validateDiastolic(value)),
                  TextFormField(
                      controller: _diastolicController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Diastolic Blood Pressure',
                      ),
                      validator: (value) => provider.validateDiastolic(value)),
                  TextFormField(
                    controller: _pulseController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Pulse Rate',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter pulse rate';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _temperatureController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Temperature',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter temperature';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancel"),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            provider.addRecord();
                          }
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
