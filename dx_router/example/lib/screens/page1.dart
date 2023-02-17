import 'package:dx_generator/dx_generator.dart';
import 'package:dx_router/dx_router.dart';
import 'package:example/cubits/color_cubit.dart';
import 'package:example/cubits/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_cubit/get_cubit.dart';

@GenerateDxRoute()
class Page1 extends StatelessWidget {
  final String var1;
  final int i;
  final bool checkBool;
  final double d;
  Page1({
    super.key,
    required this.var1,
    required this.checkBool,
    required this.d,
    required this.i,
  });
  ColorCubit colorCubit = GetCubit().find<ColorCubit>();
  CounterCubit counterCubit = GetCubit().find<CounterCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(var1),
            ElevatedButton(
                onPressed: () {
                  DxRouter.pop(context);
                },
                child: const Text("POP")),
            Text(checkBool.toString()),
            Text(d.toString()),
            Text(i.toString()),
            const SizedBox(height: 10),
            BlocBuilder<ColorCubit, Color>(
              builder: (context, state) {
                return InkWell(
                  onTap: () => colorCubit.random(),
                  child: Container(
                    height: 100,
                    width: 100,
                    color: state,
                    child: const Center(
                      child: Text(
                        'Click me to change color',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 2,
              children: [
                ElevatedButton(
                    onPressed: () => counterCubit.dec(),
                    child: const Text("dec")),
                BlocBuilder<CounterCubit, int>(
                  builder: (context, state) {
                    return Text(
                      '$state',
                      style: const TextStyle(fontSize: 22),
                    );
                  },
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
      ),
    );
  }
}
