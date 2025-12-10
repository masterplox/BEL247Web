import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widgets/consumption_layout.dart';

class UsagePage extends ConsumerWidget {
  const UsagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        appBar: AppBar(
          title: const Text('Energy Consumption'),
          centerTitle: true,
          elevation: 0,
          actions: const [
            // IconButton(
            //   icon: const Icon(Icons.refresh),
            //   onPressed: () {
            //     // TODO: Implement refresh functionality
            //   },
            // ),
            // IconButton(
            //   icon: const Icon(Icons.download),
            //   onPressed: () {
            //     // TODO: Implement export functionality
            //   },
            // ),
          ],
        ),
        body: const ConsumptionLayout(),
      );
}
