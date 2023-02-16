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
            isInitialRoute: ele.annotation.read('isInitialRoute').boolValue);
        dxAnnotatedClasses.add(dxAnnonatedClass);
      }
    }
    return dxAnnotatedClasses;
  }
}
