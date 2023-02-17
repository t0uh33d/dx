/*
----------------------------------------------------------------------------------
|  This file is generated automatically by DX_Router. Modify at your own risk!!!  |
----------------------------------------------------------------------------------
*/

import 'package:example/screens/multi_color_cubit_screen.dart';
import 'package:example/screens/homepage.dart';
import 'package:example/screens/page1.dart';
import 'package:example/screens/color_cubit_player.dart';
import 'package:example/screens/demo.dart';

import 'package:flutter/material.dart';

import 'routes.dx.dart';

import 'package:dx_router/dx_router.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_cubit/get_cubit.dart';
import 'package:example/cubits/counter_cubit.dart';
import 'package:example/cubits/color_cubit.dart';

class DxAppRouting {
  static final DxAppRouting _dxAppRouting = DxAppRouting._internal();

  factory DxAppRouting() => _dxAppRouting;

  DxAppRouting._internal();

  static Route generateAppRoute(RouteSettings routeSettings) {
    routeSettings =
        DxRouter().currRouteSetting(routeSettings, dxRouteConstructorMap);
    switch (routeSettings.name) {
      case DxMultiColorCubitScreen.path:
        return MaterialPageRoute(
          builder: (_) => const MultiColorCubitScreen(),
          settings: DxRouter().getCurrentRouteSetting(routeSettings),
        );

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
              ],
              child: Page1(
                var1: page1Arguments.var1,
                checkBool: page1Arguments.checkBool,
                d: page1Arguments.d,
                i: page1Arguments.i,
              )),
          settings: DxRouter().getCurrentRouteSetting(routeSettings),
        );

      case DxColorCubitPlayer.path:
        DxColorCubitPlayer colorcubitplayerArguments =
            routeSettings.arguments as DxColorCubitPlayer;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: GetCubit().find<ColorCubit>(
                    id: '${colorcubitplayerArguments.index}',
                    autoCreate: false,
                    onAutoCreate: ColorCubit(),
                  ),
                ),
              ],
              child: ColorCubitPlayer(
                index: colorcubitplayerArguments.index,
              )),
          settings: DxRouter().getCurrentRouteSetting(routeSettings),
        );

      case DxDemoPage.path:
        return MaterialPageRoute(
          builder: (_) => const DemoPage(),
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
  DxMultiColorCubitScreen.path: null,
  DxHomePage.path: null,
  DxPage1.path: DxPage1.fromEnc,
  DxColorCubitPlayer.path: DxColorCubitPlayer.fromEnc,
  DxDemoPage.path: null,
};
