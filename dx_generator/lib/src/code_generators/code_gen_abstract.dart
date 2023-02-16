import 'dart:io';

import '../dx_route_class_visitor.dart';
import '../helpers/logger.dart';

abstract class CodeGenerator {
  String modifyComment = """
/*
----------------------------------------------------------------------------------
|  This file is generated automatically by DX_Router. Modify at your own risk!!!  |
----------------------------------------------------------------------------------
*/
""";

  String routerPackageImport =
      "import 'package:dynamic_router_package/dynamic_router_package.dart';";

  String annotatedClassImports(
    List<DxAnnotatedClass> dxAnnonatedClasses,
  ) {
    Set<String> uniqueImports = {};
    StringBuffer importsBuffer = StringBuffer();
    for (int idx = 0; idx < dxAnnonatedClasses.length; idx++) {
      uniqueImports.add(dxAnnonatedClasses[idx].importPath);
    }
    for (int idx = 0; idx < uniqueImports.length; idx++) {
      importsBuffer.writeln(uniqueImports.elementAt(idx));
    }

    return importsBuffer.toString();
  }

  Future<void> formatGeneratedFiles() async {
    ProcessResult result = await Process.run('dart format .', [],
        runInShell: true, workingDirectory: 'lib/dx_router_gen');
    if (result.exitCode == 0) {
      Logger.log(
        "Code Formatted Successfully!!",
        loggerColor: LoggerColor.green,
      );
    } else {
      Logger.log(
        "Formatting failed :( Please Format manually!",
        loggerColor: LoggerColor.yellow,
      );
    }
  }

  String generate(List<DxAnnotatedClass> dxAnnonatedClasses) => modifyComment;
}
