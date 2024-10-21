# Flutter Common Components

A collection of essential UI components for Flutter apps. This package provides reusable UI widgets and components that are commonly used in many apps, helping you speed up development and maintain consistency across your projects.

## Features

- **Pre-built UI Components**: Ready-to-use widgets for common UI elements like buttons, text fields, dialogs, and more.
- **Customizable**: All components are highly customizable to fit the look and feel of your app.
- **Consistent Design**: Keep your app's design consistent and clean by using standardized components.

## Installation

Add the following line to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_common_components: ^1.0.1
```

Run `flutter pub get` to install the package.

## Usage

Simply import the package and start using the provided components:

```dart
import 'package:flutter_common_components/flutter_common_components.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Common Components'),
        ),
        body: Center(
          child: GradientFillButton(
            state: ButtonStateModel.loading,
            areIconsClose: true,
            text: "Test",
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
```

## Components

- **Buttons**: CommonButton, GradientFillButton, etc.
- **Text Fields**: CommonTextField, PasswordField, etc.
- **Dialogs**: CommonAlertDialog, ConfirmationDialog, etc.
- **Snackbars**: CommonSnackbar for displaying quick messages.
- **And More**: More reusable UI components that are frequently needed in mobile applications.

## Example

Check out the [example directory](https://github.com/Abubakarshaikh/flutter_common_components/tree/main/example) for a full example of how to use the components in your app.

## Contributing

Feel free to submit issues and pull requests. Contributions are always welcome!

## License

This package is licensed under the MIT License. See the [LICENSE](https://github.com/Abubakarshaikh/flutter_common_components/blob/main/LICENSE) file for more details.