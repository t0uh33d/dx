import 'package:analyzer/dart/element/type.dart';

import '../dx_route_class_visitor.dart';
import 'code_gen_abstract.dart';

class DxRoutesGenerator extends CodeGenerator {
  // DX Routes class generator method ==> routes.dx.dart
  @override
  String generate(List<DxAnnotatedClass> dxAnnonatedClasses) {
    StringBuffer fileCodeBuffer = StringBuffer();
    for (int idx = 0; idx < dxAnnonatedClasses.length; idx++) {
      fileCodeBuffer.writeln(_generateDxIndividualRouteCode(
          dxAnnonatedClasses[idx].className,
          dxAnnonatedClasses[idx].params,
          dxAnnonatedClasses[idx].isInitialRoute));
    }

    return '''
$modifyComment

$routerPackageImport
${fileCodeBuffer.toString()}
''';
  }

  String _generateDxIndividualRouteCode(
      String className, Map<String, DartType>? params, bool isInitialRoute) {
    StringBuffer codeOutputBuffer = StringBuffer();

    String dxClassName = "Dx$className";
    codeOutputBuffer.writeln("class $dxClassName extends DxRoute {");
    params!.forEach((key, value) {
      codeOutputBuffer.writeln('final $value $key;');
    });
    if (params.isEmpty) {
      codeOutputBuffer.writeln("$dxClassName();");
    } else {
      codeOutputBuffer.writeln("$dxClassName({");
      params.forEach((key, value) {
        codeOutputBuffer.writeln(
            '${!value.toString().contains('?') ? 'required ' : ''}this.$key,');
      });
      codeOutputBuffer.writeln("});");
    }
    codeOutputBuffer.writeln(
        'static const String path = "/${isInitialRoute ? '' : className}";');
    codeOutputBuffer.writeln('@override');
    codeOutputBuffer.writeln('bool get hasParams => ${params.isNotEmpty};');
    codeOutputBuffer.writeln('@override');
    codeOutputBuffer.writeln('String get actualPath => path;');
    codeOutputBuffer.writeln("@override");
    if (params.isEmpty) {
      codeOutputBuffer.writeln("String? toUrlFormat() => actualPath;");
    } else {
      codeOutputBuffer.writeln(
          "String? toUrlFormat() => compressedPath(${_generateParamsMap(params)},actualPath,);");
    }
    if (params.isNotEmpty) {
      codeOutputBuffer.writeln(_generateFactoryConstructor(className, params));
    }

    codeOutputBuffer.writeln('}');
    return codeOutputBuffer.toString();
  }

  String _generateFactoryConstructor(
    String className,
    Map<String, DartType> param,
  ) {
    StringBuffer fcBuffer = StringBuffer();
    fcBuffer.writeln('factory Dx$className.fromEnc(Uri uri) {');
    fcBuffer.writeln('return Dx$className(');
    param.forEach((key, value) => fcBuffer.writeln('${_fcParam(key, value)},'));
    fcBuffer.writeln(');');
    fcBuffer.writeln('}');
    return fcBuffer.toString();
  }

  String _fcParam(String varName, DartType varType) {
    String fcParam = '$varName : ';
    bool isNullabe = varType.toString().contains('?');
    String containsKey = "uri.queryParameters.containsKey('$varName')";
    String queryParamVar = "uri.queryParameters['$varName']!";
    if (varType.isDartCoreBool) {
      fcParam += "$containsKey && $queryParamVar == 'true'";
    } else if (varType.isDartCoreInt) {
      fcParam +=
          _fcParamValNumExt(containsKey, queryParamVar, isNullabe, 'int');
    } else if (varType.isDartCoreDouble) {
      fcParam +=
          _fcParamValNumExt(containsKey, queryParamVar, isNullabe, 'double');
    } else if (varType.isDartCoreString) {
      fcParam +=
          "$containsKey && $queryParamVar != 'null' ? $queryParamVar : ${isNullabe ? 'null' : '\'\''}";
    } else if (varType.isDartCoreNum) {
      fcParam +=
          _fcParamValNumExt(containsKey, queryParamVar, isNullabe, 'num');
    }
    return fcParam;
  }

  String _fcParamValNumExt(String containsKey, String queryParamVar,
          bool isNullabe, String type) =>
      "$containsKey ? $type.tryParse($queryParamVar) ${isNullabe ? '' : '?? -1'} : ${isNullabe ? 'null' : -1}";

  String? _generateParamsMap(Map<String, DartType>? params) {
    String mpStr = '{';
    params!.forEach((key, value) => mpStr +=
        "'$key' : ${key + (value.isDartCoreString ? '' : '.toString()')} ,");
    return '$mpStr}';
  }
}
