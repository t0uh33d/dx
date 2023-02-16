// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:source_gen/source_gen.dart';

class DxRouteClassVisitor extends SimpleElementVisitor {
  DartType? className;
  Map<String, DartType>? params = {};

  @override
  void visitConstructorElement(ConstructorElement element) {
    className = element.type.returnType;
  }

  @override
  visitFieldElement(FieldElement element) {
    params![element.name] = element.type;
  }
}

class DxAnnotatedClass {
  final String className;
  final Map<String, DartType>? params;
  final ConstantReader constantReader;
  final String importPath;
  final String relativePath;
  final bool isInitialRoute;
  DxAnnotatedClass({
    required this.className,
    required this.params,
    required this.constantReader,
    required this.importPath,
    required this.relativePath,
    required this.isInitialRoute,
  });
}
