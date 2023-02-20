// ignore_for_file: avoid_print, library_names

library DxRouterGenerator;

import 'dart:async';
import 'package:analyzer/dart/constant/value.dart';
import 'package:build/build.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:glob/glob.dart';
import 'package:source_gen/source_gen.dart';
import 'package:path/path.dart' as path;

import 'code_generators/app_routing_code_generator.dart';
import 'code_generators/dx_route_code_generator.dart';
import 'dx_annotations.dart';
import 'dx_route_class_visitor.dart';
import 'helpers/logger.dart';

// part 'library_helpers.dart';
part 'library_helpers.dart';

// custom builder

class DxBuilder extends Builder {
  BuilderOptions? builderOptions;
  DxBuilder(this.builderOptions);

  @override
  Map<String, List<String>> get buildExtensions => {
        r'$lib$': ['dx_gen/routes.dx.dart', 'dx_gen/app_routing.dx.dart']
      };

  @override
  Future<void> build(BuildStep buildStep) async {
    List<DxAnnotatedClass> annotatedClasses =
        await _getDxAnnotatedClasses(buildStep);

    List<MarkedCubit> markedCubits = await _getMarkedCubits(buildStep);

    // code generator class instances
    DxRoutesGenerator dxRoutesGenerator = DxRoutesGenerator();
    DxAppRoutingGenerator dxAppRoutingGenerator = DxAppRoutingGenerator();

    String dxRoutesClassesCode = dxRoutesGenerator.generate(annotatedClasses);

    AssetId routesFile = AssetId(buildStep.inputId.package,
        path.join('lib', 'dx_gen', 'routes.dx.dart'));
    await buildStep.writeAsString(routesFile, dxRoutesClassesCode);
    Logger.log(
      "Generated DX routes successfully ==> (lib/dx_gen/routes.dx.dart)",
      loggerColor: LoggerColor.green,
    );

    String dxAppRoutingClassCode = dxAppRoutingGenerator
        .generate(annotatedClasses, markedCubits: markedCubits);

    AssetId appRoutingFile = AssetId(buildStep.inputId.package,
        path.join('lib', 'dx_gen', 'app_routing.dx.dart'));
    await buildStep.writeAsString(appRoutingFile, dxAppRoutingClassCode);

    Logger.log("SUCCESS!!!!", loggerColor: LoggerColor.green);
  }
}
