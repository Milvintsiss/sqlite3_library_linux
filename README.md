# SQLite3 library for linux

This package help you bundle SQLite3 library to your apps.

He was originally developed to use with moor but you can use it for others use cases that need SQLite3.

## How to use with Moor

Be sure to follow all the steps to migrate from moor_flutter to moor ffi ([doc](https://moor.simonbinder.eu/docs/other-engines/vm/)).

Open an override for linux:

    import 'dart:ffi';
    import 'dart:io';
    import 'package:sqlite3/sqlite3.dart';
    import 'package:sqlite3/open.dart';
	import 'package:sqlite3_library_linux/sqlite3_library_linux.dart';
    
    void main() {
      open.overrideFor(OperatingSystem.linux, openSQLiteOnLinux);
    
      final db = sqlite3.openInMemory();
      db.dispose();
	  
	  runApp(MyApp());
    }

And... that's it! No need to provide your own sqlite3.so file🙂