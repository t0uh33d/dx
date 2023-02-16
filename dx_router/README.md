# DX Router

DX Router is a Flutter package that streamlines the process of creating named routes in Flutter applications. By using an easy-to-use annotation above each widget that represents a page, DX Router automates the generation of named routes, making the process of managing routes effortless. With support for URL encoding/decoding, DX Router ensures that parameters being passed are not visible to the user. The package reduces the need to write repetitive code, making deeplinking easier than ever before. DX Router is an efficient, fast and developer-friendly package that streamlines the process of creating named routes in Flutter applications.

## Features

- Automated named route generation
- URL encoding/decoding for secure parameter passing
- Simplified deeplinking
- Supports browser reload for Flutter web

# Getting started

## Installing

To use DX Router in your Flutter project, add the following dependencies to your project's pubspec.yaml file:

```yaml
dependencies:
  dx_router: ^1.0.0
  dx_generator: ^1.0.0
dev_dependencies:
  build_runner: ^2.3.2
```

## Usage
- First create a landing page (First page) of your application and add the following annotation and set `isInitialRoute` to true.


```dart
   @GenerateDxRoute(isInitialRoute: true)
   class HomePage extends StatelessWidget {
    // ...
    }

```

- Then run the following command to generate routes for your application. This command will generate all the neccessary code required to enable named routing in your application and create a method `generateAppRoute()` ,which can be used as shown in the next step.
```sh
flutter packages pub run build_runner build --delete-conflicting-outputs
```


- Now in your `main.dart` file add a parameter `onGenerateRoute` and set its value to ` DxAppRouting.generateAppRoute`. For example :

```dart
return MaterialApp(
   onGenerateRoute: DxAppRouting.generateAppRoute,
   //....
   //...
);
```

- On creating a new page add the annotation `@GenerateDxRoute()`, above the widget which is acting like a page route in your application. For example :

```dart

@GenerateDxRoute()
class ExampleScreenOne extends StatelessWidget {
  // ...
}

```

- Run this command again to update your generated routing code.

```sh
flutter packages pub run build_runner build --delete-conflicting-outputs
```

- The above command generates routes with `Dx` as the prefix to the widget's name. To Navigate the user to that particular screen, you can use `DxRouter.to()` method and provide the widget's name, to which user has to be navigated and pass the current context in the method. For example: 

```dart
DxRouter.to(
    DxExampleScreenOne(

        // If your widget requires arguments, pass them here, like this:
        variable1: 'Dx Router simplifies many things',
    ),
    context,
);
```

- To pop the user from a current page to the previous page, use the `DxRouter.pop()` method and pass the current context in it. For example:

```dart
DxRouter.pop(context);
```

- To override the `Navigator.of(context).pop()` method, wrap every page's root widget with `WillPopScope` widget and `return true`  from the `onWillPop`method,for the initial page of your application `return false` from the `onWillPop`method. 
```
        Note: `onWillPop` method should return false for the initial page.
```
For example: 

```dart
 return WillPopScope(
      onWillPop: () async {
        // if it is not initial page:
        DxRouter.pop(context); // Note: dont add this in an initial page!!
        return true;
        // if it is an initial page:
        return false;
      },
      child: //...
 );
```

- To use this package for Flutter web and handle reload of the webpage, add the `url_strategy` to your project's `pubspec.yaml` file, and also see the next step.
```yaml
dependencies:
    url_strategy: ^0.2.0
``` 
- In your `main.dart` file, in the `main()` method, above the `runApp(...)` function add the following function:

```dart
void main() {
  // add this line
  setPathUrlStrategy();
  runApp(const MyApp());
}
```


## Contributions

Contributions to DX Router are welcome and encouraged! If you find a bug or have an idea for a new feature, please open an issue or submit a pull request. All contributions must adhere to the code of conduct.

## Authors

- [@t0uh33d](https://github.com/t0uh33d)
- [@huzaif-fahad](https://github.com/huzaif-fahad)
