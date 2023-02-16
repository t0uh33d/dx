# DX Router

DX Router is a Flutter package that streamlines the process of creating named routes in Flutter applications. By using an easy-to-use annotation above each widget that represents a page, DX Router automates the generation of named routes, making the process of managing routes effortless. With support for URL encoding/decoding, DX Router ensures that parameters being passed are not visible to the user. The package reduces the need to write repetitive code, making deeplinking easier than ever before. DX Router is an efficient, fast and developer-friendly package that streamlines the process of creating named routes in Flutter applications.

## Features

- Automated named route generation
- URL encoding/decoding for secure parameter passing
- Simplified deeplinking
- Supports browser reload for Flutter web

## Getting started

### Installing

To use DX Router in your Flutter project, add the following dependencies to your project's pubspec.yaml file:

```yaml
dependencies:
  dx_router: ^1.0.0
  dx_generator: ^1.0.0
dev_dependencies:
  build_runner: ^2.3.2
```

### Usage

Add the `@GenerateDxRoute` annotation above each widget that represents a page in your application. For example:

```dart
@GenerateDxRoute()
class HomePage extends StatelessWidget {
  // ...
}
```

If you want to specify a page as an initial route, add `isInitialRoute: true` to the annotation:

```dart
@GenerateDxRoute(isInitialRoute: true)
class HomePage extends StatelessWidget {
  // ...
}
```

Run the following command from the directory of your project to generate the named routes:

```sh
flutter packages pub run build_runner build --delete-conflicting-outputs
```

Use the named routes in your application:

```dart
DxRouter.to(DxScreenOne(),context);
```

## Contributions

Contributions to DX Router are welcome and encouraged! If you find a bug or have an idea for a new feature, please open an issue or submit a pull request. All contributions must adhere to the code of conduct.

## Authors

- [@t0uh33d](https://github.com/t0uh33d)
- [@huzaif-fahad](https://github.com/huzaif-fahad)
