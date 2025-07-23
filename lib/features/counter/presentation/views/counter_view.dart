import 'package:eco_step/core/util/style/typography.dart';
import 'package:eco_step/features/counter/presentation/viewmodels/counter_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
      ),
      body: GetBuilder<CounterViewModel>(
        builder: (viewModel) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Counter Value:',
                  style: Typo.titleRegular(context),
                ),
                const SizedBox(height: 20),
                Obx(() => Text(
                      '${viewModel.counter.value}',
                      style: Typo.displayStrong(context),
                    )),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      onPressed: viewModel.decrement,
                      heroTag: 'decrement',
                      child: const Icon(Icons.remove),
                    ),
                    FloatingActionButton(
                      onPressed: viewModel.increment,
                      heroTag: 'increment',
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
