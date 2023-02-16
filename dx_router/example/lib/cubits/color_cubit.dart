import 'dart:math';

import 'package:dx_generator/dx_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@MarkCubitForDxRoute()
class ColorCubit extends Cubit<Color> {
  ColorCubit() : super(Colors.primaries.first);

  void random() {
    Color color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    emit(color);
  }
}
