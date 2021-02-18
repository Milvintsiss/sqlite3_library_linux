library sqlite3_library_linux;

import 'dart:ffi' show DynamicLibrary;
import 'dart:io' show File;
import 'package:flutter/foundation.dart' show kDebugMode;

///relative path to SQLite3 library file when debuging
const sqlite3_linux_debug_libraryPath =
    'build/flutter_assets/packages/sqlite3_library_linux/libsqlite3.so';

///relative path in release bundle to SQLite3 library file
const sqlite3_linux_release_libraryPath =
    'data/flutter_assets/packages/sqlite3_library_linux/libsqlite3.so';

///This function open SQLite3 in memory and return the associated DynamicLibrary
///object.
///
/// You can obtain [sqliteLibraryPath] by running [getSQLiteLibraryPathOnLinux]
DynamicLibrary openSQLiteOnLinux() {
  DynamicLibrary library;
  try {
    library = DynamicLibrary.open(getSQLiteLibraryPathOnLinux());

    print(_yellow("SQLite3 successfully loaded"));
  } catch (e) {
    try {
      print(e);
      print(_red("Failed to load SQLite3 from library file, "
          "trying loading from system..."));

      library = DynamicLibrary.open('libsqlite3.so');

      print(_yellow("SQLite3 successfully loaded"));
    } catch (e) {
      print(e);
      print(_red("Failed to load SQLite3."));
    }
  }
  return library;
}

///return path of SQLite3 library file
String getSQLiteLibraryPathOnLinux() {
  String linuxDistribution = getLinuxDistribution();
  print('Linux distribution: $linuxDistribution');

  switch (linuxDistribution) {
    case 'ubuntu':
      return defaultSQLite3library();
      break;
    default:
      return defaultSQLite3library();
  }
}

String defaultSQLite3library() => kDebugMode
    ? sqlite3_linux_debug_libraryPath
    : sqlite3_linux_release_libraryPath;

String getLinuxDistribution() {
  String linuxDistribution;
  try {
    final List<String> osEtc = File('/etc/os-release').readAsLinesSync();
    linuxDistribution =
        osEtc.firstWhere((element) => element.indexOf("ID=") == 0);
    if (linuxDistribution != null)
      linuxDistribution = linuxDistribution.substring(3).toLowerCase();
    else
      throw Exception;
  } catch (e) {
    try {
      final List<String> osUsr = File('/usr/lib/os-release').readAsLinesSync();
      linuxDistribution =
          osUsr.firstWhere((element) => element.indexOf("ID=") == 0);
      if (linuxDistribution != null)
        linuxDistribution = linuxDistribution.substring(3).toLowerCase();
      else
        throw Exception;
    } catch (e) {
      try {
        final List<String> lsb = File('/etc/lsb-release').readAsLinesSync();
        linuxDistribution =
            lsb.firstWhere((element) => element.indexOf("DISTRIB_ID=") == 0);
        if (linuxDistribution != null)
          linuxDistribution = linuxDistribution.substring(11).toLowerCase();
        else
          throw Exception;
      } catch (e) {
        print(_red("Error getting Linux distribution name"));
        linuxDistribution = 'linux';
      }
    }
  }
  return linuxDistribution;
}

String _red(String string) => '\x1B[31m$string\x1B[0m';

String _yellow(String string) => '\x1B[32m$string\x1B[0m';
