/// Flutter package to bundle sqlite3 library to your linux apps
library sqlite3_library_linux;

import 'dart:ffi' show DynamicLibrary;
import 'dart:io' show File, Platform;

/// Relative path to default SQLite3 library file
const defaultSQLite3LinuxLibraryPath =
    '/data/flutter_assets/packages/sqlite3_library_linux/default_libsqlite3.so';

/// Relative path to old SQLite3 library file
const oldSQLite3LinuxLibraryPath =
    '/data/flutter_assets/packages/sqlite3_library_linux/old_libsqlite3.so';

/// This function open SQLite3 in memory and return the associated DynamicLibrary.
DynamicLibrary openSQLiteOnLinux() {
  late DynamicLibrary library;

  String executableDirectoryPath =
      File(Platform.resolvedExecutable).parent.path;
  print('executableDirectoryPath: $executableDirectoryPath');
  try {
    String sqliteLibraryPath =
        executableDirectoryPath + defaultSQLite3LinuxLibraryPath;
    print('SQLite3LibraryPath: $sqliteLibraryPath');

    library = DynamicLibrary.open(sqliteLibraryPath);

    print(_yellow("SQLite3 successfully loaded"));
  } catch (e) {
    try {
      print(e);
      //some linux distributions like debian cannot run the first version
      print(_red("Failed to load SQLite3, "
          "trying to load an old version of SQLite3..."));
      String sqliteLibraryPath =
          executableDirectoryPath + oldSQLite3LinuxLibraryPath;
      print('SQLite3LibraryPath: $sqliteLibraryPath');

      library = DynamicLibrary.open(sqliteLibraryPath);

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
  }
  return library;
}

String _red(String string) => '\x1B[31m$string\x1B[0m';

String _yellow(String string) => '\x1B[32m$string\x1B[0m';
