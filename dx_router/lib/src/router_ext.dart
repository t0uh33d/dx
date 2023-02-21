part of router_impl;

extension RouterExt on BuildContext {
  void dxPush<T extends DxRoute>(T route) => DxRouter.to(route, this);

  void dxPop() => DxRouter.pop(this);

  void dxPopUntil(String dxScreenPath) => DxRouter.popUntil(dxScreenPath, this);

  void dxPopAndPush<T extends DxRoute>(T route) =>
      DxRouter.popAndPush(route, this);
}
