/*
----------------------------------------------------------------------------------
|  This file is generated automatically by DX_Router. Modify at your own risk!!!  |
----------------------------------------------------------------------------------
*/


import 'package:dx_router/dx_router.dart';
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
final int i;
final bool checkBool;
final double d;
DxPage1({
required this.var1,
required this.i,
required this.checkBool,
required this.d,
});
static const String path = "/Page1";
@override
bool get hasParams => true;
@override
String get actualPath => path;
@override
String? toUrlFormat() => compressedPath({'var1' : var1 ,'i' : i.toString() ,'checkBool' : checkBool.toString() ,'d' : d.toString() ,},actualPath,);
factory DxPage1.fromEnc(Uri uri) {
return DxPage1(
var1 : uri.queryParameters.containsKey('var1') && uri.queryParameters['var1']! != 'null' ? uri.queryParameters['var1']! : '',
i : uri.queryParameters.containsKey('i') ? int.tryParse(uri.queryParameters['i']!) ?? -1 : -1,
checkBool : uri.queryParameters.containsKey('checkBool') && uri.queryParameters['checkBool']! == 'true',
d : uri.queryParameters.containsKey('d') ? double.tryParse(uri.queryParameters['d']!) ?? -1 : -1,
);
}

}


