library sqlite3_library_linux;

import 'dart:ffi';

import 'package:flutter/foundation.dart';

///relative path to SQLite3 library file when debuging
const sqlite3_linux_debug_libraryPath =
    'build/flutter_assets/packages/sqlite3_library_linux/libsqlite3.so';

///relative path in release bundle to SQLite3 library file
const sqlite3_linux_release_libraryPath =
    'data/flutter_assets/packages/sqlite3_library_linux/libsqlite3.so';

///This function open SQLite3 in memory and return the associated DynamicLibrary
///object.
DynamicLibrary openSQLiteOnLinux() {
  DynamicLibrary library;
  try {
    library = DynamicLibrary.open(getSQLiteLibraryPathOnLinux());

    print(_yellow("SQLite3 successfully loaded"));
  } catch (e) {
    try {
      print(e);
      print(_red("Fail loading SQLite3 from library file, "
          "trying loading from system..."));

      library = DynamicLibrary.open('libsqlite3.so');

      print(_yellow("SQLite3 successfully loaded"));
    } catch (e) {
      print(e);
      print(_red("Fail loading SQLite3."));
    }
  }
  return library;
}

///return path of SQLite3 library file
String getSQLiteLibraryPathOnLinux() {
  return kDebugMode
      ? sqlite3_linux_debug_libraryPath
      : sqlite3_linux_release_libraryPath;
}

String _red(String string) => '\x1B[31m$string\x1B[0m';

String _yellow(String string) => '\x1B[32m$string\x1B[0m';
