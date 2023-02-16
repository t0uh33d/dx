import 'package:dx_generator/dx_generator.dart';
import 'package:dx_router/dx_router.dart';
import 'package:example/dx_gen/routes.dx.dart';
import 'package:flutter/material.dart';

@GenerateDxRoute(isInitialRoute: true)
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Dx Router",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            ElevatedButton(
                onPressed: () {
                  DxRouter.to(
                      DxPage1(
                        var1: 'This is the best router',
                        checkBool: false,
                        d: 1.8667,
                        i: 1,
                      ),
                      context);
                },
                child: const Text(
                  "To Page 1, with arguments",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
