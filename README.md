# Djujo Ink

Flutter mobile implementation for Djujo Ink project.

## Development environment

Setup your development environment with following tool versions:

- [Flutter](https://flutter.dev/docs/get-started/install) - Install 1.22.6 Flutter version from [link](https://flutter.dev/docs/development/tools/sdk/releases)
- Xcode - Install latest version of Xcode
- Android Studio - Install latest version of Android studio. Android studio is used as base tool for development.

### Android keystore info

When building project to Android device you will need have application signed. Environment method is used to read configuration in project.

Add to your environment variables following variables:

- Dev target - DJUDJO_KEYSTORE, DJUDJO_KEYSTORE_PASSWORD, DJUDJO_ALIAS, DJUDJO_ALIAS_PASSWORD
- Prod target - DJUDJO_KEYSTORE, DJUDJO_KEYSTORE_PASSWORD, DJUDJO_ALIAS, DJUDJO_ALIAS_PASSWORD



## How to build project

There are two ways how to build project.

### Using build commands

Go to project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 
```

Project uses following dependencies:

- [provider](https://pub.dev/packages/provider) - State managament dependency
- [http](https://pub.dev/packages/http) - Library for making HTTP requests
- [firebase_dynamic_links](https://pub.dev/packages/firebase_dynamic_links) - Google Dynamic Links for Firebase dependency
- [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) - Flutter plugin to store data in secure storage
- [flutter_spinkit](https://pub.dev/packages/flutter_spinkit) - Collection of loading indicators animated with flutter
- [url_launcher](https://pub.dev/packages/url_launcher) - Flutter plugin for launching a URL
- [flutter_html](https://pub.dev/packages/flutter_html) - Flutter widget for rendering HTML and CSS as Flutter widgets
- [shared_preferences](https://pub.dev/packages/shared_preferences) - Shared preferences plugin
- [toggle_switch](https://pub.flutter-io.cn/packages/toggle_switch) - Customizable simple toggle switch widget
- [social_share_plugin](https://pub.dev/packages/social_share_plugin) - Social Share to Facebook and Instagram Flutter plugin
- [carousel_slider](https://pub.dev/packages/carousel_slider) - Simple carousel slider widget
- [device_info](https://pub.dev/packages/device_info) - Dependency to tet current device information
- [package_info](https://pub.dev/packages/package_info) - Flutter plugin provides an API for querying information about an application package
- [percent_indicator](https://pub.flutter-io.cn/packages/percent_indicator) - Circular and Linear percent indicators
- [get_it](https://pub.dev/packages/get_it) - Simple Locator Service uused for app navigation
- [intl](https://pub.dev/packages/intl) - Internationalization and localization dependency
- [fluttertoast](https://pub.dev/packages/fluttertoast) - Toast Library for Flutter
- [qr_flutter](https://pub.dev/packages/qr_flutter) - Flutter library for simple and fast QR code rendering via a Widget or custom painter
- [date_format](https://pub.dev/packages/date_format) - Simple API to format dates
- [flutter_staggered_grid_view](https://pub.dev/packages/flutter_staggered_grid_view) - Grid view dependency which supports multiple columns with rows
- [flutter_slidable](https://pub.dev/packages/flutter_slidable) - Flutter implementation of slidable list item with directional slide actions that can be dismissed
- [syncfusion_flutter_gauges](https://pub.dev/packages/syncfusion_flutter_gauges) - Powerful dependecy for creating all kinds of gauges and graphs
- [share](https://pub.dev/packages/share) - Plugin to share content from your Flutter app via the platform's share dialog
- [flutter_downloader](https://pub.dev/packages/flutter_downloader) - Plugin for creating and managing download tasks
- [permission_handler](https://pub.dev/packages/permission_handler) - Plugin provides API to request permissions and check their status
- [path_provider](https://pub.dev/packages/path_provider) - Plugin for finding commonly used locations on the filesystem
- [grouped_list](https://pub.flutter-io.cn/packages/grouped_list) - Grouped list package
- [image_picker](https://pub.dev/packages/image_picker) - Plugin for iOS and Android for picking images from the image library, and taking new pictures with the camera
- [google_maps_flutter](https://pub.dev/packages/google_maps_flutter) - Plugin that provides a Google Maps widget
- [google_map_polyline](https://pub.dev/documentation/google_map_polyline/latest/) - Gives polyline coordinates to set polylines in Google Map
- [image](https://pub.dev/packages/image) - A Dart library providing the ability to load, save and manipulate images in a variety of different file formats
- [json_annotation](https://pub.dev/packages/json_annotation) - Defines the annotations used by json_serializable to create code for JSON serialization and deserialization
- [flutter_localizations](https://flutter.dev/docs/development/accessibility-and-localization/internationalization) - Adds support for other languages
- [localizely_sdk](https://pub.dev/packages/localizely_sdk) - Localizely SDK
- [infinite_scroll_pagination](https://pub.dev/packages/infinite_scroll_pagination) - Infinite Scroll Pagination dependency
- [plain_notification_token](https://pub.dev/packages/plain_notification_token) - Get your push notification token via platform way
- [connectivity](https://pub.dev/packages/connectivity) - This plugin allows Flutter apps to discover network connectivity and configure themselves accordingly
- [onesignal_flutter](https://pub.dev/packages/onesignal_flutter) - OneSignal Flutter SDK
- [firebase_crashlytics](https://pub.dev/packages/firebase_crashlytics) - Plugin for Firebase Crashlytics API
- [firebase_analytics](https://pub.dev/packages/firebase_analytics) - Google Analytics for Firebase
- [firebase_core](https://pub.dev/packages/firebase_core) - Plugin to use the Firebase Core API
- [barcode](https://pub.dev/packages/barcode) - Barcode generation library for Dart
- [barcode_widget](https://pub.dev/packages/barcode_widget) - Barcode Widget for flutter
- [flutter_ble_lib](https://pub.dev/packages/flutter_ble_lib) - Library for all your Bluetooth Low Energy needs in Flutter
- [sqflite](https://pub.dev/packages/sqflite) - SQLite plugin for Flutter
- [cached_network_image](https://pub.dev/packages/cached_network_image) - Flutter library to show images from the internet and keep them in the cache directory
- [flutter_svg](https://pub.dev/packages/flutter_svg) - Draw SVG (and some Android VectorDrawable (XML)) files on a Flutter Widget

Project uses following dev dependencies:

- [build_runner](https://pub.dev/packages/build_runner) - Package provides a concrete way of generating files using Dart code
- [json_serializable](https://pub.dev/packages/json_serializable) - Provides Dart Build System builders for handling JSON

When building iOS before creating build we need to execute commandd to update Pod.

```
cd ios
pod repo update
```

#### Android build commands

To prepare build execute followig command for Dev environment in debug mode.

```
flutter build apk --flavor dev -t lib/main_dev.dart --debug
```

To prepare build execuute followig command for Dev environment in release mode.

```
flutter build apk --flavor dev -t lib/main_dev.dart --release
```

To prepare build execute followig command for Prod environment in debug mode.

```
flutter build apk --flavor prod -t lib/main_production.dart --debug
```

To prepare build execuute followig command for Prod environment in release mode.

```
flutter build apk --flavor prod -t lib/main_production.dart --release
```

#### iOS build commands

To prepare build execute followig command for Dev environment in debug mode.

```
flutter build ios --flavor dev -t lib/main_dev.dart --debug
```

To prepare build execuute followig command for Dev environment in release mode.

```
flutter build ios --flavor dev -t lib/main_dev.dart --release
```

To prepare build execute followig command for Prod environment in debug mode.

```
flutter build ios --flavor prod -t lib/main_production.dart --debug
```

To prepare build execuute followig command for Prod environment in release mode.

```
flutter build ios --flavor prod -t lib/main_production.dart --release
```

#### Running build on device via command

The same principle as creating build, we use command run to start application on device.

For example:

```
flutter run apk --flavor dev -t lib/main_dev.dart --debug

flutter run ios --flavor prod -t lib/main_dev.dart --debug
```

### Running app using Android Studio

**Step 1:**

First you need to configure Android Studio configuration for Dev i Prod targets. This is local setup for every developer.

![Dev Debug Configuration](dev_debug_configuration.png)
![Prod Release Configuration](prod_release_configuration.png)

**Step 2:**

Connect your device to machine or select desired simulator for selected configuration and hit run button!

![Android Studio run example](run_configuration_example.png)

## How to prepare builds for production

### iOS preparation

Before standard procedure of deploying iOS application to AppStore connect, execute followig command for Prod environment in release mode, after it continue as standard iOS application ipa release process via Xcode -> Archive.

```
flutter build ios --flavor prod -t lib/main_production.dart --release
```

Warning: Do not execute clean command after executing build command.

After ipa file is uploaded & processed to AppStore connect. Prepare and upload dsyml file for Crashlytics usage. General instructions are:

```
Download appDsyms archive from App Store

1.1 Login: https://appstoreconnect.apple.com

1.2 Go to: MyApps -> Choose your app -> Test Flight -> Select app version that is in the App Store -> Build Metadata -> Includes Symbols (right side) -> Press: Download dSYM. Or go to Xcode -> Window -> Organizer -> Find Archive in Finder -> Right click Show Content -> Download dSYM folder

Open terminal, drag and drop 3 files on terminal on this order:

2.1 drag an drop: "upload-symbols" which can be found in /project/Pods/FirebaseCrashlytics/upload-symbols

2.2 write " -gsp "

2.3 drag an drop: "GoogleService-Info.plist" which can be found in /project/GoogleService-Info.plist

2.4 write " -p ios "

2.5 drag an drop: "appDsyms" folder which usually is in Download folder /Users/username/Downloads/appDsyms (folder not zip file)

2.6 Press Enter

In terminal the complete command should include -gsp and -p ios, full command looks like this: 2.1 -gsp 2.3 -p ios 2.5

Example:

/project/Pods/FirebaseCrashlytics/upload-symbols -gsp /project/GoogleService-Info.plist -p ios /Users/username/Downloads/appDsyms
```

### Android preparation

To prepare apk file for store, use the same command for building Prod environment in release mode .

```
flutter build apk --flavor prod -t lib/main_production.dart --release
```

## CI/CD script - Examples

In project root there is .gitlab-ci.yml file containing examples of command to prepare and send builds in pipeline.
