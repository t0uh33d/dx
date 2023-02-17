import 'package:dx_generator/dx_generator.dart';
import 'package:example/cubits/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_cubit/get_cubit.dart';

@GenerateDxRoute()
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  CounterCubit counterCubit = GetCubit().put(CounterCubit());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            // spacing: 2,
            children: [
              ElevatedButton(
                  onPressed: () => counterCubit.dec(),
                  child: const Text("dec")),
              BlocProvider.value(
                value: counterCubit,
                child: _counter(),
              ),
              ElevatedButton(
                  onPressed: () => counterCubit.inc(),
                  child: const Text("inc")),
              ElevatedButton(
                  onPressed: () => counterCubit.reset(),
                  child: const Text("reset")),
            ],
          ),
        ],
      ),
    );
  }

  Widget _counter() {
    return BlocBuilder<CounterCubit, int>(
      builder: (context, state) {
        return Text(
          '$state',
          style: const TextStyle(fontSize: 22),
        );
      },
    );
  }
}
