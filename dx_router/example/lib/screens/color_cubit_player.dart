import 'package:dx_generator/dx_generator.dart';
import 'package:example/cubits/color_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_cubit/get_cubit.dart';

@GenerateDxRoute(cubits: [
  InjectCubit(
    cubit: ColorCubit,
    injectionMode: InjectionMode.find,
    id: '@(arg:index)',
    enableAutoCreate: true,
  )
])
class ColorCubitPlayer extends StatefulWidget {
  final int index;
  const ColorCubitPlayer({super.key, required this.index});

  @override
  State<ColorCubitPlayer> createState() => _ColorCubitPlayerState();
}

class _ColorCubitPlayerState extends State<ColorCubitPlayer> {
  late ColorCubit colorCubit;
  @override
  void initState() {
    colorCubit = GetCubit().find<ColorCubit>(
      id: widget.index.toString(),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BlocBuilder<ColorCubit, Color>(
            builder: (context, state) {
              return InkWell(
                onTap: () => colorCubit.random(),
                child: Container(
                  height: 200,
                  // width: 100,
                  color: state,
                  child: Center(
                    child: Text(
                      'Block ${widget.index} \n Click me to change color',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
