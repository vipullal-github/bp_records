import 'package:bp_records/models/bp_record.dart';
import 'package:bp_records/ui/bp_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_data_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void onAddButtonPressed(BuildContext context) {
    Navigator.of(context).pushNamed("addRecordPage");
  }

  Widget _doBuild(BuildContext context, AppDataProvider provider) {
    return Scaffold(
      appBar: AppBar(title: const Text("BP records")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text("Hello, world")
          Expanded(
            child: ListView.builder(
              itemCount: provider.records.length,
              itemBuilder: (context, index) {
                BpRecord arec = provider.records[index];
                return BpWidget(
                  rec: arec,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onAddButtonPressed(context);
        },
        tooltip: "add",
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppDataProvider>(
      builder: (context, provider, child) {
        return _doBuild(context, provider);
      },
    );
  }
}
