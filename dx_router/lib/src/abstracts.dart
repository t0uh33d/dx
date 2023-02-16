part of router_impl;

class DxRoute {
  String get actualPath => '';

  bool get hasParams => false;

  String? toUrlFormat() => null;

  /// used to encode path into a base64 string
  String? _encodePATH(String path) {
    return base64Url.encode(utf8.encode(path));
  }

  /// decode a base64 string to an app route
  static String decodePATH(String encodedPATH) {
    return utf8.decode(base64Url.decode(encodedPATH));
  }

  String? compressedPath(Map<String, dynamic> map, String path) {
    return "/${_encodePATH(Uri(path: path, queryParameters: map).toString())!}";
  }
}
