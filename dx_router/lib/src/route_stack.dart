part of router_impl;

class _DxRouteStack {
  final List<String> _stack = [];
  int _rsp = -1;

  void push(String path) {
    _stack.add(path);
    _rsp++;
  }

  String? pop() {
    if (isEmpty) return null;
    String _x = _stack.removeLast();
    _rsp--;
    return _x;
  }

  void clear() {
    _stack.clear();
    _rsp = -1;
  }

  void popUntil(String path) {
    if (!_canPop(path)) return;
    int idx = _stack.length - 1;
    for (; idx >= 0; idx--) {
      if (_stack[idx] == path) break;
      _stack.removeLast();
    }
    _rsp = idx;
  }

  bool _canPop(String path) =>
      _stack.isNotEmpty &&
      _rsp > -1 &&
      _stack.length > 1 &&
      _stack.contains(path);

  bool get isEmpty => _stack.isEmpty;

  void printRouteStack() => print(_stack.toString());

  String getCurrentPath() {
    String path = '';
    for (int idx = 0; idx < _stack.length; idx++) {
      path += idx == 0 ? _stack[idx].replaceAll('/', '') : _stack[idx];
    }
    return path;
  }
}
