/*
----------------------------------------------------------------------------------
|  This file is generated automatically by DX_Router. Modify at your own risk!!!  |
----------------------------------------------------------------------------------
*/

import 'package:example/screens/homepage.dart';
import 'package:example/screens/page1.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_cubit/get_cubit.dart';

import '../cubits/color_cubit.dart';
import '../cubits/counter_cubit.dart';
import 'routes.dx.dart';

import 'package:dx_router/dx_router.dart';

class DxAppRouting {
  static final DxAppRouting _dxAppRouting = DxAppRouting._internal();

  factory DxAppRouting() => _dxAppRouting;

  DxAppRouting._internal();

  static Route generateAppRoute(RouteSettings routeSettings) {
    routeSettings =
        DxRouter().currRouteSetting(routeSettings, dxRouteConstructorMap);
    switch (routeSettings.name) {
      case DxHomePage.path:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
          settings: DxRouter().getCurrentRouteSetting(routeSettings),
        );

      case DxPage1.path:
        DxPage1 page1Arguments = routeSettings.arguments as DxPage1;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: GetCubit().put(CounterCubit()),
              ),
              BlocProvider.value(
                value: GetCubit().put(ColorCubit()),
              ),
            ],
            child: Page1(
              var1: page1Arguments.var1,
              i: page1Arguments.i,
              checkBool: page1Arguments.checkBool,
              d: page1Arguments.d,
            ),
          ),
          settings: DxRouter().getCurrentRouteSetting(routeSettings),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
          settings: DxRouter().getCurrentRouteSetting(routeSettings),
        );
    }
  }
}

Map<String, DxRouteConstructor?> dxRouteConstructorMap = {
  DxHomePage.path: null,
  DxPage1.path: DxPage1.fromEnc,
};
