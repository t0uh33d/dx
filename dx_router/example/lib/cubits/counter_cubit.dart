import 'package:dx_generator/dx_generator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@MarkCubitForDxRoute()
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void inc() => emit(state + 1);
  void dec() => emit(state - 1);
  void reset() => emit(0);
}
