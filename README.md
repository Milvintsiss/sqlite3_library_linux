[![pub package](https://img.shields.io/pub/v/sqlite3_library_linux)](https://pub.dev/packages/sqlite3_library_linux)

# This package is no longer maintained.

### This package was created to provide a simple way to bundle sqlite3 with your apps on Linux as [sqlite3_flutter_libs](https://pub.dev/packages/sqlite3_flutter_libs) didn't provide support for this platform. This is no longer the case so I recommend the use of [sqlite3_flutter_libs](https://pub.dev/packages/sqlite3_flutter_libs). Thanks to [Simolus](https://github.com/simolus3) for this update!





# SQLite3 library for linux

This package help you bundle SQLite3 library to your apps.

It can be used with packages like Moor to make the SQLite opening process easier (See: [How to use with Moor](#how-to-use-with-moor)). 


## How to use

Add an override for linux and give it the `openSQLiteOnLinux` function provided by the package:

```dart
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3/open.dart';
import 'package:sqlite3_library_linux/sqlite3_library_linux.dart';
 
late final Database db;
void main() {
  open.overrideFor(OperatingSystem.linux, openSQLiteOnLinux);
    
  // For database file creation and more please see the example
  db = sqlite3.open([YOUR_DB_FILE]);
     
  runApp(MyApp());
}
```

And... that's it! No need to provide your own sqlite3.so file 🙂

## How to use with Moor

Be sure to follow all the steps to migrate from moor_flutter to moor ffi ([docs](https://moor.simonbinder.eu/docs/other-engines/vm/)).

Then add an override for linux and give it the `openSQLiteOnLinux` function provided the package:

```dart
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3/open.dart';
import 'package:sqlite3_library_linux/sqlite3_library_linux.dart';
 
void main() {
  open.overrideFor(OperatingSystem.linux, openSQLiteOnLinux);
  final db = sqlite3.openInMemory();
  db.dispose();
     
  runApp(MyApp());
}
```

### Contributing

**For the moment the package does not provide support for arm64 architectures, if you need it feel free to do a pull request!**

*The package as been tested for Ubuntu 20.04 and Debian 10, it should work on others distributions too, but if you have any issue using the package please [report](https://github.com/Milvintsiss/sqlite3_library_linux/issues) it.*