import 'package:bp_records/models/bp_record.dart';
import 'package:bp_records/ui/bp_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../app_data_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void onAddButtonPressed(BuildContext context) {
    Navigator.of(context).pushNamed("addRecordPage");
  }

  Widget _loadingInitialData(BuildContext context) {
    return const Center(
      child: Row(
        children: [
          Text("LOading initial data..."),
          SizedBox(width: 10),
          CircularProgressIndicator()
        ],
      ),
    );
  }

  Widget _itemsListView(BuildContext context, AppDataProvider provider) {
    return Column(
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
    );
  }

  Widget _doBuild(BuildContext context, AppDataProvider provider) {
    return Scaffold(
      appBar: AppBar(title: const Text("BP records")),
      body: _itemsListView(context, provider),
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
        switch (provider.state) {
          case ProviderState.stateInitial:
            provider.initSelf();
            return _loadingInitialData(context);
          case ProviderState.stateInitialDataLoaded:
          case ProviderState.stateEditSaved:
            break;
          case ProviderState.stateBeginEdit:
            SchedulerBinding.instance.addPostFrameCallback(
              (_) => Navigator.of(context).pushNamed("addRecordPage"),
            );
            break;
        }
        return _doBuild(context, provider);
      },
    );
  }
}
