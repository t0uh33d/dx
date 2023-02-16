// ignore_for_file: public_member_api_docs, sort_constructors_first
library router_impl;

import 'package:flutter/material.dart';
import 'dart:convert';

part 'abstracts.dart';
part 'route_stack.dart';
part 'typedefs.dart';

class DxRouter {
  static final DxRouter _dxRouter = DxRouter._interal();

  factory DxRouter() => _dxRouter;

  DxRouter._interal();

  static final _DxRouteStack _dxRouteStack = _DxRouteStack();

  void _pushToStack(RouteSettings routeSettings) {
    if (routeSettings.name == '/') return;
    if (routeSettings.arguments == null) {
      _dxRouteStack.push(routeSettings.name!);
      return;
    }
    _dxRouteStack.push((routeSettings.arguments as DxRoute).toUrlFormat()!);
  }

  static void to<T extends DxRoute>(T route, BuildContext context) {
    Navigator.of(context).pushNamed(
      route.actualPath,
      arguments: route,
    );
  }

  static void pop(BuildContext context) {
    if (_dxRouteStack.pop() != null) {
      Navigator.of(context).pop();
    }
  }

  RouteSettings getCurrentRouteSetting(RouteSettings routeSettings) {
    return RouteSettings(
      name: _dxRouteStack.getCurrentPath(),
      arguments: routeSettings.arguments,
    );
  }

  RouteSettings currRouteSetting(RouteSettings routeSettings,
      Map<String, DxRouteConstructor?> dxRouteConstructorMap) {
    RouteSettings crs = _currRouteSetting(routeSettings, dxRouteConstructorMap);
    _pushToStack(crs);
    return crs;
  }

  RouteSettings _currRouteSetting(RouteSettings routeSettings,
      Map<String, DxRouteConstructor?> dxRouteConstructorMap) {
    if (routeSettings.arguments != null ||
        dxRouteConstructorMap.containsKey(routeSettings.name)) {
      return routeSettings;
    }
    String currPath = _currRoute(routeSettings.name!);
    if (dxRouteConstructorMap.containsKey(currPath)) {
      return RouteSettings(
        name: currPath,
        arguments: routeSettings.arguments,
      );
    }
    String path = DxRoute.decodePATH(currPath.replaceAll('/', ''));
    Uri uri = Uri.parse(path);
    if (dxRouteConstructorMap.containsKey(uri.path)) {
      return RouteSettings(
        name: uri.path,
        arguments: dxRouteConstructorMap[uri.path]!(uri),
      );
    }
    return routeSettings;
  }

  String _currRoute(String url) {
    String tmp = '';
    for (int idx = url.length - 1; idx > 0; idx--) {
      tmp = url[idx] + tmp;
      if (url[idx] == '/') break;
    }
    return tmp;
  }

  void printStack() => _dxRouteStack.printRouteStack();
}
