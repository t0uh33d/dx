// ignore_for_file: public_member_api_docs, sort_constructors_first
class GenerateDxRoute {
  final bool isInitialRoute;
  final List<InjectCubit> cubits;
  const GenerateDxRoute({
    this.isInitialRoute = false,
    this.cubits = const <InjectCubit>[],
  });
}

class MarkCubitForDxRoute {
  const MarkCubitForDxRoute();
}

class InjectCubit {
  final Type cubit;
  final InjectionMode injectionMode;
  final String? id;
  const InjectCubit({
    required this.cubit,
    required this.injectionMode,
    this.id,
  });
}

enum InjectionMode { find, put }
