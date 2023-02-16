import 'package:dx_generator/dx_generator.dart';
import 'package:dx_router/dx_router.dart';
import 'package:flutter/material.dart';

@GenerateDxRoute()
class Page1 extends StatelessWidget {
  Page1({
    super.key,
    required this.var1,
    required this.checkBool,
    required this.d,
    required this.i,
  });

  String var1 = '';
  int i;
  bool checkBool;
  double d;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(var1),
            ElevatedButton(
                onPressed: () {
                  DxRouter.pop(context);
                },
                child: Text("POP")),
            Text(checkBool.toString()),
            Text(d.toString()),
            Text(i.toString()),
          ],
        ),
      ),
    );
  }
}
