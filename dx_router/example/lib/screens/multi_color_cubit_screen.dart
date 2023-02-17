import 'package:dx_generator/dx_generator.dart';
import 'package:dx_router/dx_router.dart';
import 'package:example/dx_gen/routes.dx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_cubit/get_cubit.dart';

import '../cubits/color_cubit.dart';

@GenerateDxRoute()
class MultiColorCubitScreen extends StatefulWidget {
  const MultiColorCubitScreen({super.key});

  @override
  State<MultiColorCubitScreen> createState() => _MultiColorCubitScreenState();
}

class _MultiColorCubitScreenState extends State<MultiColorCubitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          ColorCubit colorCubit =
              GetCubit().put(ColorCubit(), id: index.toString());
          return BlocProvider.value(
            value: colorCubit,
            child: colorCubitBlock(colorCubit, index),
          );
        },
      ),
    );
  }

  Widget colorCubitBlock(ColorCubit colorCubit, int index) {
    return Wrap(
      children: [
        BlocBuilder<ColorCubit, Color>(
          builder: (context, state) {
            print('building $index');
            return InkWell(
              onTap: () => colorCubit.random(),
              child: Container(
                height: 100,
                width: 100,
                color: state,
                child: Center(
                  child: Text(
                    'Block $index \n Click me to change color',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
          },
        ),
        ElevatedButton(
            onPressed: () {
              DxRouter.to(DxColorCubitPlayer(index: index), context);
            },
            child: const Text("pass and work with this cubit in next screen")),
      ],
    );
  }
}
