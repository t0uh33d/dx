/*
----------------------------------------------------------------------------------
|  This file is generated automatically by DX_Router. Modify at your own risk!!!  |
----------------------------------------------------------------------------------
*/


import 'package:dx_router/dx_router.dart';
class DxMultiColorCubitScreen extends DxRoute {
DxMultiColorCubitScreen();
static const String path = "/MultiColorCubitScreen";
@override
bool get hasParams => false;
@override
String get actualPath => path;
@override
String? toUrlFormat() => actualPath;
}

class DxHomePage extends DxRoute {
DxHomePage();
static const String path = "/";
@override
bool get hasParams => false;
@override
String get actualPath => path;
@override
String? toUrlFormat() => actualPath;
}

class DxPage1 extends DxRoute {
final String var1;
final bool checkBool;
final double d;
final int i;
DxPage1({
required this.var1,
required this.checkBool,
required this.d,
required this.i,
});
static const String path = "/Page1";
@override
bool get hasParams => true;
@override
String get actualPath => path;
@override
String? toUrlFormat() => compressedPath({'var1' : var1 ,'checkBool' : checkBool.toString() ,'d' : d.toString() ,'i' : i.toString() ,},actualPath,);
factory DxPage1.fromEnc(Uri uri) {
return DxPage1(
var1 : uri.queryParameters.containsKey('var1') && uri.queryParameters['var1']! != 'null' ? uri.queryParameters['var1']! : '',
checkBool : uri.queryParameters.containsKey('checkBool') && uri.queryParameters['checkBool']! == 'true',
d : uri.queryParameters.containsKey('d') ? double.tryParse(uri.queryParameters['d']!) ?? -1 : -1,
i : uri.queryParameters.containsKey('i') ? int.tryParse(uri.queryParameters['i']!) ?? -1 : -1,
);
}

}

class DxColorCubitPlayer extends DxRoute {
final int index;
DxColorCubitPlayer({
required this.index,
});
static const String path = "/ColorCubitPlayer";
@override
bool get hasParams => true;
@override
String get actualPath => path;
@override
String? toUrlFormat() => compressedPath({'index' : index.toString() ,},actualPath,);
factory DxColorCubitPlayer.fromEnc(Uri uri) {
return DxColorCubitPlayer(
index : uri.queryParameters.containsKey('index') ? int.tryParse(uri.queryParameters['index']!) ?? -1 : -1,
);
}

}

class DxDemoPage extends DxRoute {
DxDemoPage();
static const String path = "/DemoPage";
@override
bool get hasParams => false;
@override
String get actualPath => path;
@override
String? toUrlFormat() => actualPath;
}


