import 'package:flutter/material.dart';

class AddRecordPage extends StatefulWidget {
  const AddRecordPage({super.key});

  @override
  State<AddRecordPage> createState() => _AddRecordPageState();
}

class _AddRecordPageState extends State<AddRecordPage> {
  final _formKey = GlobalKey<FormState>();
  final _systolicController = TextEditingController();
  final _diastolicController = TextEditingController();
  final _pulseController = TextEditingController();
  final _temperatureController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _systolicController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Systolic Blood Pressure',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter systolic blood pressure';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _diastolicController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Diastolic Blood Pressure',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter diastolic blood pressure';
                  }
                  return null;
                },
              ),
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
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process the form data here, e.g., send it to a server
                    print('Systolic: ${_systolicController.text}');
                    print('Diastolic: ${_diastolicController.text}');
                    print('Pulse: ${_pulseController.text}');
                    print('Temperature: ${_temperatureController.text}');
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
