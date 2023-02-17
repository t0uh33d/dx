part of DxRouterGenerator;

extension LibraryHelpers on DxBuilder {
  Future<LibraryElement> _getLibraryElement(
      BuildStep buildStep, AssetId assetId) async {
    return await buildStep.resolver.libraryFor(assetId);
  }

  Future<List<DxAnnotatedClass>> _getDxAnnotatedClasses(
      BuildStep buildStep) async {
    Glob glob = Glob('lib/**.dart');
    List<AssetId> assets = await buildStep.findAssets(glob).toList();
    List<DxAnnotatedClass> dxAnnotatedClasses = [];
    for (int idx = 0; idx < assets.length; idx++) {
      LibraryElement libraryElement =
          await _getLibraryElement(buildStep, assets[idx]);
      LibraryReader libraryReader = LibraryReader(libraryElement);

      List<AnnotatedElement> annotatedElements = libraryReader
          .annotatedWith(const TypeChecker.fromRuntime(GenerateDxRoute))
          .toList();

      for (var ele in annotatedElements) {
        DxRouteClassVisitor dxRouteClassVisior = DxRouteClassVisitor();
        ele.element.visitChildren(dxRouteClassVisior);
        DxAnnotatedClass dxAnnonatedClass = DxAnnotatedClass(
          className: dxRouteClassVisior.className.toString(),
          constantReader: ele.annotation,
          params: dxRouteClassVisior.params,
          importPath:
              "import 'package:${assets[idx].path.replaceAll('lib', assets[idx].package)}';",
          relativePath: assets[idx].path,
          isInitialRoute: ele.annotation.read('isInitialRoute').boolValue,
          cubits: _cubitResolver(
              ele.annotation, dxRouteClassVisior.className.toString()),
        );

        dxAnnotatedClasses.add(dxAnnonatedClass);
      }
    }
    return dxAnnotatedClasses;
  }

  Future<List<MarkedCubit>> _getMarkedCubits(BuildStep buildStep) async {
    Glob glob = Glob('lib/**.dart');
    List<AssetId> assets = await buildStep.findAssets(glob).toList();
    List<MarkedCubit> markedCubits = [];
    for (int idx = 0; idx < assets.length; idx++) {
      LibraryElement libraryElement =
          await _getLibraryElement(buildStep, assets[idx]);
      LibraryReader libraryReader = LibraryReader(libraryElement);

      List<AnnotatedElement> annotatedElements = libraryReader
          .annotatedWith(const TypeChecker.fromRuntime(MarkCubitForDxRoute))
          .toList();

      for (var ele in annotatedElements) {
        DxRouteClassVisitor dxRouteClassVisior = DxRouteClassVisitor();
        ele.element.visitChildren(dxRouteClassVisior);
        MarkedCubit dxAnnonatedClass = MarkedCubit(
          className: dxRouteClassVisior.className.toString(),
          constantReader: ele.annotation,
          params: dxRouteClassVisior.params,
          importPath:
              "import 'package:${assets[idx].path.replaceAll('lib', assets[idx].package)}';",
          relativePath: assets[idx].path,
        );
        markedCubits.add(dxAnnonatedClass);
      }
    }
    return markedCubits;
  }

  List<String> _cubitResolver(ConstantReader constantReader, String className) {
    List<String> cubits = [];
    List<DartObject> dartObjects = constantReader.read('cubits').listValue;
    if (dartObjects.isNotEmpty) {
      for (int idx = 0; idx < dartObjects.length; idx++) {
        String cubitType =
            _cubitType(dartObjects[idx].getField('cubit').toString());
        String injectionMode = _injectionMode(
            dartObjects[idx].getField('injectionMode').toString());
        String? id = _id(dartObjects[idx].getField('id').toString());
        String enableAutoCreate =
            dartObjects[idx].getField('enableAutoCreate').toString();
        String c = 'GetCubit().';
        if (injectionMode == "put") {
          c +=
              "put($cubitType()${id != null && id.isNotEmpty ? ',id : \'${_idParser(id, className)}\'' : ''})";
        } else {
          c +=
              "find<$cubitType>(${id != null && id.isNotEmpty ? 'id : \'${_idParser(id, className)}\'' : ''}${_autoCreate(enableAutoCreate, cubitType)})";
        }

        cubits.add(c);
      }
    }
    return cubits;
  }

  String _cubitType(String str) {
    final RegExp regex = RegExp(r'Type \((\w+)\*\)');
    return str.replaceAll(regex, '${regex.firstMatch(str)!.group(1)}');
  }

  String _injectionMode(String str) {
    final RegExp regex = RegExp(r"_name = String \('(\w+)'\)");
    return regex.firstMatch(str)!.group(1)!;
  }

  String? _autoCreate(String str, String cubitType) {
    final RegExp boolRegex = RegExp(r"bool \((\S*)\)");
    final String? extractedValue = boolRegex.firstMatch(str)?.group(1)!;
    if (extractedValue == null) return '';
    if (extractedValue.toLowerCase().contains('true')) {
      return ', autoCreate : true, onAutoCreate : $cubitType(),';
    } else {
      return '';
    }
  }

  String? _id(String str) {
    final RegExp nullRegex = RegExp(r"Null \(null\)");
    final RegExp stringRegex = RegExp(r"String \('(\S*)'\)");

    if (nullRegex.hasMatch(str)) {
      return null;
    } else {
      final String extractedValue = stringRegex.firstMatch(str)!.group(1)!;
      return extractedValue.isNotEmpty ? extractedValue : null;
    }
  }

  String _idParser(String str, String className) {
    String argName = "${className.toLowerCase()}Arguments";
    final RegExp regex = RegExp(r'@\((arg:\S+)\)');
    return str.replaceAllMapped(
        regex, (match) => '\${$argName.${match.group(1)!.split(':')[1]}}');
  }
}
